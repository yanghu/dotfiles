return {
  { "lukas-reineke/indent-blankline.nvim",-- {{{2
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
    event="VeryLazy"},-- }}}
  { 'echasnovski/mini.indentscope', version = '*' ,  config=true,
    ft = {'lua', 'python', 'c', 'go', 'java'},
  }
}

-- vim: foldmethod=marker foldlevel=1
