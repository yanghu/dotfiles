-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.loader.enable()

require("config.lazy")
require("config.autocmds")
require("config.keymaps")
require("config.options")
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
