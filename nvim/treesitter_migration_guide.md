# Nvim Treesitter 迁移踩坑指南 (适配 Neovim 0.12+ / 0.10+)

随着 Neovim 核心 API 的破坏性更新（尤其是 `0.10+` 和 `0.12` 中对 `range` 方法的废弃），`nvim-treesitter` 插件生态发生了一次彻底的架构大洗牌。

如果在新机器上部署，或者更新配置时遭遇了崩溃，请参考这份“踩坑排雷指南”。

## 架构变化背景
1. **`master` 分支被冻结**：所有新特性、Neovim 新版本适配均迁移至 `main` 分支。
2. **抛弃内建编译器**：`main` 分支不再自带解析器的编译能力，强制要求系统提供 `tree-sitter` CLI 工具。
3. **配置模块重构**：废弃了庞大的 `require('nvim-treesitter.configs')`，生态插件（如 `textobjects`、`autotag`）必须独立配置并同步迁移至 `main` 分支。

---

## 💣 坑 1：`attempt to call method 'range' (a nil value)`
**原因**：你在使用旧版（`master`）的 `nvim-treesitter`，而它调用了新版 Neovim 核心中已经被删除的旧 API，导致 Markdown/FZF 搜索时触发空指针崩溃。

**解决**：将核心插件的分支切换到 `main`。
```lua
{
    "nvim-treesitter/nvim-treesitter",
    branch = "main", -- 必须是 main
    build = ":TSUpdate",
}
```

---

## 💣 坑 2：`module 'nvim-treesitter.configs' not found`
**原因**：切换到 `main` 分支后，官方删除了 `configs` 这个统一配置模块。如果你原先的配置是将所有子插件（`textobjects`, `autotag` 等）塞在 `nvim-treesitter.configs.setup` 里，启动时就会报错。

**解决**：
1. `nvim-treesitter-textobjects` 必须同步显式指定 `branch = "main"`。
2. 将原本写在 `configs.setup` 内部的 `textobjects` 和 `autotag` 剥离，单独调用它们各自的 `setup()`：
```lua
require("nvim-treesitter-textobjects").setup({
    -- textobjects 的配置独立写在这里
})
```

---

## 💣 坑 3：`;` 和 `,` 重复跳转失效或报错
**原因**：在 `main` 分支中，`repeatable_move` 模块的路径发生变更，且原生 `f / F / t / T` 的复用劫持机制改变了 API 命名（需要带 `_expr` 后缀并开启表达式计算）。

**解决**：
使用新版规范映射你的快捷键：
```lua
local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move") -- 路径变更为横杠
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- 原生字符查找绑定，必须使用 _expr 后缀，并且加上 { expr = true }
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
```

---

## 💣 坑 4：`:TSUpdate` 报错 `no such file or directory (cmd): 'tree-sitter'`
**原因**：`main` 分支的 `nvim-treesitter` 不再自带编译器，强制要求系统环境变量 `$PATH` 中存在官方的 `tree-sitter` 可执行文件。

**常规解决**：
```bash
npm install -g tree-sitter-cli
# 或者
cargo install tree-sitter-cli
```

---

## 💣 坑 5：NPM 安装后报错 `GLIBC_2.39 not found`
**原因**：通过 NPM 下载的 `tree-sitter-cli` 预编译二进制文件，是基于非常新的 Linux 环境打包的（如 Ubuntu 24.04）。如果你使用的是较老的系统（如 Ubuntu 22.04，GLIBC 仅为 2.35），它一运行就会因为底层 C 运行库版本过低而崩溃。而通过 Cargo 安装可能又会遭遇 Rust 版本过旧的问题。

**终极解决**：
卸载 NPM 损坏版本，直接去 GitHub 下载官方的“纯净静态编译包”，彻底绕过本地 GLIBC 版本和 Rust 工具链的限制：

```bash
# 1. 卸载报错版本
npm uninstall -g tree-sitter-cli

# 2. 手动下载静态编译版本 (v0.24.7 为例)
wget https://github.com/tree-sitter/tree-sitter/releases/download/v0.24.7/tree-sitter-linux-x64.gz

# 3. 解压并赋予可执行权限
gzip -d tree-sitter-linux-x64.gz
chmod +x tree-sitter-linux-x64

# 4. 移动到 PATH 路径下 (确保 ~/.local/bin 在你的环境变量中)
mv tree-sitter-linux-x64 ~/.local/bin/tree-sitter
```

**验证**：在终端运行 `tree-sitter --version`，只要能正常输出版本号即代表环境修复完成。此时回到 Neovim 运行 `:TSUpdate` 即可完美编译所有语言。