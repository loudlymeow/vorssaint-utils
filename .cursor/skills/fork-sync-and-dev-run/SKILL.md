---
name: fork-sync-and-dev-run
description: >-
  Sync this loudlymeow fork with upstream vorssaint/vorssaint-utils, then
  build and run the Developer app. Use when the user says the original project
  updated, sync upstream, rebase onto upstream/main, or compile/build/install/run
  locally. Also use codegraph for requirement/code analysis in this repo.
---

# Fork：同步上游 + 本地编译运行

私有 fork（**不上游 PR**）。细节见仓库根目录 `FORK.md`。

| Remote | URL |
|--------|-----|
| `origin` | `https://github.com/loudlymeow/vorssaint-utils.git` |
| `upstream` | `https://github.com/vorssaint/vorssaint-utils.git` |

功能分支默认：`feat/finder-right-click`。

## 前置：GitHub 一律走代理

凡 `git`（github remote）/ `gh` / GitHub API，先导出再执行（与个人 skill `github-network-and-identity` 一致）：

```bash
export https_proxy=http://127.0.0.1:7897
export http_proxy=http://127.0.0.1:7897
export ALL_PROXY=socks5://127.0.0.1:7897
```

## 需求分析用 CodeGraph

改代码或摸清结构前，用 `codegraph_explore`（`projectPath` = 本仓库绝对路径）。本地地图：`PROJECT_MAP.md`（已 gitignore）。无索引时：`codegraph init -y .`；之后：`codegraph sync .`。

## A. 同步上游（原始项目更新）

1. 看工作区：未提交本地笔记（如 `.gitignore` / `PROJECT_MAP`）先 `git stash`，避免挡 rebase。
2. `git fetch upstream`（需要时再 `git fetch origin`）。
3. 确认在功能分支：`git checkout feat/finder-right-click`。
4. `git rebase upstream/main`（用户明确要求 merge 再用 merge）。
5. 冲突优先看：`FeatureCatalog.swift`、`build.sh`、`FeatureCatalogTests.swift`、Settings 可见性/目录相关文件。
6. 本地 `main` 对齐：`git branch -f main upstream/main`。
7. 推送 fork 功能分支（rebase 改写历史，必须）：

```bash
git push --force-with-lease origin feat/finder-right-click
```

不要擅自 `git push origin main`，除非用户明确要求。

## B. 本地编译并运行

```bash
./build.sh --dev --install
pkill -x "Vorssaint (Developer)" 2>/dev/null || true
open -a "/Applications/Vorssaint (Developer).app"
```

- 产物：`/Applications/Vorssaint (Developer).app`（与正式版共存）。
- 签名优先 Apple Development；扩展出现在 **系统设置 → 通用 → 登录项与扩展 → 文件提供程序**（不是「访达扩展」）。
- 可选冒烟：进程在跑；`pluginkit` 能看到 `com.vorssaint.utils.dev.finder-right-click`。

完整验证（同步后强烈建议，尤其 rebase 有冲突时）：

```bash
./build.sh --test
./build.sh --dev --install
```

## 常用组合

| 用户意图 | 动作 |
|----------|------|
| 原始项目更新了 / 同步 | A →（建议）B |
| 本地编译并运行 | B |
| 同步并验证 | A → `--test` → B |
