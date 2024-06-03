-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.loader.enable()

require("config.options")
require("config.lazy")
require("config.autocmds")
require("config.keymaps")

vim.cmd.colorscheme("gruvbox-material")
-- TODO: setup telescope grep keymappings for:
--   * grep current project
--   * grep current buffer's dir
--   * glob grep?
--   * grep current buffer lines
--   * grep Git commits/bcommits,etc.
--   * Find file in git project
--
--   Grapple/Harpoon?
--
--   nvim outline
--
