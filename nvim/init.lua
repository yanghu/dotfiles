-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.loader.enable()

require("config.lazy")
require("config.options")
require("config.autocmds")
require("config.keymaps")

-- TODO: setup telescope grep keymappings for:
--   * grep current project
--   * grep current buffer's dir
--   * glob grep?
--   * grep current buffer lines
--
--   Grapple/Harpoon?
--
--   nvim outline
--
