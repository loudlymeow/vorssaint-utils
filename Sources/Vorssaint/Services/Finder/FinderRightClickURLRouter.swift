// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import AppKit
import Foundation
import OSLog

final class FinderRightClickURLRouter {
    static let shared = FinderRightClickURLRouter()

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "com.vorssaint.utils",
        category: "FinderRightClickURLRouter"
    )
    private var fileActionService = FinderRightClickFileActionService()
    private lazy var acceptedURLSchemes = Self.bundleURLSchemes()

    private init() {}

    func handle(_ urls: [URL]) {
        for url in urls { handle(url) }
    }

    func handle(_ url: URL) {
        guard let scheme = url.scheme,
              acceptedURLSchemes.contains(scheme),
              url.host == "right-click" else {
            return
        }

        switch url.path {
        case "/new-file":
            handleNewFile(url)
        default:
            logger.error("Unsupported finder-right-click URL path: \(url.path, privacy: .private)")
        }
    }

    private func handleNewFile(_ url: URL) {
        guard let directoryPath = queryValue("directory", in: url), !directoryPath.isEmpty,
              let ext = queryValue("ext", in: url) else {
            logger.error("Missing directory/ext for new-file URL")
            return
        }
        let configuration = FinderRightClickConfigurationStore.load()
        let baseName = FinderRightClickUntitledName.baseName(
            preferredLanguages: configuration.preferredLanguages
        )
        do {
            let fileURL = try fileActionService.createFile(
                in: URL(fileURLWithPath: directoryPath),
                extension: ext,
                baseName: baseName
            )
            logger.info("Created file at \(fileURL.path, privacy: .public)")
        } catch {
            logger.error("Create file failed: \(error.localizedDescription, privacy: .private)")
        }
    }

    private func queryValue(_ name: String, in url: URL) -> String? {
        URLComponents(url: url, resolvingAgainstBaseURL: false)?
            .queryItems?
            .first(where: { $0.name == name })?
            .value
    }

    nonisolated static func bundleURLSchemes(bundle: Bundle = .main) -> Set<String> {
        #if VORSSAINT_DEVELOPMENT
        let fallback = "vorssaint-dev-right-click"
        #else
        let fallback = "vorssaint-right-click"
        #endif
        guard let urlTypes = bundle.object(forInfoDictionaryKey: "CFBundleURLTypes") as? [[String: Any]] else {
            return [fallback]
        }
        let schemes = urlTypes
            .compactMap { $0["CFBundleURLSchemes"] as? [String] }
            .flatMap { $0 }
        return schemes.isEmpty ? [fallback] : Set(schemes)
    }

    nonisolated static var hostURLScheme: String {
        #if VORSSAINT_DEVELOPMENT
        return "vorssaint-dev-right-click"
        #else
        return "vorssaint-right-click"
        #endif
    }
}
