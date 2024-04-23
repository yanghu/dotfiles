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
-- vim.cmd([[colorscheme kanagawa]])
require('catppuccin').setup({
  default_integrations = true,
  integrations = {
    aerial = true,
    hop = true,
    which_key = true,
  }
})
vim.cmd([[colorscheme catppuccin]])

require('lualine').setup({
  options = {
    theme = "catppuccin",
  },
  winbar = {
    lualine_c = {
      {
        "navic",
        color_correction = nil,
        navic_opts = nil
      }
    }
  }
})
require("bufferline").setup{
  highlights = require("catppuccin.groups.integrations.bufferline").get(),
  options = {
    numbers = "bufer_id",
    diagnostics = "nvim_lsp",
  },
}
