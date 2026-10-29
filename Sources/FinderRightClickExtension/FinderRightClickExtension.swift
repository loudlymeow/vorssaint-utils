// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import AppKit
import FinderSync
import Foundation
import OSLog

@objc(FinderRightClickExtension)
final class FinderRightClickExtension: FIFinderSync {
    private enum ActionID {
        static let newFile = "new-file"
        static let copyFileName = "copy-file-name"
        static let copyAbsolutePath = "copy-absolute-path"
        static let copyShellEscapedPath = "copy-shell-escaped-path"
    }

    private final class MenuActionContext: NSObject {
        let actionID: String
        let directory: URL?
        let fileExtension: String?
        let urls: [URL]

        init(actionID: String,
             directory: URL? = nil,
             fileExtension: String? = nil,
             urls: [URL] = []) {
            self.actionID = actionID
            self.directory = directory
            self.fileExtension = fileExtension
            self.urls = urls
        }
    }

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "com.vorssaint.utils.finder-right-click",
        category: "FinderRightClickExtension"
    )
    // Finder serializes menu items and preserves tags, not representedObject.
    private var tagToContext: [Int: MenuActionContext] = [:]
    private var nextTag = 1
    private let hostURLScheme: String = {
        if let scheme = Bundle.main.object(forInfoDictionaryKey: "VSFinderRightClickHostURLScheme") as? String,
           !scheme.isEmpty {
            return scheme
        }
        #if VORSSAINT_DEVELOPMENT
        return "vorssaint-dev-right-click"
        #else
        return "vorssaint-right-click"
        #endif
    }()

    override init() {
        super.init()
        FIFinderSyncController.default().directoryURLs = [URL(fileURLWithPath: "/", isDirectory: true)]
    }

    override func menu(for menuKind: FIMenuKind) -> NSMenu? {
        let controller = FIFinderSyncController.default()
        let selectedURLs = controller.selectedItemURLs() ?? []
        let targetedURL = controller.targetedURL()
        tagToContext.removeAll(keepingCapacity: true)

        let configuration = FinderRightClickConfigurationStore.load()
        guard configuration.menuEnabled else { return nil }

        let menu = NSMenu(title: "Vorssaint")
        let languages = configuration.preferredLanguages

        let directory: URL?
        let copyURLs: [URL]
        switch menuKind {
        case .contextualMenuForContainer:
            directory = targetedURL.flatMap {
                FinderRightClickTargetResolver.isDirectory($0) ? $0 : nil
            }
            copyURLs = directory.map { [$0] } ?? []
        case .contextualMenuForItems, .contextualMenuForSidebar, .toolbarItemMenu:
            directory = FinderRightClickTargetResolver.targetDirectory(
                selectedURLs: selectedURLs,
                targetedURL: targetedURL
            )
            copyURLs = selectedURLs.isEmpty ? (directory.map { [$0] } ?? []) : selectedURLs
        @unknown default:
            return nil
        }

        if configuration.newFile, let directory {
            addNewFileMenu(to: menu, directory: directory, configuration: configuration, languages: languages)
        }

        if configuration.hasAnyCopyAction, !copyURLs.isEmpty {
            addCopyOptionsMenu(to: menu, urls: copyURLs, configuration: configuration, languages: languages)
        }

        return menu.items.isEmpty ? nil : menu
    }

    private func addNewFileMenu(to menu: NSMenu,
                                directory: URL,
                                configuration: FinderRightClickConfiguration,
                                languages: [String]?) {
        let title = localized("menu.newFile", defaultValue: "New File", languages: languages)
        let parent = NSMenuItem(title: title, action: nil, keyEquivalent: "")
        let submenu = NSMenu(title: title)
        for ext in FinderRightClickNewFile.supportedExtensions {
            let itemTitle = localized(
                "menu.newFile.\(ext)",
                defaultValue: ".\(ext)",
                languages: languages
            )
            let item = actionItem(
                title: itemTitle,
                context: MenuActionContext(
                    actionID: ActionID.newFile,
                    directory: directory,
                    fileExtension: ext
                )
            )
            submenu.addItem(item)
        }
        parent.submenu = submenu
        menu.addItem(parent)
        _ = configuration
    }

    private func addCopyOptionsMenu(to menu: NSMenu,
                                    urls: [URL],
                                    configuration: FinderRightClickConfiguration,
                                    languages: [String]?) {
        let title = localized("menu.copyOptions", defaultValue: "Copy Options", languages: languages)
        let parent = NSMenuItem(title: title, action: nil, keyEquivalent: "")
        let submenu = NSMenu(title: title)
        if configuration.copyFileName {
            submenu.addItem(actionItem(
                title: localized("menu.copyFileName", defaultValue: "Copy File Name", languages: languages),
                context: MenuActionContext(actionID: ActionID.copyFileName, urls: urls)
            ))
        }
        if configuration.copyAbsolutePath {
            submenu.addItem(actionItem(
                title: localized("menu.copyAbsolutePath", defaultValue: "Copy Absolute Path", languages: languages),
                context: MenuActionContext(actionID: ActionID.copyAbsolutePath, urls: urls)
            ))
        }
        if configuration.copyShellEscapedPath {
            submenu.addItem(actionItem(
                title: localized("menu.copyShellEscapedPath", defaultValue: "Copy Escaped Path", languages: languages),
                context: MenuActionContext(actionID: ActionID.copyShellEscapedPath, urls: urls)
            ))
        }
        guard !submenu.items.isEmpty else { return }
        parent.submenu = submenu
        menu.addItem(parent)
    }

    private func localized(_ key: String, defaultValue: String, languages: [String]?) -> String {
        FinderRightClickMenuLocalization.string(
            key,
            preferredLanguages: languages,
            defaultValue: defaultValue
        )
    }

    private func actionItem(title: String, context: MenuActionContext) -> NSMenuItem {
        let item = NSMenuItem(title: title, action: #selector(handleMenuAction(_:)), keyEquivalent: "")
        item.target = self
        item.representedObject = context
        register(context, for: item)
        return item
    }

    private func register(_ context: MenuActionContext, for item: NSMenuItem) {
        guard nextTag < Int.max else {
            item.isEnabled = false
            return
        }
        item.tag = nextTag
        tagToContext[nextTag] = context
        nextTag += 1
    }

    @objc private func handleMenuAction(_ sender: NSMenuItem) {
        let context = (sender.representedObject as? MenuActionContext)
            ?? tagToContext[sender.tag]
        guard let context else {
            logger.error("Missing action context for \(sender.title, privacy: .public)")
            return
        }
        tagToContext.removeValue(forKey: sender.tag)

        switch context.actionID {
        case ActionID.newFile:
            guard let directory = context.directory, let ext = context.fileExtension else { return }
            openHostURL(path: "/new-file", queryItems: [
                URLQueryItem(name: "directory", value: directory.path),
                URLQueryItem(name: "ext", value: ext),
            ])
        case ActionID.copyFileName:
            copyToPasteboard(FinderRightClickPathFormatter.joinedFileNames(context.urls))
        case ActionID.copyAbsolutePath:
            copyToPasteboard(FinderRightClickPathFormatter.joinedPaths(context.urls))
        case ActionID.copyShellEscapedPath:
            copyToPasteboard(FinderRightClickPathFormatter.joinedShellEscapedPaths(context.urls))
        default:
            logger.error("Unknown action \(context.actionID, privacy: .public)")
        }
    }

    private func copyToPasteboard(_ value: String) {
        guard !value.isEmpty else { return }
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([.string], owner: nil)
        pasteboard.setString(value, forType: .string)
    }

    private func openHostURL(path: String, queryItems: [URLQueryItem]) {
        var components = URLComponents()
        components.scheme = hostURLScheme
        components.host = "right-click"
        components.path = path
        components.queryItems = queryItems
        guard let url = components.url else { return }
        NSWorkspace.shared.open(url)
    }
}
