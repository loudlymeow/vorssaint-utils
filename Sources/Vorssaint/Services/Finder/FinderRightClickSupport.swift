// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import AppKit
import Foundation

enum FinderRightClickPathFormatter {
    static func joinedPaths(_ urls: [URL]) -> String {
        urls.map(\.path).joined(separator: "\n")
    }

    static func joinedFileNames(_ urls: [URL]) -> String {
        urls.map(\.lastPathComponent).joined(separator: "\n")
    }

    static func joinedShellEscapedPaths(_ urls: [URL]) -> String {
        urls.map { shellEscaped($0.path) }.joined(separator: " ")
    }

    static func shellEscaped(_ path: String) -> String {
        "'" + path.replacingOccurrences(of: "'", with: "'\\''") + "'"
    }
}

enum FinderRightClickTargetResolver {
    static func targetDirectory(selectedURLs: [URL], targetedURL: URL?) -> URL? {
        if let first = selectedURLs.first {
            return directory(for: first)
        }
        if let targetedURL {
            return directory(for: targetedURL)
        }
        return nil
    }

    static func directory(for url: URL) -> URL {
        isDirectory(url) ? url : url.deletingLastPathComponent()
    }

    static func isDirectory(_ url: URL) -> Bool {
        var isDirectory = ObjCBool(false)
        return FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory)
            && isDirectory.boolValue
    }
}

enum FinderRightClickFileNamePlanner {
    static func nextAvailableURL(in directory: URL,
                                 baseName: String,
                                 pathExtension: String?) -> URL {
        let trimmed = baseName.trimmingCharacters(in: .whitespacesAndNewlines)
        let sanitized = trimmed.isEmpty ? "Untitled" : trimmed
        let normalizedExtension = pathExtension?
            .trimmingCharacters(in: CharacterSet(charactersIn: "."))
            .lowercased()

        func candidate(_ index: Int?) -> URL {
            let name = index.map { "\(sanitized) \($0)" } ?? sanitized
            let url = directory.appendingPathComponent(name, isDirectory: false)
            guard let normalizedExtension, !normalizedExtension.isEmpty else { return url }
            return url.appendingPathExtension(normalizedExtension)
        }

        let manager = FileManager.default
        var url = candidate(nil)
        guard manager.fileExists(atPath: url.path) else { return url }
        var index = 2
        repeat {
            url = candidate(index)
            index += 1
        } while manager.fileExists(atPath: url.path)
        return url
    }
}

enum FinderRightClickActionError: LocalizedError, Equatable {
    case directoryUnavailable(String)
    case cannotCreateFile(String)
    case unsupportedFileExtension(String)
    case missingTemplate(String)

    var errorDescription: String? {
        switch self {
        case .directoryUnavailable(let path): return "Directory unavailable: \(path)"
        case .cannotCreateFile(let path): return "Cannot create file: \(path)"
        case .unsupportedFileExtension(let ext): return "Unsupported file type: \(ext)"
        case .missingTemplate(let ext): return "Missing template for: \(ext)"
        }
    }
}

struct FinderRightClickFileActionService {
    var fileManager: FileManager = .default
    var workspace: NSWorkspace = .shared
    var templateBundle: Bundle = .main

    func createFile(in directory: URL,
                    extension fileExtension: String,
                    baseName: String) throws -> URL {
        let ext = fileExtension.lowercased()
        guard FinderRightClickNewFile.isSupportedExtension(ext) else {
            throw FinderRightClickActionError.unsupportedFileExtension(ext)
        }
        guard FinderRightClickTargetResolver.isDirectory(directory) else {
            throw FinderRightClickActionError.directoryUnavailable(directory.path)
        }

        let fileURL = FinderRightClickFileNamePlanner.nextAvailableURL(
            in: directory,
            baseName: baseName,
            pathExtension: ext
        )
        guard fileURL.deletingLastPathComponent().standardizedFileURL.path
                == directory.standardizedFileURL.path else {
            throw FinderRightClickActionError.cannotCreateFile(fileURL.path)
        }

        switch ext {
        case "txt", "md":
            do {
                try Data().write(to: fileURL, options: .withoutOverwriting)
            } catch {
                throw FinderRightClickActionError.cannotCreateFile(fileURL.path)
            }
        case "docx", "xlsx", "pptx":
            guard let template = templateURL(for: ext) else {
                throw FinderRightClickActionError.missingTemplate(ext)
            }
            do {
                try fileManager.copyItem(at: template, to: fileURL)
            } catch {
                throw FinderRightClickActionError.cannotCreateFile(fileURL.path)
            }
        default:
            throw FinderRightClickActionError.unsupportedFileExtension(ext)
        }

        workspace.activateFileViewerSelecting([fileURL])
        return fileURL
    }

    private func templateURL(for ext: String) -> URL? {
        let name = "untitled"
        if let url = templateBundle.url(forResource: name,
                                        withExtension: ext,
                                        subdirectory: "FinderRightClick/Templates") {
            return url
        }
        return templateBundle.url(forResource: name, withExtension: ext)
    }
}

enum FinderRightClickUntitledName {
    static func baseName(preferredLanguages: [String]?) -> String {
        let code = (preferredLanguages?.first ?? "en")
            .replacingOccurrences(of: "_", with: "-")
            .lowercased()
        if code.hasPrefix("zh") { return "未命名" }
        if code.hasPrefix("ja") { return "名称未設定" }
        if code.hasPrefix("ko") { return "무제" }
        if code.hasPrefix("de") { return "Ohne Titel" }
        if code.hasPrefix("fr") { return "Sans titre" }
        if code.hasPrefix("es") { return "Sin título" }
        if code.hasPrefix("pt") { return "Sem título" }
        if code.hasPrefix("it") { return "Senza titolo" }
        if code.hasPrefix("ru") { return "Без названия" }
        if code.hasPrefix("uk") { return "Без назви" }
        if code.hasPrefix("tr") { return "Adsız" }
        if code.hasPrefix("sk") { return "Bez názvu" }
        return "Untitled"
    }
}
