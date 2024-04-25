return {
  {'numToStr/Comment.nvim', opts = {}, lazy = false },
  {-- hop.nvim {{{2
    'smoka7/hop.nvim',
    version = "*",
    opts = {
      keys = 'etovxqpdygfblzhckisuran',
      uppercase_labels = true,
    },
    keys = {
      { "<leader>j", function () require('hop').hint_lines({direction = require('hop.hint').HintDirection.AFTER_CURSOR}) end, desc= "Hop down lines" },
      { "<leader>k", function () require('hop').hint_lines({direction = require('hop.hint').HintDirection.BEFORE_CURSOR}) end, desc= "Hop up lines" },
      { "<leader>ee", function () require('hop').hint_camel_case({current_line_only = true}) end, desc= "Hop Camel Case" },
      { "<leader>w", function () require('hop').hint_words({direction = require('hop.hint').HintDirection.AFTER_CURSOR}) end, desc= "Hop Words" },
      { "<leader>W", function () require('hop').hint_words({direction = require('hop.hint').HintDirection.BEFORE_CURSOR}) end, desc= "Hop Words" },
      { "s", function () require('hop').hint_char2({}) end, desc= "Hop 2char" },
      -- { "f", function () require('hop').hint_char1({direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only=true}) end, desc= "Hop f" },
      -- { "F", function () require('hop').hint_char1({direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only=true}) end, desc= "Hop F" },
      -- { "t", function () require('hop').hint_char1({direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only=true, hint_offset = -1}) end, desc= "Hop t" },
      -- { "T", function () require('hop').hint_char1({direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only=true, hint_offset = -1}) end, desc= "Hop T" },
    },
  },-- }}}

  { -- Autocompletion (nvim-cmp, luasnip, etc.) {{{2
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',-- {{{
        config = function ()
          require("luasnip.loaders.from_lua").load({paths = { "~/.config/nvim/lua/snippets/" }})
        end,
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
          end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
          { 'benfowler/telescope-luasnip.nvim', },
        },-- }}}
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-j>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<C-c>'] = cmp.mapping.close(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
            end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
            end, { 'i', 's' }),

          -- For choice node. inspired from
          -- https://www.reddit.com/r/neovim/comments/tbtiy9/comment/i0bje36/
          ['<C-e>'] = cmp.mapping(function()
            if luasnip.choice_active() then
              luasnip.change_choice(1)
            end
            end, { 'i', 's' }),
          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },-- }}}
  --
  {-- aerial.nvim {{{2
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    config = function ()
      local aerial = require 'aerial'
      aerial.setup {
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set("n", "<leader>{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "<leader>}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
      }
    end,
    keys = {
      { "<leader>a",  "<cmd>AerialToggle!<CR>", desc="Toggle Aerial"},
      { "<leader>A",  "<cmd>AerialToggle<CR>", desc="Toggle Aerial and stay in Aerial window"}
    }
  },-- }}}
  {-- flash.nvim {{{
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      modes = {
        search = {enabled = false},
      },
      label = {
        rainbow = {
          enabled = true,
        }
      },
    },
    -- stylua: ignore
    keys = {
      -- { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
      -- jump to scope
      { "<leader>n",   mode = { "n" }, function() require("flash").treesitter({jump={pos="start"}, label={after=false}}) end,  desc = "Flash Treesitter" },
    },
  },-- }}}
  {-- nvim-surround {{{
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },-- }}}
  { 'tpope/vim-unimpaired' ,
    lazy = false,
  },
  {
    'tpope/vim-repeat',
    keys = {
      { '.' },
    }},
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
    -- See https://github.com/windwp/nvim-autopairs?tab=readme-ov-file#override-default-values
  },

  -- Formatting
  {
    'stevearc/conform.nvim',
    opts = {},
  },
}


-- vim: foldmethod=marker foldlevel=1
