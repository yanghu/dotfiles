
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

require("lazy").setup({ 
  defaults = {
    lazy = true,
    version = "*"
  },
  spec = {
    import = 'plugins'
  },
  git = {
    timeout = 24
  },
  ui = {
    border = require('config.ui').borders,
    icons = require('config.ui').lazy,
  },
  diff = {
    cmd = 'git'
  },
  checker = {
    enabled = true,
    frequency = 3600*24*7,  -- check for updates every week.
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'netrwPlugin',
        'tohtml',
        'tutor'
      }
    }
  }
})
require('lazy.view.config').keys.profile_filter = '<C-p>'
