return {
  {'numToStr/Comment.nvim', opts = {}, lazy = false },
  -- {{{2 vim-easymotion
  {'easymotion/vim-easymotion', 
    keys = {
      { "s",  "<Plug>(easymotion-overwin-f2)" },
      { "<leader>ee", "<Plug>(easymotion-lineanywhere)", desc="Line anywhere" },
      { "<leader>es", "<Plug>(easymotion-sn)", desc="Enter n characters to match and move." },
      { "<leader>j",  "<Plug>(easymotion-j)", desc="Easymotion UP" },
      { "<leader>k",  "<Plug>(easymotion-k)", desc="Easymotion DOWN" },
      { "<leader>w",  "<Plug>(easymotion-w)", desc="Easymotion next WORDS" },
      { "<leader>f",  "<Plug>(easymotion-f)", desc="Easymotion find SINGLE CHAR" },

    },
    config = function ()
      vim.g.EasyMotion_use_upper = 1
      vim.g.EasyMotion_keys = 'ASDGHKLQWERTYUIOPZXCVBNMFJ;'
    end,
  },
  -- }}}2


}
