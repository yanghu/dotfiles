return {
	-- {{{2 gruvbox.nvim
	{
		"ellisonleao/gruvbox.nvim",
		branch = "main",
		priority = 1000,
		config = true,
		enabled = false,
		lazy = false,
		opts = ...,
	},
	-- }}}2
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_enable_italic = true
			vim.g.gruvbox_material_enable_bold = true
			-- vim.cmd.colorscheme("gruvbox-material")
			-- vim.g.gruvbox_material_dim_inactive_windows = true
			-- vim.g.gruvbox_material_better_performance = true
		end,
	},
	{ "rebelot/kanagawa.nvim", enabled = false },
	{ -- catppuccin {{{2
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				-- default_integrations = true,
				-- integrations = {
				-- 	aerial = true,
				-- 	hop = true,
				-- 	which_key = true,
				-- 	navic = {
				-- 		enabled = true,
				-- 		custom_bg = "NONE",
				-- 	},
				-- },
			})
			vim.cmd.colorscheme("catppuccin")
		end,
		lazy = false,
	}, -- }}}
}

-- vim: foldmethod=marker foldlevel=1
