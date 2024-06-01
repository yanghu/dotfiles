return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		build = ":TSUpdate",
		event = "BufReadPre",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-refactor",
			"windwp/nvim-ts-autotag",
			"andymass/vim-matchup",
			{ -- nvim-treesitter/nvim-treesitter-context {{{
				"nvim-treesitter/nvim-treesitter-context",
				config = function()
					require("treesitter-context").setup({
						multiline_threshold = 1, -- Maximum number of lines to show for a single context
					})

					-- Add a line between context and normal text.
					vim.cmd([[hi TreesitterContextBottom gui=underline guisp=Grey]])
					vim.cmd([[hi TreesitterContextLineNumberBottom gui=underline guisp=Grey]])
				end,
			}, -- }}}
			{ -- HiPhish/rainbow-delimiters.nvim {{{
				"HiPhish/rainbow-delimiters.nvim",
				branch = "master",
				event = "VeryLazy",
				config = function()
					vim.g.rainbow_delimiters = {
						strategy = {
							[""] = require("rainbow-delimiters").strategy["global"],
						},
						query = {
							[""] = "rainbow-delimiters",
							lua = "rainbow-blocks",
						},
					}
				end,
			}, -- }}}
			{ -- nvim-treesitter/nvim-treesitter-textobjects{{{
				"nvim-treesitter/nvim-treesitter-textobjects",
				lazy = true,
				config = function()
					require("nvim-treesitter.configs").setup({
						textobjects = {
							select = { -- {{{
								enable = true,

								-- Automatically jump forward to textobj, similar to targets.vim
								lookahead = true,

								-- Keymaps. objects defined are:
								--   * = : assignments (a, i, l, r)
								--   * a : arguments / parameter (a, i)
								--   * i: conditional/"if" (a, i)
								--   * l: loop (a,i)
								--   * f: function CALLs
								--   * m: method/function definitions
								--   * c: class
								keymaps = {
									-- You can use the capture groups defined in textobjects.scm
									["a="] = {
										query = "@assignment.outer",
										desc = "Select outer part of an assignment",
									},
									["i="] = {
										query = "@assignment.inner",
										desc = "Select inner part of an assignment",
									},
									["l="] = {
										query = "@assignment.lhs",
										desc = "Select left hand side of an assignment",
									},
									["r="] = {
										query = "@assignment.rhs",
										desc = "Select right hand side of an assignment",
									},

									["aa"] = {
										query = "@parameter.outer",
										desc = "Select outer part of a parameter/argument",
									},
									["ia"] = {
										query = "@parameter.inner",
										desc = "Select inner part of a parameter/argument",
									},

									["ai"] = {
										query = "@conditional.outer",
										desc = "Select outer part of a conditional",
									},
									["ii"] = {
										query = "@conditional.inner",
										desc = "Select inner part of a conditional",
									},

									["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
									["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

									["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
									["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

									["am"] = {
										query = "@function.outer",
										desc = "Select outer part of a method/function definition",
									},
									["im"] = {
										query = "@function.inner",
										desc = "Select inner part of a method/function definition",
									},

									["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
									["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
								},
							}, -- }}}
							move = { -- {{{
								enable = true,
								set_jumps = true,
								--Supported moves:
								--  * next start: ]x
								--  * next end: ]X
								--  * previous start: [x
								--  * previous end: [X
								goto_next_start = {
									["]f"] = { query = "@call.outer", desc = "Next function call start" },
									["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
									["]c"] = { query = "@class.outer", desc = "Next class start" },
									["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
									["]l"] = { query = "@loop.outer", desc = "Next loop start" },
									["]a"] = { query = "@parameter.inner", desc = "Next argument start" },

									["]="] = { query = "@assignment.inner", desc = "Next assignment start" },
									-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
									-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
									["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
									["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
								},
								goto_next_end = {
									["]F"] = { query = "@call.outer", desc = "Next function call end" },
									["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
									["]C"] = { query = "@class.outer", desc = "Next class end" },
									["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
									["]L"] = { query = "@loop.outer", desc = "Next loop end" },
									["]A"] = { query = "@parameter.inner", desc = "Next argument end" },
								},
								goto_previous_start = {
									["[f"] = { query = "@call.outer", desc = "Prev function call start" },
									["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
									["[c"] = { query = "@class.outer", desc = "Prev class start" },
									["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
									["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
									["[a"] = { query = "@parameter.inner", desc = "Prev argument start" },

									["[="] = { query = "@assignment.inner", desc = "Prev assignment start" },
								},
								goto_previous_end = {
									["[F"] = { query = "@call.outer", desc = "Prev function call end" },
									["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
									["[C"] = { query = "@class.outer", desc = "Prev class end" },
									["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
									["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
									["[A"] = { query = "@parameter.inner", desc = "Prev argument end" },
								},
							}, -- }}}
						},
					})

					local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

					-- vim way: ; goes to the direction you were moving.
					vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
					vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

					-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
					vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
					vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
					vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
					vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
				end,
			}, -- }}}
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				autotag = {
					enable = true,
				},
				highlight = {
					enable = true,
				},
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"markdown",
					"markdown_inline",
					"vimdoc",
					"query",
					"go",
					"python",
					"toml",
					"yaml",
					"json",
				},
				indent = {
					enable = true,
				},
				refactor = {
					highlight_current_scope = {
						enable = false,
					},
					highlight_definitions = {
						enable = true,
					},
					navigation = {
						enable = true,
					},
					smart_rename = {
						enable = true,
					},
				},
				matchup = {
					enable = true, -- mandatory, false will disable the whole extension
					disable = { "c", "ruby" }, -- optional, list of language that will be disabled
					disable_virtual_text = false,
					include_match_words = false,
					-- [options]
				},
			})
		end,
	},
}

-- vim: foldmethod=marker foldlevel=1
