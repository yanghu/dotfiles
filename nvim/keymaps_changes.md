# Neovim 0.12 快捷键及功能变更对照表

这份文档详细梳理了清理 `lspsaga.nvim` 和 `hop.nvim` 以及更改搜索高亮逻辑后，你的快捷键发生了哪些改变，以及**现在你应该使用什么替代键**。

由于你的配置中已经包含了非常优秀的替代插件（如 `Telescope`，`Aerial`，`Leap`，`Flash` 以及 Neovim 0.11+ 的原生功能），你实际上没有丢失任何能力，反而获得了更加统一且高性能的体验。

## 1. LSP 功能 (原 Lspsaga 快捷键 ➡️ 新的替代)

由于移除了容易引起卡顿的 `lspsaga.nvim`，我们全面转向了 **Neovim 原生 LSP 功能** 和 **Telescope** 弹窗。

| 功能描述 | ❌ 以前的快捷键 (Lspsaga) | ✅ 现在的推荐快捷键 (原生/Telescope) | 备注说明 |
| :--- | :--- | :--- | :--- |
| **悬浮文档** (Hover) | `gk` | **`K`** | Neovim 标准原生快捷键，你的 `noice.nvim` 会接管它，提供非常漂亮的悬浮边框外观。 |
| **跳转到定义** (Definition) | `gd` | **`gd`** | Neovim 0.11+ 标准原生快捷键。 |
| **查看引用** (References) | `gr` | **`grr`** 或用 Telescope | `grr` 是 Nvim 0.11+ 原生快捷键。如果你偏好 Telescope 搜索面板，你可以在 `lsp.lua` 里解除注释 `<leader>gr` 或类似键位。 |
| **代码动作** (Code Action) | `<leader>ca` | **`gra`** | Neovim 0.11+ 标准原生快捷键。弹出原生的代码修复建议菜单。 |
| **重命名变量** (Rename) | 无特定 (或依赖 saga) | **`<leader>rn`** 或 **`grn`** | 你已经在 `lsp.lua` 映射了 `<leader>rn`；另外 `grn` 是 Nvim 原生快捷键。 |
| **实现跳转** (Implementation) | `gI` | **`gI`** | 依然是 `gI`，但现在由 **Telescope** 接管，弹出查找面板，体验更好。 |
| **类型定义跳转** | `gY` | **`<leader>D`** | 你在 `lsp.lua` 中已经将其映射为通过 **Telescope** 查找类型定义。 |
| **查看大纲** (Outline) | `<leader>go` | **`<leader>a`** | 你的配置中已经有非常强大的 `aerial.nvim`，按 `<leader>a` 即可在右侧切换大纲窗口。 |
| **查看行诊断错误** | `<leader>sl` | **`<leader>df`** | 原生功能 `vim.diagnostic.open_float`，悬浮显示当前行的错误详情。 |
| **上/下一个错误诊断** | `[d` / `]d` | **`[d` / `]d`** | 快捷键不变，但现在由原生的 `vim.diagnostic.goto_prev/next` 接管。 |

---

## 2. 快速跳转 (原 Hop 快捷键 ➡️ Leap/Flash)

你原本在 `coding.lua` 中安装了 **3个** 跳转插件（`hop.nvim`, `leap.nvim`, `flash.nvim`），功能完全重叠。移除 `hop.nvim` 后，你可以使用更现代的 `Leap` 和 `Flash`。

| 功能描述 | ❌ 以前的快捷键 (Hop) | ✅ 现在的推荐快捷键 (Leap / Flash) | 备注说明 |
| :--- | :--- | :--- | :--- |
| **向下/上跳到特定行** | `<leader>j` / `<leader>k` | **`s` (Leap)** | 你已经配置了 `leap.nvim`。只需按 `s` + 屏幕上你想跳去的**任意两个字符**，即可全屏瞬间跳转，完全取代了按行跳转的繁琐。 |
| **跳转到特定单词** | `<leader>w` / `<leader>W` | **`s` (Leap)** | 同上，使用 `s` + 单词前两个字母。 |
| **Treesitter 节点选择** | 无 | **`S` (Flash)** | 按大写 `S`，`flash.nvim` 会高亮当前代码的 Treesitter 语法树结构，让你一键选中整个函数、整个块或整个类。这是神级功能。 |
| **远程操作** (Remote) | 无 | **`r` (Flash)** | 在操作模式下（如按了 `y` 复制或 `d` 删除后），按 `r` 然后选一个位置，可以直接对远处的内容执行操作而光标不移动。 |

---

## 3. 搜索高亮取消 (原自动脚本 ➡️ 手动一键清除)

| 功能描述 | ❌ 以前的逻辑 (自动) | ✅ 现在的逻辑 (手动) | 备注说明 |
| :--- | :--- | :--- | :--- |
| **清除搜索后的高亮** | 光标移动后自动计算并取消 | **在普通模式下按 `<Esc>`** | 以前那段近 40 行的脚本不仅拖慢性能，有时还会导致判断失误。现在你只需在搜索完想取消高亮时，习惯性地拍一下 `<Esc>` 即可（这也是 Vim 社区推荐的 Best Practice）。你的通知弹窗 (Notify) 也会同时被 Dismiss 掉。 |