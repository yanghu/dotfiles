# Migration Report: `nvim-cmp` to `blink.cmp`

## Overview
This document summarizes the migration of the Neovim autocompletion engine from the Lua-based `nvim-cmp` to the highly performant, Rust-based `blink.cmp`. The migration streamlines the plugin ecosystem by removing several separate sources and formatters, unifying them under a single modern plugin.

## Feature Parity & Comparison

| Feature | `nvim-cmp` (Previous) | `blink.cmp` (New) | Status |
| :--- | :--- | :--- | :--- |
| **Engine Core** | Lua-based (`hrsh7th/nvim-cmp`) | Rust-based (`saghen/blink.cmp`) | 🚀 **Upgraded** (Significantly faster fuzzy matching) |
| **LSP Completion** | `hrsh7th/cmp-nvim-lsp` | Built-in | ✅ **Kept** (Capabilities updated) |
| **Path Completion** | `hrsh7th/cmp-path` | Built-in | ✅ **Kept** |
| **Buffer Completion** | `hrsh7th/cmp-buffer` | Built-in | ✅ **Kept** |
| **Snippet Engine** | `L3MON4D3/LuaSnip` + `cmp_luasnip` | `L3MON4D3/LuaSnip` | ✅ **Kept** (Fully integrated via `snippets = { preset = "luasnip" }`) |
| **Pre-made Snippets** | `rafamadriz/friendly-snippets` | `rafamadriz/friendly-snippets` | ✅ **Kept** |
| **Custom Snippets**| `~/.config/nvim/lua/snippets/` | `~/.config/nvim/lua/snippets/` | ✅ **Kept** |
| **UI & Icons** | `onsails/lspkind.nvim` | Built-in Nerd Font icons | 🔄 **Replaced** (Cleaner, native integration) |
| **Neovim API Setup**| `neodev.nvim` / `lazydev` | `lazydev.nvim` source | ✅ **Kept** (Integrated directly as a provider) |
| **Cmdline (`:`)** | `hrsh7th/cmp-cmdline` | Built-in Cmdline support | ⚠️ **Changed** (See "What Was Lost/Changed" below) |

## What Was Kept / Gained
- **Performance:** `blink.cmp` offloads fuzzy matching and sorting to a pre-compiled Rust binary, eliminating UI freezes during heavy LSP completion requests.
- **Simplicity:** Instead of loading 6-7 different `cmp-*` plugins to stitch together a working completion engine, `blink.cmp` handles LSP, paths, buffers, and formatting natively out-of-the-box.
- **UI Consistency:** By utilizing `appearance.use_nvim_cmp_as_default = true`, `blink.cmp` securely falls back to your existing `nvim-cmp` highlight groups to ensure your colorscheme (e.g., Catppuccin or Gruvbox) doesn't break.

## What Was Lost / Changed
1. **Command Line Completion (`:`):** The explicit `cmp-cmdline` plugin was removed. `blink.cmp` has experimental built-in command line completion that works automatically, but it may feel slightly different than the `cmp-cmdline` preset you were used to.
2. **Explicit `lspkind` customizations:** We removed `lspkind.nvim` and max-width truncation logic. `blink.cmp`'s default UI is naturally clean and handles spacing/icons out of the box, but if you relied heavily on the `...` truncation at exactly 50 characters, you may notice wider popup menus.

---

## ⌨️ Hotkeys & Mappings

The new setup uses `keymap = { preset = "default" }`. **This means your previous custom keymaps were removed and replaced with standard defaults.** 

### Current Active Keymaps (`default` preset)
- **`<C-space>`**: Show completion menu manually.
- **`<C-e>`**: Hide the completion menu.
- **`<C-y>`**: Accept/Confirm the selected completion.
- **`<C-n>` / `<Down>`**: Next item in the list.
- **`<C-p>` / `<Up>`**: Previous item in the list.
- **`<C-f>` / `<C-b>`**: Scroll documentation window down/up.
- **`<Tab>` / `<S-Tab>`**: Jump to the next/previous snippet placeholder.

### How to Restore Your Old Custom Keymaps
In your old `nvim-cmp` config, you had custom mappings for `C-j`/`C-k` (navigation), and `C-l`/`C-h`/`C-e` specifically mapped to `luasnip` functions (expand, jump, change choice).

If you find the `default` preset jarring, you can easily override the `keymap` table in `lua/plugins/coding.lua`.

**To get your exact old keymaps back, change the `keymap` section in `lua/plugins/coding.lua` from:**
```lua
opts = {
    keymap = { preset = "default" },
    -- ...
```

**To this custom mapping setup:**
```lua
opts = {
    keymap = {
        preset = "none", -- Disable default preset
        
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<C-y>"] = { "select_and_accept" },

        -- Your old C-j / C-k navigation
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },

        -- Scroll docs
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },

        -- Snippet Navigation (Replicating your C-l / C-h / C-e LuaSnip behavior)
        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
        -- Note: Custom luasnip `change_choice` (C-e) requires a manual fallback function, 
        -- but C-l and C-h jump natively using the snippet integration.
    },
    -- ...
```

### Next Steps
1. Open any code file (e.g. `.lua`, `.go`) and type `vim.` or a known function to trigger completion.
2. Ensure the icons load correctly and the speed feels snappy.
3. Test your `luasnip` snippets to ensure `friendly-snippets` and your local `~/.config/nvim/lua/snippets/` expand correctly.
4. If you miss your `<C-j>`/`<C-k>` navigation, apply the custom keymap snippet provided above!