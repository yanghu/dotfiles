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


-- Set leader key
vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.g.have_nerd_font = true

vim.opt.backup = true
vim.opt.undofile = true
vim.opt.formatoptions = crqn1j

-- Enable breakindent
vim.opt.breakindent = true
vim.opt.breakindentopt:append({shift=2})

-- Tabs
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.shiftround = true

-- Case-insensitive search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Ignore files
vim.opt.wildignore:append({
  '*.o', '*.d', '00*', 'nohup.out', 'tags', 
  '.hs-tags', '*.hi', '*.gcno', '*.gcda', '*.fasl', '*.pyc'
})
-- MacOS ignore
vim.opt.wildignore:append({
  '*/tmp/*', '*.so', '*.swp', '*.zip', '.DS_Store', '*/.metadata/*'
})
vim.opt.wildignorecase = true

-- Allows scrolling to next/prev lines with left/right
vim.opt.whichwrap:append("<,>,h,l,[,]")

-- Raise a dialog asking if you wish to save changed files
vim.opt.confirm = true

-- Enables magic regex
vim.opt.magic = true

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- ==============================================
--                      Appearnces
-- ==============================================
vim.opt.number = true
vim.opt.relativenumber = true

-- highlight the current line
vim.opt.cursorline = true

-- Display whitespaces
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '-', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Ruler
vim.opt.ruler = true
vim.opt.cc = '80'

-- Don't show mode
vim.opt.showmode = false

-- Themes
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

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




-- ==============================================
-- [[ Plugins ]]
-- ==============================================

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require("lazy").setup({ 
  -- Similar to tpope/vim-commentary. use 'gc' to toggle comment.
  {'numToStr/Comment.nvim', opts = {}, lazy = false },
  -- easymotion
  {'easymotion/vim-easymotion', 
    config = function ()
      vim.g.EasyMotion_use_upper = 1
    end,
  },

  -- Show pending keybinds.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts =...}
})



-- [[ Key bindings ]]

local wk = require("which-key")
-- Easymotion: 
-- Use "s" and enter two chars to move
wk.register({
  s = { "<Plug>(easymotion-overwin-f2)", "Enter two characters and jump." },
})
wk.register({
  e = {
    name = "easymotion", -- optional group name
    e = { "<Plug>(easymotion-lineanywhere)", "Line anywhere." },
    s = { "<Plug>(easymotion-sn)", "Enter n characters to match and move." },
  },
  -- j, k, w, f motions
  j = { "<Plug>(easymotion-j)", "Easymotion UP" },
  k = { "<Plug>(easymotion-k)", "Easymotion DOWN" },
  w = { "<Plug>(easymotion-w)", "Easymotion next WORDS" },
  f = { "<Plug>(easymotion-f)", "Easymotion find SINGLE CHAR" },
}, {prefix = "<leader>"})

