# Neovim 配置说明书 (Neovim Configuration Manual)

这份说明书梳理了本 Neovim 配置的整体架构、核心插件、模块间的依赖与协作关系，以及关键的自定义配置（Caveats & Hacks），方便未来维护和扩展。

## 📁 目录结构与核心入口

配置采用了结构化的方式，统一由 `lazy.nvim` 管理插件，入口和核心配置分离：
*   **`init.lua`**: 主入口文件，设定 Leader 键（`Space`）和 LocalLeader 键（`,`），并按顺序加载基础配置。
*   **`lua/config/`**: Neovim 的原生行为与核心设定。
    *   `lazy.lua`: 配置 `lazy.nvim` 插件管理器。
    *   `options.lua`: 原生选项（如缩进、搜索、折叠、UI 表现等）。
    *   `autocmds.lua`: 自动命令（如高亮复制、自动切换相对行号、保存时自动创建目录等）。
    *   `keymaps.lua`: 基础快捷键（不依赖具体插件的快捷键映射）。
    *   `lsp.lua`: 定义要启用的 LSP Server 列表及各 Server 的独有设定。
    *   `ui.lua`: UI 相关常量（如图标、边框样式）及 Alpha 启动页配置。
*   **`lua/plugins/`**: 按功能划分的插件配置。
    *   `coding.lua`: 编码辅助（自动补全、代码片段、注释、跳转等）。
    *   `editor.lua`: 编辑器增强（文件搜索、大纲、诊断面板、会话管理等）。
    *   `formatting.lua`: 代码格式化设定。
    *   `lsp.lua`: LSP 相关的整体安装与关联配置。
    *   `treesitter.lua`: 语法高亮与代码结构解析。
    *   `ui.lua`: 界面美化（状态栏、标签页、通知等）。

---

## 🧩 核心模块与依赖关系 (Dependencies & Collaborations)

### 1. 语言智能：LSP + 补全 + 格式化
这部分由多个插件协同工作，是最核心也是最容易出问题的部分。

*   **安装管理**: `mason.nvim` 负责底层安装各种 LSP servers, formatters, linters。
*   **LSP 连接**:
    *   `mason-lspconfig.nvim` 作为桥梁，让 mason 安装的 server 能被 `nvim-lspconfig` 感知。
    *   `nvim-lspconfig` 负责将 LSP 挂载到当前 Buffer。
    *   **配置来源**: 具体的 server 列表定义在 `lua/config/lsp.lua` 中（分为工作区与本地环境）。
    *   **LspAttach**: 在 `lua/plugins/lsp.lua` 中配置了 `LspAttach` 的 Autocmd，当 LSP 挂载成功后，会绑定一系列基于 Telescope 的快捷键（如 `gd` 找定义，`grr` 找引用），并配置 Hover、Signature Help 等功能。
*   **自动补全**: 使用 **`blink.cmp`**（而非传统的 nvim-cmp），提供极速补全。
    *   **协作**: `blink.cmp` 读取 LSP 提供的补全源，同时结合 `LuaSnip` 提供代码片段补全。对于 Neovim API，通过 `lazydev.nvim` 注入 Lua 补全提示。
*   **代码格式化**: 由 **`conform.nvim`** (`lua/plugins/formatting.lua`) 统一接管。
    *   **协作**: 优先使用这里定义的外部格式化工具（如 `prettierd`, `stylua`, `goimports`）。如果某语言没配置工具，则支持回退（fallback）到对应 LSP 自身的格式化能力。
    *   **自动格式化**: 针对 `go`, `lua`, `markdown` 启用了保存时自动格式化。

### 2. 搜索与导航体系：Fzf-Lua vs Telescope
本配置中并存了两大搜索框架，但做了侧重划分：

*   **主力搜索: `fzf-lua`** (`lua/plugins/editor.lua`)
    *   **特点**: 速度极快，处理大仓库性能优异。
    *   **接管的快捷键**: 几乎所有的 `<leader>s` 开头的搜索快捷键，以及找文件 `<leader>f`, `<leader>gf`（Git 文件）, `<leader>/`（全局 Grep）。
*   **辅助/生态整合: `telescope.nvim`**
    *   主要用于与 LSP 深度绑定的查询（如 `<leader>ds` Document Symbols, `gd` Go to Definition 等），以及管理会话 `persisted.nvim` (`<leader>sp`) 的选择器。

### 3. UI 与交互增强：Noice + Lualine + Trouble
*   **`noice.nvim`**: 劫持并美化了 Neovim 的命令行输入区（Cmdline）和消息通知。
    *   **协作**: 并且接管了 LSP 的 Hover (`K`) 和 Signature 弹出窗口，为其提供更优雅的 markdown 渲染（依赖 Treesitter）。如果消息过长，会自动分屏显示。
*   **`lualine.nvim`**: 底部状态栏。
    *   **协作**: 与 `noice` 联动，在状态栏展示宏录制或搜索状态。
*   **`trouble.nvim`**: 集中展示整个项目或文件的 Warning/Error，以及按列表展示 LSP 的搜索结果，由 `<leader>x` 触发。

### 4. Treesitter 语法生态
不只是用来高亮，更是众多高级功能的基础：
*   **`nvim-treesitter`**: 提供 AST（抽象语法树）解析，取代正则提供精准高亮和代码折叠（配置中通过 `v:lua.vim.treesitter.foldexpr()` 启用了基于 Treesitter 的折叠）。
*   **`nvim-treesitter-textobjects`**: 基于 AST 的代码块文本对象操作。比如 `yaf` 选中整个函数，`]m` 跳转到下一个方法开头。
*   **`treesitter-context`**: 滚动长代码时，将当前函数/类签名固定在屏幕顶部。
*   **`flash.nvim`**: 通过 `S` 触发 Treesitter 模式的代码块快速选中。

### 5. LSP 与搜索框架的联动 (LSP & Search Engines)
配置巧妙地将 LSP 的语义化能力与 Telescope/Fzf-Lua 的 UI 能力结合，分工如下：

*   **Telescope 接管精准跳转 (精准跳转场景)**:
    在 `lua/plugins/lsp.lua` 的 `LspAttach` 逻辑中，大部分基于代码结构的查询由 Telescope 负责，因为其具备更好的预览交互：
    *   `gd`: 跳转定义 (`lsp_definitions`)。
    *   `grr`: 寻找引用 (`lsp_references`)。
    *   `gri`: 跳转实现 (`lsp_implementations`)。
    *   `<leader>D`: 跳转类型定义 (`lsp_type_definitions`)。
    *   `<leader>ds`: 当前文件符号表 (`lsp_document_symbols`)。
*   **Fzf-Lua 接管诊断与广域搜索 (性能优先场景)**:
    在 `lua/plugins/editor.lua` 中，为了极致的响应速度，使用 Fzf-Lua 处理：
    *   `<leader>sd`: 展示整个文档的 Diagnostics（诊断信息）。
    *   `<leader>dd`: 搜索文档内 Symbols（符号），这是 Telescope `<leader>ds` 的补充，由于 Fzf-Lua 的极速模糊过滤，更适合快速模糊搜索已知名称的符号。
    *   `<leader>sq`: 展示 Quickfix 列表内容。
*   **Noice 接管视觉渲染**:
    所有的 LSP 浮动窗（Hover 文档、方法签名）不再由原生渲染，而是由 `noice.nvim` 配合 Treesitter 进行 Markdown 高亮渲染，解决了原生浮动窗难以滚动和视觉枯燥的问题。

### 6. Git 全流程工作流 (Git Workflow)
配置集成了一套从“单行变更”到“全库管理”的完整 Git 工具链：

*   **实时状态反馈 (Gitsigns.nvim)**:
    在 `lua/plugins/ui.lua` 中配置。它在编辑器左侧行号栏（Signcolumn）提供实时的 `+` / `-` / `~` 变更标记。
    *   **协作**: 提供了一套强大的 Hunk 操作快捷键（`<leader>h` 开头），支持单块预览 (`<leader>hp`)、单块撤销 (`<leader>hr`) 和单块暂存 (`<leader>hs`)。
    *   **行级责备 (Blame)**: 支持实时显示当前行的 Git Blame 信息 (`<leader>htb`)。
*   **重型仓库管理 (Vim-Fugitive & Vim-Flog)**:
    在 `lua/plugins/coding.lua` 中配置。
    *   **Fugitive**: Neovim 中最强大的 Git 封装。通过 `:Git` (或快捷键 `<leader>gs`) 调出交互式状态面板，支持直接在面板里进行 Add, Commit, Push 等操作。
    *   **Flog**: 提供极致的 Git Graph（提交历史树）可视化。通过 `:Flog` 查看分支分叉与合并历史，非常适合处理复杂的分支关系。
*   **模糊搜索与 Git 联动 (Fzf-Lua)**:
    在 `lua/plugins/editor.lua` 中，利用 Fzf-Lua 的高性能搜索 Git 相关内容：
    *   `<leader>gf`: 仅在 Git 追踪的文件中搜索（自动过滤 `.gitignore` 掉的内容）。
    *   `<leader>gc`: 搜索全库的 Commit 历史。
    *   `<leader>gb`: 搜索当前 Buffer 的提交记录（Buffer Commits）。
*   **状态栏联动**:
    `lualine.nvim` 会实时显示当前分支名以及当前的增删改统计数据，确保你对代码仓库状态始终心中有数。

---

## 🛠️ 重要的 Hacks, Caveats & 特殊细节

如果你以后需要修改配置，请务必注意以下细节：

### 1. 环境感知与按需加载 (Work vs Local)
配置中深度集成了一套基于环境变量的环境感知机制，用来严格区分“个人本地环境”与“公司工作环境”，避免插件或行为在不同环境下水土不服。

*   **判定逻辑**: 在 `lua/utils/env.lua` 中，定义了核心函数 `at_work()`，它通过读取操作系统的环境变量 `ATWORK` 是否等于 `"1"` 来进行判断。
*   **对 LSP 自动安装与配置的阻断**:
    *   在 **`lua/config/lsp.lua`** 中，如果 `at_work()` 返回 `true`，则会将 `M.servers` 强制设置为空表 `{}`。这意味着在工作环境下，不再自动注册像 `bashls`, `clangd`, `gopls`, `pyright`, `lua_ls` 等基础语言服务。
    *   在 **`lua/plugins/lsp.lua`** 中，整个 `local_lsp()` 配置块被包裹在 `if not env.at_work() then` 判断中。一旦处于工作环境，它将彻底禁用以下功能：
        1. 禁用 `mason.nvim`, `mason-lspconfig.nvim`, `mason-tool-installer` 这套自动下载和编译 LSP 工具链的机制（因为工作电脑往往有内网限制或不需要标准的开源 LSP）。
        2. 禁用由 `LspAttach` 自动命令绑定的所有标准 LSP 快捷键（如 `gd`, `grr`, `<leader>rn` 等）。
        3. 禁用与此绑定的悬浮窗 UI 和错误诊断显示 (`[d`, `]d`) 的默认挂载。
*   **工作区专属扩展**:
    *   **路径解析与复制 Hack**: 在 **`lua/config/keymaps.lua`** 中，定义了专用的 `GCF` 命令与快捷键 (`<localleader>ccf`, `<localleader>ccg`, `<localleader>ccd`)。这些命令调用了外部 `piperlib#GetDepotPath` 函数，专门用于去除和处理工作区特定的 `//depot/google3/` 前缀，将准确的内部代码库路径拷贝到系统剪贴板。
    *   **工作区专属插件入口**: 在 **`lua/config/lazy.lua`** 中预留了 `require("plugins.work").work_plugins` 的加载口（当前被注释）。在工作环境下，可通过此文件按需加载仅限内网使用的专用代码辅助插件。

### 2. 格式化控制 (Autoformatting)
*   `conform.nvim` 定义了全局变量控制格式化。
*   **Hack**: 如果你遇到某个文件不想自动格式化，可以使用自带的自定义命令 `:FormatDisable`（当前 Buffer 关闭）或 `:FormatDisable!`（全局关闭），通过 `:FormatEnable` 恢复。

### 3. FZF 与性能优化
*   在 `fzf-lua` 的 `oldfiles` 配置中，`stat_file = false` 被显式设置。
*   **Caveat**: 这是为了避免在网络存储或慢速磁盘上检查文件是否存在而导致的高延迟卡顿。

### 4. 会话管理 (Sessions)
*   使用 `persisted.nvim` 管理会话。
*   **Hack**: 在 `persisted.lua` 的 `should_autosave` 回调中写入了保护逻辑，防止在打开 Alpha 启动页或开启了浮动窗口（如 oil）时意外保存会话导致界面错乱。

### 5. 键位冲突与 Workarounds
*   `which-key` 在 Neovim 中对局部 Leader 键（`,`）的支持有时会有问题，配置中曾留有手动挂载 Autocmd 的 workaround 注释。
*   Treesitter 的文本对象跳转整合了 `nvim-treesitter-textobjects.repeatable_move`，这意味着按下 `]` 或 `[` 跳转后，可以直接按 `;` 或 `,` 继续上一次的相同跳转，同时劫持了原生 `f/F/t/T` 的行为。这极大提高了跳转效率。

### 6. 快捷键管理约定
*   本配置尽量将大部分快捷键与插件定义放在了一起（在 Lazy 插件的 `keys` 属性中），这属于 Lazy 加载范畴；
*   但 LSP 特有的快捷键放在了 `LspAttach` 自动命令中 (`lua/plugins/lsp.lua`)。
*   通用或者纯原生的映射放在了 `lua/config/keymaps.lua`，这里的 `nmap` 和 `imap` 是自定义的包裹函数。

---

## 🚀 日常维护指南 (How to Maintain)

1.  **添加新插件**: 在 `lua/plugins/` 找个相关类别的 `.lua` 文件（比如添加一个前端高亮插件，就放在 `coding.lua` 或新建一个）。遵循 Lazy.nvim 的 `return { ... }` 格式。
2.  **添加新语言支持**:
    *   需要在 `lua/config/lsp.lua` 中的 `local_servers` 添加 LSP 名称。
    *   如果有格式化要求，去 `lua/plugins/formatting.lua` 的 `formatters_by_ft` 里加上该语言的格式化工具。
    *   如果有自动补全的代码片段，放在 `lua/snippets/` 下。
3.  **排查 UI 问题**: 多数弹窗问题出在 `noice.nvim` 上，如果不习惯它的 Cmdline 行为，可以在 `ui.lua` 中临时将 `noice` 的 `enabled = false`。
4.  **更新插件**: 输入 `:Lazy update`。由于 `lazy.lua` 中锁定了 `version = "*"` 默认策略，通常会拉取稳定版本（Tag），相对安全。但如果不小心引入 breaking changes，去 `.git` 或 `~/.local/share/nvim/lazy/` 退回对应的 commit。