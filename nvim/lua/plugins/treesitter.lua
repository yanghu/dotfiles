return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		event = "BufReadPre",
		dependencies = {
			-- nvim-treesitter-refactor was deprecated (incompatible with nvim-treesitter main).
			-- nvim-treesitter-locals is the maintained replacement library.
			"nvim-treesitter/nvim-treesitter-locals",
			{
				"windwp/nvim-ts-autotag",
				config = function()
					require("nvim-ts-autotag").setup()
				end,
			},
			-- "andymass/vim-matchup",
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
				enabled = false,
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
				branch = "main",
				lazy = true,
				config = function()
					require("nvim-treesitter-textobjects").setup({
						select = { -- {{{
							enable = true,

							-- Automatically jump forward to textobj, similar to targets.vim
							lookahead = true,

							keymaps = {
								-- You can use the capture groups defined in textobjects.scm
								["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
								["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
								["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
								["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

								["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
								["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

								["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
								["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

								["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
								["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

								["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
								["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

								["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
								["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

								["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
								["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
							},
						}, -- }}}
						move = { -- {{{
							enable = true,
							set_jumps = true,
							goto_next_start = {
								["]f"] = { query = "@call.outer", desc = "Next function call start" },
								["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
								["]c"] = { query = "@class.outer", desc = "Next class start" },
								["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
								["]l"] = { query = "@loop.outer", desc = "Next loop start" },
								["]a"] = { query = "@parameter.inner", desc = "Next argument start" },

								["]="] = { query = "@assignment.inner", desc = "Next assignment start" },
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
					})

					local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

					-- vim way: ; goes to the direction you were moving.
					vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
					vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

					-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
					vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
					vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
					vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
					vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
				end,
			}, -- }}}
		},
		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})
			
			require("nvim-treesitter").install({
				"c", "lua", "vim", "markdown", "markdown_inline", "vimdoc",
				"query", "go", "python", "toml", "yaml", "json"
			})

			-- Highlight is built-in for Neovim 0.10+
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},
}

-- vim: foldmethod=marker foldlevel=1