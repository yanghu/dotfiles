-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.loader.enable()

require('config.lazy')
require('config.options')
require('config.autocmds')
require('config.keymaps')

-- Themes
vim.o.background = "dark" -- or "light" for light mode

require("bufferline").setup{
  highlights = require("catppuccin.groups.integrations.bufferline").get(),
  options = {
    numbers = "bufer_id",
    diagnostics = "nvim_lsp",
  },
}

-- TODO: setup telescope grep keymappings for:
--   * grep current project
--   * grep current buffer's dir
--   * glob grep?
--   * grep current buffer lines
--
--   Grapple/Harpoon?
--
--   Setup snippets
--   
--   nvim outline
--   nvim lightbulb
--
