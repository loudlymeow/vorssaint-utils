// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import Foundation

struct FinderRightClickFeatureStrings {
    let pageTitle: String
    let hubTitle: String
    let hubDescription: String
    let enableLabel: String
    let enableCaption: String
    let newFileLabel: String
    let newFileCaption: String
    let copyOptionsLabel: String
    let copyFileNameLabel: String
    let copyAbsolutePathLabel: String
    let copyShellEscapedPathLabel: String
    let copyShellEscapedPathCaption: String
    let extensionTitle: String
    let extensionCaption: String
    let extensionOpen: String
    let extensionEnabled: String
    let extensionDisabled: String
}

extension FeatureStrings {
    static func finderRightClick(_ language: AppLanguage) -> FinderRightClickFeatureStrings {
        switch language {
        case .enUS: return .enUS
        case .ptBR: return .ptBR
        case .tr: return .tr
        case .ru: return .ru
        case .es: return .es
        case .sk: return .sk
        case .de: return .de
        case .fr: return .fr
        case .it: return .it
        case .ja: return .ja
        case .ko: return .ko
        case .zhHans: return .zhHans
        case .zhTW: return .zhTW
        case .zhHK: return .zhHK
        case .uk: return .uk
        }
    }
}

extension FinderRightClickFeatureStrings {
    static let enUS = FinderRightClickFeatureStrings(
        pageTitle: "Finder right-click",
        hubTitle: "Finder right-click",
        hubDescription: "Add New File and Copy Options to Finder’s context menu.",
        enableLabel: "Show in Finder’s context menu",
        enableCaption: "Requires enabling the bundled Finder Sync extension under File Providers.",
        newFileLabel: "New File",
        newFileCaption: "Creates .txt, .md, .docx, .xlsx or .pptx in the current folder.",
        copyOptionsLabel: "Copy Options",
        copyFileNameLabel: "Copy file name",
        copyAbsolutePathLabel: "Copy absolute path",
        copyShellEscapedPathLabel: "Copy escaped path",
        copyShellEscapedPathCaption: "Quoted paths ready to paste into a Terminal command.",
        extensionTitle: "File Providers",
        extensionCaption: "System Settings → General → Login Items & Extensions → File Providers (ⓘ).",
        extensionOpen: "Open File Providers…",
        extensionEnabled: "Enabled",
        extensionDisabled: "Not enabled"
    )

    static let zhHans = FinderRightClickFeatureStrings(
        pageTitle: "访达右键",
        hubTitle: "访达右键",
        hubDescription: "在访达右键菜单中添加新建文件与复制选项。",
        enableLabel: "在访达右键菜单中显示",
        enableCaption: "需要在「文件提供程序」中启用随附的访达同步扩展。",
        newFileLabel: "新建文件",
        newFileCaption: "在当前文件夹创建 .txt、.md、.docx、.xlsx 或 .pptx。",
        copyOptionsLabel: "复制选项",
        copyFileNameLabel: "复制文件名",
        copyAbsolutePathLabel: "复制绝对路径",
        copyShellEscapedPathLabel: "复制转义路径",
        copyShellEscapedPathCaption: "适合粘贴进终端命令的引号转义路径。",
        extensionTitle: "文件提供程序",
        extensionCaption: "系统设置 → 通用 → 登录项与扩展 → 文件提供程序（点右侧 ⓘ）。",
        extensionOpen: "打开文件提供程序…",
        extensionEnabled: "已启用",
        extensionDisabled: "未启用"
    )

    static let zhTW = FinderRightClickFeatureStrings(
        pageTitle: "Finder 右鍵",
        hubTitle: "Finder 右鍵",
        hubDescription: "在 Finder 右鍵選單加入新增檔案與複製選項。",
        enableLabel: "在 Finder 右鍵選單顯示",
        enableCaption: "需要在「檔案提供程式」中啟用隨附的 Finder 同步延伸功能。",
        newFileLabel: "新增檔案",
        newFileCaption: "在目前資料夾建立 .txt、.md、.docx、.xlsx 或 .pptx。",
        copyOptionsLabel: "複製選項",
        copyFileNameLabel: "複製檔名",
        copyAbsolutePathLabel: "複製絕對路徑",
        copyShellEscapedPathLabel: "複製跳脫路徑",
        copyShellEscapedPathCaption: "適合貼到終端機指令的引號跳脫路徑。",
        extensionTitle: "檔案提供程式",
        extensionCaption: "系統設定 → 一般 → 登入項目與延伸功能 → 檔案提供程式（點右側 ⓘ）。",
        extensionOpen: "打開檔案提供程式…",
        extensionEnabled: "已啟用",
        extensionDisabled: "未啟用"
    )

    static let zhHK = FinderRightClickFeatureStrings(
        pageTitle: "Finder 右鍵",
        hubTitle: "Finder 右鍵",
        hubDescription: "在 Finder 右鍵選單加入新增檔案與複製選項。",
        enableLabel: "在 Finder 右鍵選單顯示",
        enableCaption: "需要在「檔案提供程式」中啟用隨附的 Finder 同步延伸功能。",
        newFileLabel: "新增檔案",
        newFileCaption: "在目前資料夾建立 .txt、.md、.docx、.xlsx 或 .pptx。",
        copyOptionsLabel: "複製選項",
        copyFileNameLabel: "複製檔名",
        copyAbsolutePathLabel: "複製絕對路徑",
        copyShellEscapedPathLabel: "複製跳脫路徑",
        copyShellEscapedPathCaption: "適合貼到終端機指令的引號跳脫路徑。",
        extensionTitle: "檔案提供程式",
        extensionCaption: "系統設定 → 一般 → 登入項目與延伸功能 → 檔案提供程式（點右側 ⓘ）。",
        extensionOpen: "打開檔案提供程式…",
        extensionEnabled: "已啟用",
        extensionDisabled: "未啟用"
    )

    static let ja = FinderRightClickFeatureStrings(
        pageTitle: "Finderの右クリック",
        hubTitle: "Finderの右クリック",
        hubDescription: "Finderのコンテキストメニューに新規ファイルとコピーオプションを追加します。",
        enableLabel: "Finderのコンテキストメニューに表示",
        enableCaption: "システム設定の「ファイルプロバイダ」で同梱のFinder Sync拡張を有効にする必要があります。",
        newFileLabel: "新規ファイル",
        newFileCaption: "現在のフォルダに .txt、.md、.docx、.xlsx、.pptx を作成します。",
        copyOptionsLabel: "コピーオプション",
        copyFileNameLabel: "ファイル名をコピー",
        copyAbsolutePathLabel: "絶対パスをコピー",
        copyShellEscapedPathLabel: "エスケープしたパスをコピー",
        copyShellEscapedPathCaption: "ターミナルコマンドに貼り付けやすい引用符付きパスです。",
        extensionTitle: "ファイルプロバイダ",
        extensionCaption: "システム設定 → 一般 → ログイン項目と拡張機能 → ファイルプロバイダ（ⓘ）。",
        extensionOpen: "ファイルプロバイダを開く…",
        extensionEnabled: "有効",
        extensionDisabled: "無効"
    )

    static let ko = FinderRightClickFeatureStrings(
        pageTitle: "Finder 오른쪽 클릭",
        hubTitle: "Finder 오른쪽 클릭",
        hubDescription: "Finder 컨텍스트 메뉴에 새 파일과 복사 옵션을 추가합니다.",
        enableLabel: "Finder 컨텍스트 메뉴에 표시",
        enableCaption: "시스템 설정의 “파일 제공자”에서 포함된 Finder Sync 확장 프로그램을 켜야 합니다.",
        newFileLabel: "새 파일",
        newFileCaption: "현재 폴더에 .txt, .md, .docx, .xlsx 또는 .pptx를 만듭니다.",
        copyOptionsLabel: "복사 옵션",
        copyFileNameLabel: "파일 이름 복사",
        copyAbsolutePathLabel: "절대 경로 복사",
        copyShellEscapedPathLabel: "이스케이프 경로 복사",
        copyShellEscapedPathCaption: "터미널 명령에 붙여넣기 좋은 따옴표 이스케이프 경로입니다.",
        extensionTitle: "파일 제공자",
        extensionCaption: "시스템 설정 → 일반 → 로그인 항목 및 확장 프로그램 → 파일 제공자(ⓘ).",
        extensionOpen: "파일 제공자 열기…",
        extensionEnabled: "사용 중",
        extensionDisabled: "사용 안 함"
    )

    static let de = FinderRightClickFeatureStrings(
        pageTitle: "Finder-Rechtsklick",
        hubTitle: "Finder-Rechtsklick",
        hubDescription: "Fügt dem Finder-Kontextmenü „Neue Datei“ und Kopieroptionen hinzu.",
        enableLabel: "Im Finder-Kontextmenü zeigen",
        enableCaption: "Die mitgelieferte Finder-Sync-Erweiterung muss unter Dateianbieter aktiviert sein.",
        newFileLabel: "Neue Datei",
        newFileCaption: "Erstellt .txt, .md, .docx, .xlsx oder .pptx im aktuellen Ordner.",
        copyOptionsLabel: "Kopieroptionen",
        copyFileNameLabel: "Dateiname kopieren",
        copyAbsolutePathLabel: "Absolutpfad kopieren",
        copyShellEscapedPathLabel: "Escapeten Pfad kopieren",
        copyShellEscapedPathCaption: "In Anführungszeichen gesetzte Pfade für Terminalbefehle.",
        extensionTitle: "Dateianbieter",
        extensionCaption: "Systemeinstellungen → Allgemein → Anmeldeobjekte & Erweiterungen → Dateianbieter (ⓘ).",
        extensionOpen: "Dateianbieter öffnen…",
        extensionEnabled: "Aktiviert",
        extensionDisabled: "Nicht aktiviert"
    )

    static let fr = FinderRightClickFeatureStrings(
        pageTitle: "Clic droit du Finder",
        hubTitle: "Clic droit du Finder",
        hubDescription: "Ajoute Nouveau fichier et Options de copie au menu contextuel du Finder.",
        enableLabel: "Afficher dans le menu contextuel du Finder",
        enableCaption: "Nécessite d’activer l’extension Finder Sync sous Fournisseurs de fichiers.",
        newFileLabel: "Nouveau fichier",
        newFileCaption: "Crée un fichier .txt, .md, .docx, .xlsx ou .pptx dans le dossier actuel.",
        copyOptionsLabel: "Options de copie",
        copyFileNameLabel: "Copier le nom du fichier",
        copyAbsolutePathLabel: "Copier le chemin absolu",
        copyShellEscapedPathLabel: "Copier le chemin échappé",
        copyShellEscapedPathCaption: "Chemins entre guillemets prêts pour le Terminal.",
        extensionTitle: "Fournisseurs de fichiers",
        extensionCaption: "Réglages Système → Général → Ouverture et extensions → Fournisseurs de fichiers (ⓘ).",
        extensionOpen: "Ouvrir les fournisseurs de fichiers…",
        extensionEnabled: "Activée",
        extensionDisabled: "Désactivée"
    )

    static let es = FinderRightClickFeatureStrings(
        pageTitle: "Clic derecho del Finder",
        hubTitle: "Clic derecho del Finder",
        hubDescription: "Añade Nuevo archivo y Opciones de copia al menú contextual del Finder.",
        enableLabel: "Mostrar en el menú contextual del Finder",
        enableCaption: "Requiere activar la extensión Finder Sync en Proveedores de archivos.",
        newFileLabel: "Nuevo archivo",
        newFileCaption: "Crea .txt, .md, .docx, .xlsx o .pptx en la carpeta actual.",
        copyOptionsLabel: "Opciones de copia",
        copyFileNameLabel: "Copiar nombre de archivo",
        copyAbsolutePathLabel: "Copiar ruta absoluta",
        copyShellEscapedPathLabel: "Copiar ruta escapada",
        copyShellEscapedPathCaption: "Rutas entre comillas listas para Terminal.",
        extensionTitle: "Proveedores de archivos",
        extensionCaption: "Ajustes del Sistema → General → Elementos de inicio y extensiones → Proveedores de archivos (ⓘ).",
        extensionOpen: "Abrir proveedores de archivos…",
        extensionEnabled: "Activada",
        extensionDisabled: "Desactivada"
    )

    static let ptBR = FinderRightClickFeatureStrings(
        pageTitle: "Clique direito do Finder",
        hubTitle: "Clique direito do Finder",
        hubDescription: "Adiciona Novo arquivo e Opções de cópia ao menu de contexto do Finder.",
        enableLabel: "Mostrar no menu de contexto do Finder",
        enableCaption: "Requer ativar a extensão Finder Sync em Provedores de Arquivos.",
        newFileLabel: "Novo arquivo",
        newFileCaption: "Cria .txt, .md, .docx, .xlsx ou .pptx na pasta atual.",
        copyOptionsLabel: "Opções de cópia",
        copyFileNameLabel: "Copiar nome do arquivo",
        copyAbsolutePathLabel: "Copiar caminho absoluto",
        copyShellEscapedPathLabel: "Copiar caminho escapado",
        copyShellEscapedPathCaption: "Caminhos entre aspas prontos para o Terminal.",
        extensionTitle: "Provedores de Arquivos",
        extensionCaption: "Ajustes do Sistema → Geral → Itens de Início e Extensões → Provedores de Arquivos (ⓘ).",
        extensionOpen: "Abrir provedores de arquivos…",
        extensionEnabled: "Ativada",
        extensionDisabled: "Desativada"
    )

    static let it = FinderRightClickFeatureStrings(
        pageTitle: "Clic destro del Finder",
        hubTitle: "Clic destro del Finder",
        hubDescription: "Aggiunge Nuovo file e Opzioni di copia al menu contestuale del Finder.",
        enableLabel: "Mostra nel menu contestuale del Finder",
        enableCaption: "Richiede di attivare l’estensione Finder Sync in Fornitori di file.",
        newFileLabel: "Nuovo file",
        newFileCaption: "Crea .txt, .md, .docx, .xlsx o .pptx nella cartella corrente.",
        copyOptionsLabel: "Opzioni di copia",
        copyFileNameLabel: "Copia nome file",
        copyAbsolutePathLabel: "Copia percorso assoluto",
        copyShellEscapedPathLabel: "Copia percorso con escape",
        copyShellEscapedPathCaption: "Percorsi tra virgolette pronti per il Terminale.",
        extensionTitle: "Fornitori di file",
        extensionCaption: "Impostazioni di Sistema → Generali → Elementi di login ed estensioni → Fornitori di file (ⓘ).",
        extensionOpen: "Apri fornitori di file…",
        extensionEnabled: "Attiva",
        extensionDisabled: "Non attiva"
    )

    static let ru = FinderRightClickFeatureStrings(
        pageTitle: "Правый клик Finder",
        hubTitle: "Правый клик Finder",
        hubDescription: "Добавляет «Новый файл» и параметры копирования в контекстное меню Finder.",
        enableLabel: "Показывать в контекстном меню Finder",
        enableCaption: "Нужно включить встроенное расширение Finder Sync в разделе «Провайдеры файлов».",
        newFileLabel: "Новый файл",
        newFileCaption: "Создаёт .txt, .md, .docx, .xlsx или .pptx в текущей папке.",
        copyOptionsLabel: "Параметры копирования",
        copyFileNameLabel: "Копировать имя файла",
        copyAbsolutePathLabel: "Копировать абсолютный путь",
        copyShellEscapedPathLabel: "Копировать экранированный путь",
        copyShellEscapedPathCaption: "Пути в кавычках для вставки в команду Терминала.",
        extensionTitle: "Провайдеры файлов",
        extensionCaption: "Системные настройки → Основные → Объекты входа и расширения → Провайдеры файлов (ⓘ).",
        extensionOpen: "Открыть провайдеры файлов…",
        extensionEnabled: "Включено",
        extensionDisabled: "Выключено"
    )

    static let uk = FinderRightClickFeatureStrings(
        pageTitle: "Правий клік Finder",
        hubTitle: "Правий клік Finder",
        hubDescription: "Додає «Новий файл» і параметри копіювання до контекстного меню Finder.",
        enableLabel: "Показувати в контекстному меню Finder",
        enableCaption: "Потрібно увімкнути вбудоване розширення Finder Sync у розділі «Постачальники файлів».",
        newFileLabel: "Новий файл",
        newFileCaption: "Створює .txt, .md, .docx, .xlsx або .pptx у поточній теці.",
        copyOptionsLabel: "Параметри копіювання",
        copyFileNameLabel: "Копіювати назву файлу",
        copyAbsolutePathLabel: "Копіювати абсолютний шлях",
        copyShellEscapedPathLabel: "Копіювати екранований шлях",
        copyShellEscapedPathCaption: "Шляхи в лапках для вставлення в команду Термінала.",
        extensionTitle: "Постачальники файлів",
        extensionCaption: "Системні параметри → Основні → Об’єкти входу й розширення → Постачальники файлів (ⓘ).",
        extensionOpen: "Відкрити постачальників файлів…",
        extensionEnabled: "Увімкнено",
        extensionDisabled: "Вимкнено"
    )

    static let tr = FinderRightClickFeatureStrings(
        pageTitle: "Finder sağ tık",
        hubTitle: "Finder sağ tık",
        hubDescription: "Finder bağlamsal menüsüne Yeni Dosya ve Kopyalama Seçenekleri ekler.",
        enableLabel: "Finder bağlamsal menüsünde göster",
        enableCaption: "Sistem Ayarları’nda Dosya Sağlayıcıları altında Finder Sync uzantısının açılması gerekir.",
        newFileLabel: "Yeni Dosya",
        newFileCaption: "Geçerli klasörde .txt, .md, .docx, .xlsx veya .pptx oluşturur.",
        copyOptionsLabel: "Kopyalama Seçenekleri",
        copyFileNameLabel: "Dosya adını kopyala",
        copyAbsolutePathLabel: "Mutlak yolu kopyala",
        copyShellEscapedPathLabel: "Kaçışlı yolu kopyala",
        copyShellEscapedPathCaption: "Terminal komutuna yapıştırmaya hazır tırnaklı yollar.",
        extensionTitle: "Dosya Sağlayıcıları",
        extensionCaption: "Sistem Ayarları → Genel → Giriş Öğeleri ve Uzantılar → Dosya Sağlayıcıları (ⓘ).",
        extensionOpen: "Dosya Sağlayıcılarını Aç…",
        extensionEnabled: "Açık",
        extensionDisabled: "Kapalı"
    )

    static let sk = FinderRightClickFeatureStrings(
        pageTitle: "Pravé kliknutie Finderu",
        hubTitle: "Pravé kliknutie Finderu",
        hubDescription: "Pridá Nový súbor a Možnosti kopírovania do kontextovej ponuky Finderu.",
        enableLabel: "Zobraziť v kontextovej ponuke Finderu",
        enableCaption: "Vyžaduje zapnutie dodaného rozšírenia Finder Sync v časti Poskytovatelia súborov.",
        newFileLabel: "Nový súbor",
        newFileCaption: "Vytvorí .txt, .md, .docx, .xlsx alebo .pptx v aktuálnom priečinku.",
        copyOptionsLabel: "Možnosti kopírovania",
        copyFileNameLabel: "Kopírovať názov súboru",
        copyAbsolutePathLabel: "Kopírovať absolútnu cestu",
        copyShellEscapedPathLabel: "Kopírovať escapovanú cestu",
        copyShellEscapedPathCaption: "Cesty v úvodzovkách pripravené na príkaz Terminalu.",
        extensionTitle: "Poskytovatelia súborov",
        extensionCaption: "Systémové nastavenia → Všeobecné → Prihlasovacie položky a rozšírenia → Poskytovatelia súborov (ⓘ).",
        extensionOpen: "Otvoriť poskytovateľov súborov…",
        extensionEnabled: "Zapnuté",
        extensionDisabled: "Vypnuté"
    )
}
