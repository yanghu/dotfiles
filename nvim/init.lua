-- Set leader key
vim.g.mapleader = ','
vim.g.maplocalleader = ','

require('config.lazy')
require('config.options')

-- Useful functions
local function map(kind, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(kind, lhs, rhs, options)
end

local function nmap(lhs, rhs, opts)
  map('n', lhs, rhs, opts)
end

local function imap(lhs, rhs, opts)
  map('i', lhs, rhs, opts)
end


vim.g.have_nerd_font = true
-- ==============================================
-- [[ Basic Auto Commands ]]
-- ==============================================

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Switch to relative number mode in normal mode.
local number_toggle = vim.api.nvim_create_augroup('numtoggle', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave' }, {
  pattern = '*',
  group = number_toggle,
  command = 'set relativenumber',
})
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter' }, {
  pattern = '*',
  group = number_toggle,
  command = 'set norelativenumber',
})


-- ==============================================
-- [[ Basic Keymaps ]]
-- ==============================================

-- Use space to cancel search highlight
nmap('<Space>', '<cmd>nohlsearch<CR>')


-- [[ Key bindings ]]

local wk = require("which-key")
-- -- Easymotion: 
-- -- Use "s" and enter two chars to move
-- wk.register({
--   s = { "<Plug>(easymotion-overwin-f2)", "Enter two characters and jump." },
-- })
wk.register({
  e = {
    name = "easymotion", -- optional group name
  },
}, {prefix = "<leader>"})


-- Themes
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
