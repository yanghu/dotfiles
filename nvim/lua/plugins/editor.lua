local icons = require("config.ui").icons
return {
	-- {{{2 fzf
	{ "junegunn/fzf", tag = "0.50.0", pin = true, build = "./install --all --xdg" },
	{
		"ibhagwan/fzf-lua",
		keys = {
			{
				"<Leader>F",
				function()
					require("fzf-lua").builtin()
				end,
				desc = "Fzf: builtin",
			},
			-- { '<Leader>b', function() require('fzf-lua').buffers() end, desc = 'Fzf: buffers' },
			-- { '<Leader>c', function() require('fzf-lua').colorschemes() end, desc = 'Fzf: colorschemes' },
			-- { '<Leader>f', function() require('fzf-lua').files() end, desc = 'Fzf: files' },
			-- { '<Leader>o', function() require('fzf-lua').oldfiles() end, desc = 'Fzf: oldfiles' },
			-- { '<Leader>h', function() require('fzf-lua').help_tags() end, desc = 'Fzf: help' },
			-- { '<Leader>k', function() require('fzf-lua').man_pages() end, desc = 'Fzf: man' },
			-- { '<Leader>t', function() require('fzf-lua').tabs() end, desc = 'Fzf: tabs' },
			{
				"<Leader>lb",
				function()
					require("fzf-lua").lgrep_curbuf()
				end,
				desc = "Fzf: grep current buffer lines",
			},
			{
				"<Leader>/",
				function()
					require("fzf-lua").live_grep_glob()
				end,
				desc = "Fzf: live grep all files",
			},
			{
				"<Leader>gf",
				function()
					require("fzf-lua").git_files()
				end,
				desc = "Fzf: git files",
			},
			{
				"<Leader>gb",
				function()
					require("fzf-lua").git_bcommits()
				end,
				desc = "Fzf: git buffer commits",
			},
			{
				"<Leader>gc",
				function()
					require("fzf-lua").git_commits()
				end,
				desc = "Fzf: git commits",
			},
			{
				"<Leader>gs",
				function()
					require("fzf-lua").git_status()
				end,
				desc = "Fzf: git status",
			},
			{
				"<Leader>gg",
				function()
					require("fzf-lua").grep()
				end,
				desc = "Fzf: grep",
			},
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
			local fzf_lua = require("fzf-lua")

			local bottom_row = {
				height = 0.4,
				width = 1,
				row = 1,
				col = 0,
				preview = {
					layout = "horizontal",
					horizontal = "right:55%",
				},
			}
			local right_popup = {
				height = 0.97,
				width = 0.2,
				row = 0.3,
				col = 1,
			}
			local right_column = {
				height = 1,
				width = 0.45,
				row = 0,
				col = 1,
				preview = {
					layout = "vertical",
					vertical = "down:65%",
				},
			}

			fzf_lua.setup({
				global_resume = true,
				winopts = bottom_row,
				file_ignore_patterns = {},
				builtin = {
					winopts = right_column,
				},
				colorschemes = {
					winopts = right_popup,
				},
				diagnostics = {
					winopts = right_column,
				},
				files = {
					prompt = "Files❯ ",
				},
				filetypes = {
					winopts = {
						relative = "cursor",
						width = 0.14,
						row = 1.01,
					},
				},
				git = {
					branches = {
						winopts = right_column,
					},
					bcommits = {
						winopts = right_column,
					},
					commits = {
						winopts = right_column,
					},
					status = {
						winopts = right_column,
					},
				},
				grep = {
					-- cmd = 'ugrep -RIjnkzs --hidden --ignore-files --exclude-dir=".git"',
					winopts = right_column,
				},
				highlights = {
					winopts = right_column,
				},
				spell_suggest = {
					winopts = {
						relative = "cursor",
						width = 0.2,
						row = 1.01,
					},
				},
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
		end,
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
			plugins = {
				presets = {
					motions = false,
					operators = false,
				},
			},
			layout = {
				height = { max = 5 },
			},
			triggers_blacklist = {
				n = { "gf", "gT", "gt", "gc" },
			},

			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	-- }}}2

	{ -- Telescope(files, lsp, etc){{{2
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			-- The easiest way to use Telescope, is to start by doing something like:
			--  :Telescope help_tags
			--
			-- Two important keymaps to use while in Telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the current
			-- Telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require("telescope").setup({
				defaults = {
					previewer = true,
					layout_strategy = "bottom_pane",
					sorting_strategy = "ascending",
					path_display = {
						shorten = 2,
					},
					mappings = {
						i = {
							["<c-g>"] = "to_fuzzy_refine",
							["<c-j>"] = "move_selection_next",
							["<c-k>"] = "move_selection_previous",
						},
					},
				},
				pickers = {
					find_files = {
						mappings = {
							n = {
								-- 'cd' to change dir when finding files
								["cd"] = function(prompt_bufnr)
									local selection = require("telescope.actions.state").get_selected_entry()
									local dir = vim.fn.fnamemodify(selection.path, ":p:h")
									require("telescope.actions").close(prompt_bufnr)
									-- Depending on what you want put `cd`, `lcd`, `tcd`
									vim.cmd(string.format("silent lcd %s", dir))
								end,
							},
						},
					},
				},
				-- pickers = {},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			local utils = require("telescope.utils")
			-- Single-key maps
			vim.keymap.set("n", "<leader>o", builtin.oldfiles, { desc = "[O]ld files" })
			vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Find open [B]uffers" })
			vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Search cwd [F]iles" })
			vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "[H]elp" })

			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", function()
				builtin.find_files({ cwd = utils.buffer_dir() })
			end, { desc = "[S]earch [F]iles in buffer dir" })
			-- Find sibling files (in current folder of the buffer)
			vim.keymap.set("n", "<leader>s.", function()
				builtin.find_files({ cwd = vim.fn.expand("%:p:h") })
			end)
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })

			-- diagnostics
			vim.keymap.set("n", "<leader>dd", function()
				builtin.diagnostics({ bufnr = 0 })
			end, { desc = "[D]ocument [D]iagnostics" })
			vim.keymap.set("n", "<leader>dw", builtin.diagnostics, { desc = "[D]iagnostics [W]orkspace" })
			-- -- Slightly advanced example of overriding default behavior and theme
			-- vim.keymap.set('n', '<leader>/', function()
			--   -- You can pass additional configuration to Telescope to change the theme, layout, etc.
			--   builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
			--     winblend = 10,
			--     previewer = false,
			--   })
			-- end, { desc = '[/] Fuzzily search in current buffer' })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	}, -- }}}
	{
		"folke/trouble.nvim", -- {{{2
		branch = "dev", -- IMPORTANT!
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
		opts = { use_diagnostic_signs = false }, -- for default options, refer to the configuration section for custom setup.
	}, -- }}}
	{ -- gitsigns.nvim {{{2
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	}, -- }}}

	{
		"ethanholz/nvim-lastplace", -- {{{2
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
				lastplace_open_folds = true,
			})
		end,
		lazy = false,
	}, -- }}}
	{ "tpope/vim-sleuth", lazy = false },
	{
		"nvim-lualine/lualine.nvim", -- {{{2
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		opts = {
			options = {
				theme = "catppuccin",
			},
			sections = {
				lualine_a = {
					-- Paste indicator
					{
						"[[]]",
						cond = function()
							return vim.opt.paste:get()
						end,
					},
					"mode",
				},
				lualine_b = {
					"branch",
					{
						"diff",
						symbols = {
							added = icons.git.added,
							modified = icons.git.modified,
							removed = icons.git.removed,
						},
					},
					"diagnostics",
				},
				lualine_c = {
					"filename",
					{
						"navic",
						color_correction = nil,
						navic_opts = nil,
					},
				},
			},
			extensions = { "aerial", "quickfix", "trouble" },
			winbar = {},
		},
	}, -- }}}
	{
		"akinsho/bufferline.nvim", -- {{{2
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				highlights = require("catppuccin.groups.integrations.bufferline").get(),
				options = {
					numbers = "bufer_id",
					diagnostics = "nvim_lsp",
				},
			})
		end,
	}, -- }}}
	-- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
	},
}

-- vim: foldmethod=marker foldlevel=1
