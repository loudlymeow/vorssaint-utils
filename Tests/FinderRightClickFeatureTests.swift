// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import Foundation

enum FinderRightClickFeatureTests {
    static func run(_ suite: TestSuite) {
        suite.expect(FinderRightClickNewFile.supportedExtensions == ["txt", "md", "docx", "xlsx", "pptx"],
                     "new-file menu covers the planned extensions")
        suite.expect(FinderRightClickNewFile.isSupportedExtension("TXT")
                && !FinderRightClickNewFile.isSupportedExtension("pdf"),
                     "extension matching is case-insensitive and closed")

        suite.expect(FinderRightClickUntitledName.baseName(preferredLanguages: ["zh-Hans"]) == "未命名"
                && FinderRightClickUntitledName.baseName(preferredLanguages: ["ja"]) == "名称未設定"
                && FinderRightClickUntitledName.baseName(preferredLanguages: ["en"]) == "Untitled"
                && FinderRightClickUntitledName.baseName(preferredLanguages: nil) == "Untitled",
                     "untitled names follow the preferred language")

        suite.expect(FinderRightClickPathFormatter.joinedFileNames([
                URL(fileURLWithPath: "/tmp/a.txt"),
                URL(fileURLWithPath: "/tmp/b.md"),
            ]) == "a.txt\nb.md",
                     "copy file name joins basenames")
        suite.expect(FinderRightClickPathFormatter.joinedPaths([
                URL(fileURLWithPath: "/tmp/a.txt"),
            ]) == "/tmp/a.txt",
                     "copy absolute path keeps the full path")
        suite.expect(FinderRightClickPathFormatter.shellEscaped("/tmp/it's a file")
                == "'/tmp/it'\\''s a file'",
                     "shell escaping quotes single quotes")
        suite.expect(FinderRightClickPathFormatter.joinedShellEscapedPaths([
                URL(fileURLWithPath: "/tmp/a"),
                URL(fileURLWithPath: "/tmp/b"),
            ]) == "'/tmp/a' '/tmp/b'",
                     "escaped paths are space-joined for the shell")

        let tempRoot = FileManager.default.temporaryDirectory
            .appendingPathComponent("vorssaint-finder-right-click-\(UUID().uuidString)", isDirectory: true)
        defer { try? FileManager.default.removeItem(at: tempRoot) }
        try? FileManager.default.createDirectory(at: tempRoot, withIntermediateDirectories: true)

        let first = FinderRightClickFileNamePlanner.nextAvailableURL(
            in: tempRoot, baseName: "Untitled", pathExtension: "txt")
        try? Data().write(to: first)
        let second = FinderRightClickFileNamePlanner.nextAvailableURL(
            in: tempRoot, baseName: "Untitled", pathExtension: "txt")
        suite.expect(first.lastPathComponent == "Untitled.txt"
                && second.lastPathComponent == "Untitled 2.txt",
                     "file planner avoids collisions with numbered suffixes")

        let file = tempRoot.appendingPathComponent("nested.txt")
        try? Data().write(to: file)
        suite.expect(FinderRightClickTargetResolver.directory(for: file) == tempRoot,
                     "a selected file resolves to its parent directory")
        suite.expect(FinderRightClickTargetResolver.directory(for: tempRoot) == tempRoot,
                     "a selected directory is used as-is")
        suite.expect(FinderRightClickTargetResolver.targetDirectory(
                selectedURLs: [file], targetedURL: nil) == tempRoot,
                     "selection prefers the first selected item")

        let configURL = tempRoot.appendingPathComponent("finder-right-click.json")
        suite.expect(FinderRightClickConfigurationStore.load(from: configURL) == .inactiveDefault,
                     "missing config is inactive so the menu stays hidden until the host writes one")
        var configuration = FinderRightClickConfiguration.activeDefault
        configuration.copyFileName = false
        suite.expect(FinderRightClickConfigurationStore.save(configuration, to: configURL)
                && FinderRightClickConfigurationStore.load(from: configURL) == configuration,
                     "configuration round-trips through Application Support JSON")
        suite.expect(configuration.hasAnyCopyAction,
                     "leaving any copy toggle on keeps the copy submenu")
        suite.expect(FinderRightClickConfiguration(
                menuEnabled: true,
                copyFileName: false,
                copyAbsolutePath: false,
                copyShellEscapedPath: false
            ).hasAnyCopyAction == false,
                     "copy submenu disappears when every copy toggle is off")

        suite.expect(FinderRightClickMenuLocalization.string(
                "menu.newFile", preferredLanguages: ["zh-Hans"], defaultValue: "New File")
                == "新建文件",
                     "menu localization covers Simplified Chinese")
        suite.expect(FinderRightClickMenuLocalization.string(
                "menu.copyOptions", preferredLanguages: ["en"], defaultValue: "Copy Options")
                == "Copy Options",
                     "menu localization falls back to English")

        suite.expect(AppFeature.finderRightClick.installedByDefault == false
                && AppFeature.finderRightClick.permissions.isEmpty
                && AppFeature.finderRightClick.settingsDestination
                == FeatureSettingsDestination(.finderRightClick)
                && FeatureVisibilitySupport.features(for: .finderRightClick) == [.finderRightClick],
                     "Finder right-click is opt-in with its own settings page")
        suite.expect(FeatureStrings.finderRightClick(.enUS).hubTitle == "Finder right-click"
                && FeatureStrings.finderRightClick(.zhHans).pageTitle == "访达右键",
                     "settings strings exist for English and Simplified Chinese")
        suite.expect(FinderRightClickURLRouter.hostURLScheme == "vorssaint-right-click"
                || FinderRightClickURLRouter.hostURLScheme == "vorssaint-dev-right-click",
                     "host URL scheme matches the build variant")
    }
}
