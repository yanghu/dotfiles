local icons = require("config.ui").icons
local env = require("utils.env")
return {
	-- Keymap helper
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
			preset = "helix",
			-- layout = {
			-- 	height = { max = 7 },
			-- },
			-- deprecated in v3. Need to find out how to do this in the new format.
			-- triggers_blacklist = {
			-- 	n = { "gf", "gT", "gt", "gc" },
			-- },

			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		config = function(_, opts)
			require("which-key").setup(opts)
			-- from https://github.com/folke/which-key.nvim/issues/476#issuecomment-1986782731
			-- Which-key doesn't show menu for localleader key when it's set to ","
			-- This is the workaround that fixes the issue
			-- vim.api.nvim_create_autocmd("FileType", {
			-- 	desc = "Set up localleader Which-Key descriptions",
			-- 	group = vim.api.nvim_create_augroup("whichkey_localleader_descriptions", { clear = true }),
			-- 	pattern = "*",
			-- 	callback = function()
			-- 		vim.keymap.set("n", "<localleader>", function()
			-- 			require("which-key").show(",")
			-- 		end, { buffer = true })
			-- 	end,
			-- })
		end,
	},
	-- }}}2

	-- Search
	--  fzf {{{2
	{ "junegunn/fzf", tag = "0.50.0", pin = true, build = "./install --all --xdg" },
	{ -- fzf-lua
		"ibhagwan/fzf-lua",
		branch = "main",
		event = "VimEnter",
		-- stylua: ignore
		keys = {
			-- { "<Leader>F", function() require("fzf-lua").builtin() end, desc = "builtin"},
			{ "<Leader>ss", function() require("fzf-lua").builtin() end, desc = "builtin"},
			-- Files
			{ '<Leader>f', function() require('fzf-lua').files() end, desc = 'files' },
			{ '<Leader>o', function() require('fzf-lua').oldfiles() end, desc = 'oldfiles' },
			-- Files files in same folder of current buffer
			{ '<Leader>s.', function() require('fzf-lua').files({ cwd = vim.fn.expand("%:p:h") }) end, desc = 'Files in buffer dir' },
			{ '<Leader>sf', ":FzfLua files cwd=" .. vim.fn.expand("%:p:h"), desc = 'Files any dir' },

			{ '<Leader>b', function() require('fzf-lua').buffers() end, desc = 'which_key_ignore' },
			-- Grep keymaps
			--   live grep: Use "keyword -- glob" to filter files. (support negative patterns)
			{ "<Leader>/", function() require("fzf-lua").live_grep_glob() end,
				desc = "live grep all files", },
			-- Grep word
			{ "<Leader>sw", function() require("fzf-lua").grep_cword() end,
				desc = "Grep Current word", },
			{ "<Leader>sW", function() require("fzf-lua").grep_cWORD() end,
				desc = "Grep Current WORD", },
			{ "<Leader>sw", function() require("fzf-lua").grep_visual() end,
				desc = "Grep vislau selection", mode="v"},

			-- Buffer lines
			-- { "<Leader>sb", function() require("fzf-lua").lgrep_curbuf() end, desc = "current buffer lines", },
			{ "<Leader>sb", function() require("fzf-lua").blines() end, desc = "current buffer lines", },
			{ "<Leader>so", function() require("fzf-lua").lines() end, desc = "Lines of open buffers", },

			-- LSP related (diagnostics)
			{ "<Leader>sd", function() require("fzf-lua").diagnostics_document() end, desc = "Document Diagnostics", },
			{ "<Leader>sq", function() require("fzf-lua").quickfix() end, desc = "Quickfix", },
			{ "<Leader>sl", function() require("fzf-lua").loclist() end, desc = "Loclist", },
			{ "<Leader>dd", function() require("fzf-lua").lsp_document_symbols() end, desc = "Document Symbols", },

			-- Help content
			{ '<Leader>sh', function() require('fzf-lua').help_tags() end, desc = "Help" },
			-- { '<Leader>sm', function() require('fzf-lua').man_pages() end, desc = "[S]earch [M]an pages" },
			{ '<Leader>sm', function() require('fzf-lua').git_status() end, desc = "Modified git files" },
			{ '<Leader>sk', function() require('fzf-lua').keymaps() end, desc = "Keymaps" },

			{ '<Leader>sc', function() require('fzf-lua').files({ cwd = vim.fn.stdpath("config")}) end, desc = 'Nim Config files' },

			{ "<Leader>sr", function() require("fzf-lua").resume() end, desc = "Resume", },

			-- Git
			--   Search file in git. If CWD is not in a git repo, search in CWD.
			{ "<Leader>gf", function() require("utils.fzf").files_git_or_cwd() end,
				desc = "git files", },
			{ "<Leader>g/", function() require("fzf-lua").live_grep_glob({cwd=require("fzf-lua.path").git_root()}) end, desc = "git files", },
			-- { "<Leader>gg", function() require("fzf-lua").live_grep_glob({cwd=require("fzf-lua.path").git_root()}) end, desc = "git files", },
			-- { "<Leader>gs", function() require("fzf-lua").git_status() end,
			-- 	desc = "git status", },

			{ "<Leader>gb", function() require("fzf-lua").git_bcommits() end,
				desc = "git buffer commits", },
			{ "<Leader>gc", function() require("fzf-lua").git_commits() end,
				desc = "git commits", },
			-- { "<Leader>gg", function() require("fzf-lua").grep() end, desc = "grep", },
			-- { '<Leader>fc', function() require('fzf-lua').command_history() end, desc = 'command history' },
			-- { '<Leader>fh', function() require('fzf-lua').highlights() end, desc = 'highlights' },
			-- { '<Leader>fm', function() require('fzf-lua').marks() end, desc = 'marks' },
			-- { '<Leader>fq', function() require('fzf-lua').quickfix() end, desc = 'quickfix' },
			-- { '<Leader>fr', function() require('fzf-lua').registers() end, desc = 'registers' },
			-- { '<Leader>fs', function() require('fzf-lua').spell_suggest() end, desc = 'spell suggest' },
			-- { '<Leader>ft', function() require('fzf-lua').filetypes() end, desc = 'filetypes' },
			-- { '<Leader>fw', function() require('fzf-lua').grep_cword() end, desc = 'grep string' }
		},
		config = function()
			local fzf_lua = require("fzf-lua")
			local actions = require("fzf-lua.actions")

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
				previewers = {
					builtin = {
						title_fnamemodify = function(t, width)
							local min_left_padding = 4
							local min_right_padding = 4
							local max_text_width = width - min_left_padding - min_right_padding
							if #t > max_text_width then
								return "..." .. t:sub(#t - max_text_width + 3 + 1, #t)
							end
							return t
						end,
					},
				},
				keymap = {
					builtin = {
						["ctrl-u"] = "half-page-up",
						["ctrl-d"] = "half-page-down",
						["<C-f>"] = "preview-page-down",
						["<C-b>"] = "preview-page-up",
						["<C-a>"] = "toggle-all",
						-- ["<C-q>"] = "",
					},
					fzf = {
						["ctrl-u"] = "half-page-up",
						["ctrl-d"] = "half-page-down",
						["ctrl-f"] = "preview-page-down",
						["ctrl-b"] = "preview-page-up",
						["ctrl-a"] = "toggle-all",
						-- ["ctrl-q"] = "select-all+accept",
					},
				},
				winopts = bottom_row,
				file_ignore_patterns = {},
				blines = {
					fzf_opts = {
						["--no-multi"] = false,
						["--multi"] = true,
					},
				},
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
					path_shorten = 4,
					actions = {
						["ctrl-e"] = actions.file_edit,
					},
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
					rg_opts = "--column --trim --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
					path_shorten = 4,
					winopts = bottom_row,
					-- winopts = {
					-- 	fullscreen = true,
					-- },
					formatter = "path.filename_first",
					actions = {
						["ctrl-q"] = actions.file_sel_to_qf,
					},
				},
				grep_curbuf = {
					fzf_opts = {
						["--no-multi"] = false,
						["--multi"] = true,
					},
				},
				highlights = {
					winopts = right_column,
				},
				keymaps = {
					actions = {
						["default"] = require("fzf-lua.actions").keymap_edit,
					},
				},
				lgrep_curbuf = {
					fzf_opts = {
						["--no-multi"] = false,
						["--multi"] = true,
					},
				},
				lines = {
					fzf_opts = {
						["--no-multi"] = false,
						["--multi"] = true,
					},
					actions = {
						["ctrl-q"] = actions.file_sel_to_qf,
					},
				},
				oldfiles = {
					-- To avoid high latency on remote files in history.
					-- See https://github.com/ibhagwan/fzf-lua/issues/1336
					stat_file = false,
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
	{ -- Telescope(files, lsp, etc) {{{2
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- nvim-telescope/telescope-fzf-native.nvim {{{3
				"nvim-telescope/telescope-fzf-native.nvim",
				-- If encountering errors, see telescope-fzf-native README for installation instructions
				-- This plugin adds support for full FZF syntax in fuzzy search:
				--   * 'wild:  exact-match
				--   * ^music: prefix exact match
				--   * .mp3$: suffix eact match
				--   * !fire: inverse exact match

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			}, -- }}}
			{ "nvim-telescope/telescope-ui-select.nvim" },

			{ -- nvim-telescope/telescope-live-grep-args.nvim {{{3
				"nvim-telescope/telescope-live-grep-args.nvim",
				-- This will not install any breaking changes.
				-- For major updates, this must be adjusted manually.
				version = "^1.0.0",
			}, -- }}}
			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		opts = function(_, opts)
			local actions = require("telescope.actions")
			local lga_actions = require("telescope-live-grep-args.actions")
			-- code
			return vim.tbl_deep_extend("force", opts, {
				defaults = {
					previewer = true,
					layout_strategy = "bottom_pane",
					sorting_strategy = "ascending",
					path_display = function(path_opts, path)
						path = path:gsub("^" .. vim.env.HOME, "~")
						if type(path_display) == "function" then
							path = path_display(path_opts, path)
						end
						return path
					end,

					mappings = {
						i = {
							["<c-g>"] = "to_fuzzy_refine",
							["<c-j>"] = "move_selection_next",
							["<c-k>"] = "move_selection_previous",
							["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						},
						n = {
							["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
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
					live_grep_args = {
						auto_quoting = true, -- enable/disable auto-quoting
						-- define mappings, e.g.
						mappings = { -- extend mappings
							i = {
								["<C-k>"] = lga_actions.quote_prompt(),
								["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
							},
						},
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
				},
			})
		end,
		keys = {
			{ "<leader>sp", "<cmd>Telescope persisted<CR>", mode = "n", desc = "Search Projects" },
			{
				"<leader>dd",
				function()
					builtin.diagnostics({ bufnr = 0 })
				end,
				mode = "n",
				desc = "Document Diagnostics",
			},
			{
				"<leader>dw",
				function()
					builtin.diagnostics()
				end,
				mode = "n",
				desc = "Workspace Diagnostics",
			},
		},
	}, -- }}}
	-- Browsing: diagnostics, lists, locations
	{ -- folke/trouble.nvim {{{2
		"folke/trouble.nvim",
		branch = "main", -- IMPORTANT! v3
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				-- "<cmd>Trouble preview_float toggle<cr>",
				-- "<cmd>Trouble preview_split toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				-- "<cmd>Trouble preview_split toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>xs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>xp",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xl",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xq",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
		opts = {
			preview = {
				type = "main",
				wo = {
					foldenable = false,
				},
			},
			modes = {
				preview_float = {
					mode = "diagnostics",
					preview = {
						type = "float",
						relative = "editor",
						border = "rounded",
						title = "Preview",
						title_pos = "center",
						position = { 0, -2 },
						size = { width = 0.5, height = 0.4 },
						zindex = 200,
					},
				},
				preview_split = {
					mode = "diagnostics",
					preview = {
						type = "split",
						relative = "win",
						position = "right",
						size = 0.5,
					},
				},
			},
		}, -- for default options, refer to the configuration section for custom setup.
	}, -- }}}
	{ -- cbochs/grapple.nvim {{{2
		"cbochs/grapple.nvim",
		opts = {
			scope = "git", -- also try out "git_branch"
			quick_select = "asdfghweop",
		},
		event = { "BufReadPost", "BufNewFile" },
		cmd = "Grapple",
		keys = {
			{ "<leader>ma", ":Grapple tag name=", desc = "Grapple tag" },
			{ "<leader>md", "<cmd>Grapple untag<CR>", desc = "Grapple untag" },
			{ "<leader>mk", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
			{ "<leader>M", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
			{ "<leader>n", "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple cycle next tag" },
			-- { "<leader>p", "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple cycle previous tag" },
		},
	}, -- }}}
	{ -- ethanholz/nvim-lastplace {{{2
		"ethanholz/nvim-lastplace",
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

	{ -- alexghergh/nvim-tmux-navigation {{{2
		"alexghergh/nvim-tmux-navigation",
		config = function()
			local nvim_tmux_nav = require("nvim-tmux-navigation")

			nvim_tmux_nav.setup({
				disable_when_zoomed = true, -- defaults to false
			})

			vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
			vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
			vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
			vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
			vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
			-- vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
		end,
		event = "VeryLazy",
	}, -- }}}
	-- Sessions
	{ -- olimorris/persisted.nvim {{{
		"olimorris/persisted.nvim",
		lazy = false, -- make sure the plugin is always loaded at startup
		config = function()
			require("persisted").setup({
				should_autosave = function()
					-- do not autosave if the alpha dashboard is the current filetype
					if vim.bo.filetype == "alpha" then
						return false
					end
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						-- Don't save while there's any 'nofile' buffer open.
						local buftype = vim.api.nvim_get_option_value("buftype", { buf = buf })
						local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
						local bufname = vim.api.nvim_buf_get_name(buf)
						if buftype == "" and bufname == "" or filetype == "oil" then
							return false
						end
					end
					return true
				end,
				telescope = {
					mappings = {
						copy_session = "<c-y>",
					},
				},
			})
		end,
	}, -- }}}

	-- File browser
	{
		"nvim-tree/nvim-tree.lua",
		enabled = false,
		config = function()
			require("nvim-tree").setup({})
		end,
	},
	{
		"stevearc/oil.nvim",
		lazy = false,
		opts = {
			keymaps = {
				["gq"] = "actions.close",
			},
		},
		config = function()
			require("oil").setup({
				keymaps = {
					["gq"] = "actions.close",
				},
			})
		end,
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	-- Dashboard
	{ -- goolord/alpha-nvim {{{2
		"goolord/alpha-nvim",
		config = function()
			-- require("alpha").setup(require("alpha.themes.theta").config)
			require("config.ui").alpha_config()
		end,
		lazy = false,
		-- enabled = false,
	}, -- }}}

	-- Misc
	{ -- iamcco/markdown-preview.nvim {{{2
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		keys = {
			{
				"<leader>cp",
				ft = "markdown",
				"<cmd>MarkdownPreviewToggle<cr>",
				desc = "Markdown Preview",
			},
		},
	}, -- }}}

	{ "stevearc/profile.nvim" },
	{
		"mistricky/codesnap.nvim",
		build = "make",
		lazy = false,
		opts = {
			code_font_family = "JetBrains Mono",
			-- bg_x_padding = 122,
			-- bg_y_padding = 82,
			bg_x_padding = 80,
			bg_y_padding = 40,
			-- bg_padding = 0,
			watermark = "",
		},
	},
}

-- vim: foldmethod=marker foldlevel=1
