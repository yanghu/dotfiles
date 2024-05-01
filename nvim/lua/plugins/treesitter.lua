return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPre",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-refactor",
			"windwp/nvim-ts-autotag",
			"andymass/vim-matchup",
			{ -- nvim-treesitter/nvim-treesitter-context {{{2
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
			{ -- HiPhish/rainbow-delimiters.nvim {{{2
				"HiPhish/rainbow-delimiters.nvim",
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
