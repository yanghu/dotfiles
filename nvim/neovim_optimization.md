# Neovim 0.12 Configuration Optimization Plan

## Objective
Streamline and modernize the Neovim configuration to leverage built-in features of Neovim 0.12+, remove redundant or obsolete plugins (like `hop.nvim`, `lspsaga.nvim`, and `neodev.nvim`), and eliminate complex custom code (like the manual search highlight toggling) in favor of simpler, native alternatives.

## Key Files & Context
- `lua/config/autocmds.lua`: Contains the `ToggleSearchHL` augroup which is overly complex and unnecessary.
- `lua/config/keymaps.lua`: Needs a new keymap to clear search highlight (`<Esc>`).
- `lua/plugins/coding.lua`: Contains `hop.nvim` which is superseded by `flash.nvim`.
- `lua/plugins/lsp.lua`: Contains `lspsaga.nvim` and `neodev.nvim` which are obsolete/redundant.
- `lua/plugins/ui.lua`: Contains references to `lspsaga` in `lualine.nvim` configuration.

## Implementation Steps

### 1. Remove `ibhagwan/ToggleSearchHL` (`lua/config/autocmds.lua`)
- Delete the entire `augroup("ibhagwan/ToggleSearchHL", ...)` block. This removes the complex logic for toggling search highlights on cursor move.

### 2. Add `<Esc>` Keymap to Clear Search Highlight (`lua/config/keymaps.lua`)
- Add the following line to clear search highlights explicitly when pressing `<Esc>` in normal mode:
  ```lua
  nmap("<Esc>", "<cmd>nohlsearch<CR><Esc>", { desc = "Clear search highlight" })
  ```

### 3. Remove `hop.nvim` (`lua/plugins/coding.lua`)
- Delete the entire `hop.nvim` plugin configuration block. `flash.nvim` provides a superior and overlapping feature set.

### 4. Remove `lspsaga.nvim` and `neodev.nvim` (`lua/plugins/lsp.lua`)
- Remove `{ "folke/neodev.nvim", opts = {} , enabled=false}` from the `dependencies` list of `neovim/nvim-lspconfig` (the local lsp function).
- Remove the entire `nvimdev/lspsaga.nvim` plugin configuration block.
- Remove all `Lspsaga` keymaps from the `keys` table of the `neovim/nvim-lspconfig` plugin definition. We will rely on Neovim's built-in LSP capabilities and `Telescope` (which is already configured in the `LspAttach` autocommand) for these features.

### 5. Remove `lspsaga` references from `lualine.nvim` (`lua/plugins/ui.lua`)
- Remove `"nvimdev/lspsaga.nvim"` from the `dependencies` of `lualine.nvim`.
- Remove `opts.sections.lualine_c = { { require("lspsaga.symbol.winbar").get_bar } }` from the `config` function of `lualine.nvim`.

## Verification & Testing
1.  **Restart Neovim:** Ensure Neovim starts without errors.
2.  **Verify Search Highlight:** Search for a term (`/pattern`), then press `<Esc>` to confirm the highlight clears.
3.  **Verify Plugin Removal:** Run `:Lazy` and verify that `hop`, `lspsaga`, and `neodev` are no longer installed or loaded.
4.  **Test LSP Functionality:** Open a file with LSP support (e.g., `.lua`), test hover (`K`), go to definition (`gd` - mapped to telescope), and ensure the UI looks clean without `lspsaga`.
5.  **Check Lualine:** Ensure the statusline loads correctly without `lspsaga` winbar errors.

## Note on Code Completion (blink.cmp)
Migrating from `nvim-cmp` to `blink.cmp` is recommended for future optimization but is omitted from this initial cleanup phase to minimize risk and focus on removing dead code first. It can be tackled in a separate step if desired.