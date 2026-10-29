// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import Foundation

/// Menu titles for the Finder Sync extension. Kept separate from AppKit
/// Settings strings so the appex can localize without the full host catalog.
enum FinderRightClickMenuLocalization {
    static func string(_ key: String,
                       preferredLanguages: [String]?,
                       defaultValue: String) -> String {
        let code = (preferredLanguages?.first ?? Locale.preferredLanguages.first ?? "en")
            .replacingOccurrences(of: "_", with: "-")
            .lowercased()
        let table = titles(for: code)
        return table[key] ?? defaultValue
    }

    private static func titles(for code: String) -> [String: String] {
        if code.hasPrefix("zh-hans") || code == "zh" || code.hasPrefix("zh-cn") {
            return [
                "menu.newFile": "新建文件",
                "menu.copyOptions": "复制选项",
                "menu.copyFileName": "复制文件名",
                "menu.copyAbsolutePath": "复制绝对路径",
                "menu.copyShellEscapedPath": "复制转义路径",
                "menu.newFile.txt": "文本文件 (.txt)",
                "menu.newFile.md": "Markdown (.md)",
                "menu.newFile.docx": "Word (.docx)",
                "menu.newFile.xlsx": "Excel (.xlsx)",
                "menu.newFile.pptx": "PowerPoint (.pptx)",
            ]
        }
        if code.hasPrefix("zh") {
            return [
                "menu.newFile": "新增檔案",
                "menu.copyOptions": "複製選項",
                "menu.copyFileName": "複製檔名",
                "menu.copyAbsolutePath": "複製絕對路徑",
                "menu.copyShellEscapedPath": "複製跳脫路徑",
                "menu.newFile.txt": "文字檔 (.txt)",
                "menu.newFile.md": "Markdown (.md)",
                "menu.newFile.docx": "Word (.docx)",
                "menu.newFile.xlsx": "Excel (.xlsx)",
                "menu.newFile.pptx": "PowerPoint (.pptx)",
            ]
        }
        if code.hasPrefix("ja") {
            return [
                "menu.newFile": "新規ファイル",
                "menu.copyOptions": "コピーオプション",
                "menu.copyFileName": "ファイル名をコピー",
                "menu.copyAbsolutePath": "絶対パスをコピー",
                "menu.copyShellEscapedPath": "エスケープしたパスをコピー",
                "menu.newFile.txt": "テキスト (.txt)",
                "menu.newFile.md": "Markdown (.md)",
                "menu.newFile.docx": "Word (.docx)",
                "menu.newFile.xlsx": "Excel (.xlsx)",
                "menu.newFile.pptx": "PowerPoint (.pptx)",
            ]
        }
        if code.hasPrefix("ko") {
            return [
                "menu.newFile": "새 파일",
                "menu.copyOptions": "복사 옵션",
                "menu.copyFileName": "파일 이름 복사",
                "menu.copyAbsolutePath": "절대 경로 복사",
                "menu.copyShellEscapedPath": "이스케이프 경로 복사",
                "menu.newFile.txt": "텍스트 (.txt)",
                "menu.newFile.md": "Markdown (.md)",
                "menu.newFile.docx": "Word (.docx)",
                "menu.newFile.xlsx": "Excel (.xlsx)",
                "menu.newFile.pptx": "PowerPoint (.pptx)",
            ]
        }
        return [
            "menu.newFile": "New File",
            "menu.copyOptions": "Copy Options",
            "menu.copyFileName": "Copy File Name",
            "menu.copyAbsolutePath": "Copy Absolute Path",
            "menu.copyShellEscapedPath": "Copy Escaped Path",
            "menu.newFile.txt": "Text (.txt)",
            "menu.newFile.md": "Markdown (.md)",
            "menu.newFile.docx": "Word (.docx)",
            "menu.newFile.xlsx": "Excel (.xlsx)",
            "menu.newFile.pptx": "PowerPoint (.pptx)",
        ]
    }
}
