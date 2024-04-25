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

-- vim.cmd([[colorscheme gruvbox]])
-- vim.cmd([[colorscheme kanagawa]])
require('catppuccin').setup({
  default_integrations = true,
  integrations = {
    aerial = true,
    hop = true,
    which_key = true,
    navic = {
      enabled = true,
      custom_bg = "NONE"
    }
  }
})
vim.cmd([[colorscheme catppuccin]])

-- Lualine
require('lualine').setup({
  options = {
    theme = "catppuccin",
  },
  sections = {
    lualine_a = {
      -- Paste indicator
      { "[[]]", cond = function () return vim.opt.paste:get() end, },
      "mode",
    },
    lualine_c = {
      "filename",
      {
        "navic",
        color_correction = nil,
        navic_opts = nil
      },
    }
  },
  extensions = {'aerial', 'quickfix', 'trouble'},
  winbar = {}
})
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
