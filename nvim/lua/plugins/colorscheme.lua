return {
	-- {{{2 gruvbox.nvim
	{
		"ellisonleao/gruvbox.nvim",
		branch = "main",
		priority = 1000,
		config = true,
		enabled = true,
		lazy = false,
		opts = {},
	},
	-- }}}2
	{ "rebelot/kanagawa.nvim", enabled = false },
	{ -- catppuccin {{{2
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				default_integrations = true,
				integrations = {
					aerial = true,
					hop = true,
					which_key = true,
					navic = {
						enabled = true,
						custom_bg = "NONE",
					},
				},
			})
		end,
		lazy = false,
	}, -- }}}
}

-- vim: foldmethod=marker foldlevel=1
