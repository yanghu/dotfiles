return {
  -- {{{2 fzf
  { "junegunn/fzf", 
    build = './install --all --xdg'},
  {
    'ibhagwan/fzf-lua',
    keys = {
      { '<Leader>F', function() require('fzf-lua').builtin() end, desc = 'Fzf: builtin' },
      { '<Leader>b', function() require('fzf-lua').buffers() end, desc = 'Fzf: buffers' },
      -- { '<Leader>c', function() require('fzf-lua').colorschemes() end, desc = 'Fzf: colorschemes' },
      { '<Leader>f', function() require('fzf-lua').files() end, desc = 'Fzf: files' },
      { '<Leader>o', function() require('fzf-lua').oldfiles() end, desc = 'Fzf: oldfiles' },
      { '<Leader>h', function() require('fzf-lua').help_tags() end, desc = 'Fzf: help' },
      -- { '<Leader>k', function() require('fzf-lua').man_pages() end, desc = 'Fzf: man' },
      -- { '<Leader>t', function() require('fzf-lua').tabs() end, desc = 'Fzf: tabs' },
      { '<Leader>lb', function() require('fzf-lua').lgrep_curbuf() end, desc = 'Fzf: grep current buffer lines' },
      { '<Leader>/', function() require('fzf-lua').live_grep_native() end, desc = 'Fzf: grep all files' },
      { '<Leader>gf', function() require('fzf-lua').git_files() end, desc = 'Fzf: git files' },
      { '<Leader>gb', function() require('fzf-lua').git_bcommits() end, desc = 'Fzf: git buffer commits' },
      { '<Leader>gc', function() require('fzf-lua').git_commits() end, desc = 'Fzf: git commits' },
      { '<Leader>gs', function() require('fzf-lua').git_status() end, desc = 'Fzf: git status' },
      { '<Leader>gg', function() require('fzf-lua').grep() end, desc = 'Fzf: grep' },
      -- { '<Leader>fc', function() require('fzf-lua').command_history() end, desc = 'Fzf: command history' },
      -- { '<Leader>fh', function() require('fzf-lua').highlights() end, desc = 'Fzf: highlights' },
      -- { '<Leader>fk', function() require('fzf-lua').keymaps() end, desc = 'Fzf: keymaps' },
      -- { '<Leader>fm', function() require('fzf-lua').marks() end, desc = 'Fzf: marks' },
      -- { '<Leader>fq', function() require('fzf-lua').quickfix() end, desc = 'Fzf: quickfix' },
      -- { '<Leader>fr', function() require('fzf-lua').registers() end, desc = 'Fzf: registers' },
      -- { '<Leader>fs', function() require('fzf-lua').spell_suggest() end, desc = 'Fzf: spell suggest' },
      -- { '<Leader>ft', function() require('fzf-lua').filetypes() end, desc = 'Fzf: filetypes' },
      -- { '<Leader>fw', function() require('fzf-lua').grep_cword() end, desc = 'Fzf: grep string' }
    },
    config = function()
      local fzf_lua = require('fzf-lua')

      local bottom_row = {
        height = 0.4,
        width = 1,
        row = 1,
        col = 0,
        preview = {
          layout = 'horizontal',
          horizontal = 'right:55%',
        }
      }
      local right_popup = {
        height = 0.97,
        width = 0.2,
        row = 0.3,
        col = 1
      }
      local right_column = {
        height = 1,
        width = 0.45,
        row = 0,
        col = 1,
        preview = {
          layout = 'vertical',
          vertical = 'down:65%'
        }
      }

      fzf_lua.setup({
        global_resume = true,
        winopts = bottom_row,
        builtin = {
          winopts = right_column
        },
        colorschemes = {
          winopts = right_popup
        },
        diagnostics = {
          winopts = right_column
        },
        files = {
          prompt = 'Files❯ ',
        },
        filetypes = {
          winopts = {
            relative = 'cursor',
            width = 0.14,
            row = 1.01
          }
        },
        git = {
          branches = {
            winopts = right_column
          },
          bcommits = {
            winopts = right_column
          },
          commits = {
            winopts = right_column
          },
          status = {
            winopts = right_column
          },
        },
        grep = {
          -- cmd = 'ugrep -RIjnkzs --hidden --ignore-files --exclude-dir=".git"',
          winopts = right_column
        },
        highlights = {
          winopts = right_column
        },
        spell_suggest = {
          winopts = {
            relative = 'cursor',
            width = 0.2,
            row = 1.01
          }
        }
      })

      fzf_lua.register_ui_select(function(_, items)
        local min_h, max_h = 0.15, 0.70
        local h = (#items + 4) / vim.o.lines
        if h < min_h then
          h = min_h
        elseif h > max_h then
          h = max_h
        end
        return { winopts = { height = h, width = 0.60, row = 0.40 } }
      end)

    end
  },
  -- }}}2
  -- {{{2 which-key.nvim
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
  }
  -- }}}2
}

-- vim: foldmethod=marker foldlevel=1
