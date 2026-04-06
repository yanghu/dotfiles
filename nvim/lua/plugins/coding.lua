return {
	-- Still use comment.nvim over Neovim 0.10's built-in commenting:
	-- The built-in one can only toggle comments on lines. This plugin allows
	-- in-line commenting toggle. (comment a word, etc.)
	{ "numToStr/Comment.nvim", opts = {}, lazy = false },
	{ -- ggandor/leap.nvim {{{2
		"ggandor/leap.nvim",
		keys = {
			{ "s", "<Plug>(leap)", desc = "Leap", mode = { "n", "x" } },
			{ "z", "<Plug>(leap)", desc = "Leap", mode = { "o" } },
			{ "gs", "<Plug>(leap-from-window)", desc = "Leap from window" },
		},
		opts = {
			-- case_sensitive = false,
			equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" },
			max_phase_one_targets = nil,
			highlight_unlabeled_phase_one_targets = true,
			max_highlighted_traversal_targets = 10,
			substitute_chars = {},
			safe_labels = "sfnut/SFNLHMUGTZ?",
			labels = "sfnjklhodweimbuyvrgtaqpcxz/SFNJKLHODWEIMBUYVRGTAQPCXZ?",
			special_keys = {
				next_target = "<enter>",
				prev_target = "<backspace>",
				next_group = "<space>",
				prev_group = "<backspace>",
			},
		},
	}, -- }}}


	{ -- Autocompletion (blink.cmp) {{{2
		"saghen/blink.cmp",
		version = "*",
		dependencies = {
			"rafamadriz/friendly-snippets",
			-- Keep LuaSnip for local custom snippets
			{
				"L3MON4D3/LuaSnip",
				config = function()
					require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/lua/snippets/" } })
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
				dependencies = { "benfowler/telescope-luasnip.nvim" },
			},
		},
		opts = {
			keymap = {
				preset = "default",
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			snippets = { preset = "luasnip" },
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "lazydev" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
		},
		opts_extend = { "sources.default" },
	}, -- }}}
	--
	{ -- aerial.nvim {{{2
		-- Displays outline
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local aerial = require("aerial")
			aerial.setup({
				on_attach = function(bufnr)
					-- Jump forwards/backwards with '{' and '}'
					vim.keymap.set("n", "<leader>{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set("n", "<leader>}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				end,
			})
		end,
		keys = {
			{ "<leader>a", "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial" },
			{ "<leader>A", "<cmd>AerialToggle<CR>", desc = "which_key_ignore" },
			{ "<leader>{", "<cmd>AerialPrev<CR>", desc = "which_key_ignore" },
			{ "<leader>}", "<cmd>AerialNext<CR>", desc = "which_key_ignore" },
		},
	}, -- }}}
	{ -- flash.nvim {{{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			modes = {
				search = { enabled = false },
				char = { enabled = false },
			},
			label = {
				rainbow = {
					enabled = true,
				},
			},
		},
		-- stylua: ignore
		keys = {
			{ "S",         mode = { "n", "x", "o" }, function() require("flash").treesitter() end,desc = "Flash Treesitter" },
			{ "r",         mode = "o",               function() require("flash").remote() end,desc = "Remote Flash" },
			{ "R",         mode = { "n", "o", "x" }, function() require("flash").treesitter_search() end,desc = "Treesitter Search" },
			-- jump to scope
			-- { "<leader>n", mode = { "n" }, function() require("flash").treesitter({ jump = { pos = "start" }, label = { after = false } }) end, desc = "Flash Treesitter" },
		},
	}, -- }}}
	{ -- nvim-surround {{{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	}, -- }}}
	{ "tpope/vim-unimpaired", lazy = false },
	{ "tpope/vim-repeat", keys = { { "." } } },
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
	-- VCS
	{
		"rbong/vim-flog",
		lazy = true,
		cmd = { "Flog", "Flogsplit", "Floggit" },
		dependencies = {
			{
				"tpope/vim-fugitive",
				lazy = false,
				dependencies = { "tpope/vim-rhubarb" },
				keys = {
					{ "<leader>gg", ":Git ", desc = "Git command (Fugitive)" },
					{ "<leader>gs", ":Git<CR>", desc = "git status (Fugitive)" },
				},
			},
		},
	},
}

-- vim: foldmethod=marker foldlevel=1
