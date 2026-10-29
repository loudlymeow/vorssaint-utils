// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import AppKit
import FinderSync
import Foundation

final class FinderRightClickService {
    static let shared = FinderRightClickService()

    private init() {}

    func syncWithPreferences() {
        let available = AppFeature.finderRightClick.isAvailable
        var configuration = FinderRightClickConfigurationStore.load()
        if available, configuration == .inactiveDefault {
            configuration = .activeDefault
        }
        configuration.menuEnabled = available && UserDefaults.standard.bool(
            forKey: DefaultsKey.finderRightClickEnabled
        )
        configuration.newFile = UserDefaults.standard.object(forKey: DefaultsKey.finderRightClickNewFile) as? Bool
            ?? true
        configuration.copyFileName = UserDefaults.standard.object(forKey: DefaultsKey.finderRightClickCopyFileName) as? Bool
            ?? true
        configuration.copyAbsolutePath = UserDefaults.standard.object(forKey: DefaultsKey.finderRightClickCopyAbsolutePath) as? Bool
            ?? true
        configuration.copyShellEscapedPath = UserDefaults.standard.object(forKey: DefaultsKey.finderRightClickCopyShellEscapedPath) as? Bool
            ?? true
        configuration.preferredLanguages = [L10n.shared.language.rawValue]
        _ = FinderRightClickConfigurationStore.save(configuration)
    }

    func openExtensionManagement() {
        FIFinderSyncController.showExtensionManagementInterface()
    }

    var isExtensionEnabled: Bool {
        FIFinderSyncController.isExtensionEnabled
    }
}
