// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import SwiftUI

struct FinderRightClickSettings: View {
    @ObservedObject private var l10n = L10n.shared
    @AppStorage(DefaultsKey.finderRightClickEnabled) private var enabled = true
    @AppStorage(DefaultsKey.finderRightClickNewFile) private var newFile = true
    @AppStorage(DefaultsKey.finderRightClickCopyFileName) private var copyFileName = true
    @AppStorage(DefaultsKey.finderRightClickCopyAbsolutePath) private var copyAbsolutePath = true
    @AppStorage(DefaultsKey.finderRightClickCopyShellEscapedPath) private var copyShellEscapedPath = true
    @State private var extensionEnabled = FinderRightClickService.shared.isExtensionEnabled

    private var text: FinderRightClickFeatureStrings {
        FeatureStrings.finderRightClick(l10n.language)
    }

    var body: some View {
        Form {
            if AppFeature.finderRightClick.isAvailable {
                Section {
                    Toggle(text.enableLabel, isOn: $enabled)
                        .onChange(of: enabled) { _, _ in
                            FinderRightClickService.shared.syncWithPreferences()
                        }
                    Text(text.enableCaption)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                if enabled {
                    Section {
                        Toggle(text.newFileLabel, isOn: $newFile)
                            .onChange(of: newFile) { _, _ in
                                FinderRightClickService.shared.syncWithPreferences()
                            }
                        Text(text.newFileCaption)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Section(text.copyOptionsLabel) {
                        Toggle(text.copyFileNameLabel, isOn: $copyFileName)
                            .onChange(of: copyFileName) { _, _ in
                                FinderRightClickService.shared.syncWithPreferences()
                            }
                        Toggle(text.copyAbsolutePathLabel, isOn: $copyAbsolutePath)
                            .onChange(of: copyAbsolutePath) { _, _ in
                                FinderRightClickService.shared.syncWithPreferences()
                            }
                        Toggle(text.copyShellEscapedPathLabel, isOn: $copyShellEscapedPath)
                            .onChange(of: copyShellEscapedPath) { _, _ in
                                FinderRightClickService.shared.syncWithPreferences()
                            }
                        Text(text.copyShellEscapedPathCaption)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                Section(text.extensionTitle) {
                    Label(
                        extensionEnabled ? text.extensionEnabled : text.extensionDisabled,
                        systemImage: extensionEnabled ? "checkmark.circle.fill" : "exclamationmark.triangle.fill"
                    )
                    .foregroundStyle(extensionEnabled ? .green : .orange)
                    Text(text.extensionCaption)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Button(text.extensionOpen) {
                        FinderRightClickService.shared.openExtensionManagement()
                        extensionEnabled = FinderRightClickService.shared.isExtensionEnabled
                    }
                }
            }
        }
        .formStyle(.grouped)
        .toggleStyle(.switch)
        .onAppear {
            FinderRightClickService.shared.syncWithPreferences()
            extensionEnabled = FinderRightClickService.shared.isExtensionEnabled
        }
        .onReceive(NotificationCenter.default.publisher(for: NSApplication.didBecomeActiveNotification)) { _ in
            extensionEnabled = FinderRightClickService.shared.isExtensionEnabled
        }
    }
}
