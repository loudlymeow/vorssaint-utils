// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import Foundation

/// Shared Finder right-click preferences.
///
/// The host writes this JSON under Application Support. The sandboxed Finder
/// Sync extension reads it through a home-relative temporary exception. Both
/// sides resolve the real home via `getpwuid` so sandbox container redirection
/// cannot split the path.
struct FinderRightClickConfiguration: Codable, Equatable {
    var menuEnabled: Bool
    var preferredLanguages: [String]?
    var newFile: Bool
    var copyFileName: Bool
    var copyAbsolutePath: Bool
    var copyShellEscapedPath: Bool

    init(menuEnabled: Bool = false,
         preferredLanguages: [String]? = nil,
         newFile: Bool = true,
         copyFileName: Bool = true,
         copyAbsolutePath: Bool = true,
         copyShellEscapedPath: Bool = true) {
        self.menuEnabled = menuEnabled
        self.preferredLanguages = preferredLanguages
        self.newFile = newFile
        self.copyFileName = copyFileName
        self.copyAbsolutePath = copyAbsolutePath
        self.copyShellEscapedPath = copyShellEscapedPath
    }

    static let inactiveDefault = FinderRightClickConfiguration(menuEnabled: false)
    static let activeDefault = FinderRightClickConfiguration(menuEnabled: true)

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let fallback = FinderRightClickConfiguration.activeDefault
        func flag(_ key: CodingKeys, _ defaultValue: Bool) -> Bool {
            (try? container.decode(Bool.self, forKey: key)) ?? defaultValue
        }
        menuEnabled = flag(.menuEnabled, fallback.menuEnabled)
        preferredLanguages = try? container.decodeIfPresent([String].self, forKey: .preferredLanguages)
        newFile = flag(.newFile, fallback.newFile)
        copyFileName = flag(.copyFileName, fallback.copyFileName)
        copyAbsolutePath = flag(.copyAbsolutePath, fallback.copyAbsolutePath)
        copyShellEscapedPath = flag(.copyShellEscapedPath, fallback.copyShellEscapedPath)
    }

    var hasAnyCopyAction: Bool {
        copyFileName || copyAbsolutePath || copyShellEscapedPath
    }
}

enum FinderRightClickConfigurationStore {
    private static let realHomeDirectory: String = {
        if let pw = getpwuid(getuid()), let home = pw.pointee.pw_dir {
            return String(cString: home)
        }
        return NSHomeDirectory()
    }()

    static var configFileHomeRelativePath: String {
        if let path = Bundle.main.object(forInfoDictionaryKey: "VSFinderRightClickConfigurationHomeRelativePath") as? String,
           !path.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return path
        }
        #if VORSSAINT_DEVELOPMENT
        return "Library/Application Support/Vorssaint Developer/finder-right-click.json"
        #else
        return "Library/Application Support/Vorssaint/finder-right-click.json"
        #endif
    }

    static var configFileURL: URL {
        URL(fileURLWithPath: realHomeDirectory)
            .appendingPathComponent(configFileHomeRelativePath)
    }

    static func load(from fileURL: URL = configFileURL) -> FinderRightClickConfiguration {
        guard let data = try? Data(contentsOf: fileURL),
              let configuration = try? JSONDecoder().decode(FinderRightClickConfiguration.self, from: data)
        else {
            return .inactiveDefault
        }
        return configuration
    }

    static func setMenuEnabled(_ enabled: Bool, fileURL: URL = configFileURL) {
        var configuration = load(from: fileURL)
        if enabled, configuration == .inactiveDefault {
            configuration = .activeDefault
        }
        configuration.menuEnabled = enabled
        _ = save(configuration, to: fileURL)
    }

    @discardableResult
    static func save(_ configuration: FinderRightClickConfiguration,
                     to fileURL: URL = configFileURL) -> Bool {
        do {
            try FileManager.default.createDirectory(
                at: fileURL.deletingLastPathComponent(),
                withIntermediateDirectories: true
            )
            let data = try JSONEncoder().encode(configuration)
            try data.write(to: fileURL, options: .atomic)
            return true
        } catch {
            return false
        }
    }
}

enum FinderRightClickNewFile {
    static let supportedExtensions: [String] = ["txt", "md", "docx", "xlsx", "pptx"]

    static func isSupportedExtension(_ ext: String) -> Bool {
        supportedExtensions.contains(ext.lowercased())
    }
}
