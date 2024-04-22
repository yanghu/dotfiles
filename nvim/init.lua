-- Set leader key
vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.loader.enable()

require('config.lazy')
require('config.options')
require('config.autocmds')
require('config.keymaps')

-- Themes
vim.o.background = "dark" -- or "light" for light mode

-- vim.cmd([[colorscheme gruvbox]])
vim.cmd([[colorscheme kanagawa]])
