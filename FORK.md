# Fork notes (loudlymeow)

Private fork of [vorssaint/vorssaint-utils](https://github.com/vorssaint/vorssaint-utils).
These changes are **not** intended for an upstream pull request.

## Remotes

| Remote | URL |
|--------|-----|
| `origin` | `https://github.com/loudlymeow/vorssaint-utils.git` |
| `upstream` | `https://github.com/vorssaint/vorssaint-utils.git` |

Feature work lives on `feat/finder-right-click`.

## What this fork adds

Optional **Finder right-click** feature (`AppFeature.finderRightClick`):

- Finder Sync appex with **New File** (`.txt` / `.md` / `.docx` / `.xlsx` / `.pptx`) and **Copy Options** (name, absolute path, shell-escaped path)
- Host creates Office files from bundled templates via a custom URL scheme; copy actions run in the extension
- Preferences in `~/Library/Application Support/Vorssaint[ Developer]/finder-right-click.json`
- Settings → Features → install **Finder right-click**, then enable under **System Settings → General → Login Items & Extensions → File Providers** (ⓘ)

Default: **not** installed (`installedByDefault == false`).

## Build and run (Developer)

```bash
./build.sh --dev --install
```

Finder Sync needs a team-bearing signature. `build.sh` prefers:

1. Developer ID Application  
2. **Apple Development** (free Apple ID via Xcode)  
3. Local `Vorssaint Utils Signing` / ad-hoc (extensions usually **will not** appear under File Providers)

If `security find-identity -v -p codesigning` shows 0 valid identities after creating an Apple Development certificate, install Apple’s **WWDR G3** intermediate from [Apple PKI](https://www.apple.com/certificateauthority/).

## Keeping up with upstream

Validate **before** pushing to `origin`:

```bash
git fetch upstream
git checkout feat/finder-right-click
git rebase upstream/main   # or: git merge upstream/main
# resolve conflicts if any

./build.sh --test
./build.sh --dev --install
# smoke-check Finder right-click and File Providers

git push --force-with-lease origin feat/finder-right-click
```

Likely conflict hotspots when rebasing: `FeatureCatalog.swift`, `build.sh`, `FeatureCatalogTests.swift`, Settings visibility/directory files.
