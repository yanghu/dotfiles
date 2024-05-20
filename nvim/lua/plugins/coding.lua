return {
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
	{ -- hop.nvim {{{2
		"smoka7/hop.nvim",
		version = "*",
		opts = {
			keys = "etovxqpdygfblzhckisuran",
			uppercase_labels = true,
		},
		keys = {
			{
				"<leader>j",
				function()
					require("hop").hint_lines({ direction = require("hop.hint").HintDirection.AFTER_CURSOR })
				end,
				desc = "Hop down lines",
			},
			{
				"<leader>k",
				function()
					require("hop").hint_lines({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR })
				end,
				desc = "Hop up lines",
			},
			{
				"<leader>ee",
				function()
					require("hop").hint_camel_case({ current_line_only = true })
				end,
				desc = "Hop Camel Case",
			},
			{
				"<leader>w",
				function()
					require("hop").hint_words({ direction = require("hop.hint").HintDirection.AFTER_CURSOR })
				end,
				desc = "Hop Words",
			},
			{
				"<leader>W",
				function()
					require("hop").hint_words({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR })
				end,
				desc = "Hop Words",
			},
			-- {
			-- 	"s",
			-- 	function()
			-- 		require("hop").hint_char2({})
			-- 	end,
			-- 	desc = "Hop 2char",
			-- },
		},
	}, -- }}}

	{ -- Autocompletion (nvim-cmp, luasnip, etc.) {{{2
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{ -- luasnip {{{
				"L3MON4D3/LuaSnip",
				config = function()
					require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/lua/snippets/" } })
				end,
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
					{ "benfowler/telescope-luasnip.nvim" },
				},
			}, -- }}}
			"saadparwaiz1/cmp_luasnip",

			{
				"hrsh7th/cmp-cmdline",
				dependencies = { "hrsh7th/nvim-cmp" },
				keys = { "/", "?", ":" },
				config = function()
					local cmp = require("cmp")
					-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
					cmp.setup.cmdline(":", {
						mapping = cmp.mapping.preset.cmdline(),
						sources = cmp.config.sources({
							{ name = "path" },
						}, {
							{ name = "cmdline", option = {
								ignore_cmds = { "Man", "!" },
							} },
						}),
					})
				end,
			},
			-- Adds other completion capabilities.
			--  nvim-cmp does not ship with all sources by default. They are split
			--  into multiple repos for maintenance purposes.
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			-- Adds pictograms to neovim built-in lsp
			"onsails/lspkind.nvim",
		},
		opts = function(_, opts)
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			return vim.tbl_deep_extend("force", opts, {
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },

				-- For an understanding of why these mappings were
				-- chosen, you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				mapping = cmp.mapping.preset.insert({ -- {{{
					-- Select the [n]ext item
					["<C-j>"] = cmp.mapping.select_next_item(),
					-- Select the [p]revious item
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-c>"] = cmp.mapping.close(),

					-- Scroll the documentation window [b]ack / [f]orward
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					-- Accept ([y]es) the completion.
					--  This will auto-import if your LSP supports it.
					--  This will expand snippets if the LSP sent a snippet.
					["<C-y>"] = cmp.mapping.confirm({ select = true }),

					-- Manually trigger a completion from nvim-cmp.
					--  Generally you don't need this, because nvim-cmp will display
					--  completions whenever it has completion options available.
					["<C-Space>"] = cmp.mapping.complete({}),

					-- Think of <c-l> as moving to the right of your snippet expansion.
					--  So if you have a snippet that's like:
					--  function $name($args)
					--    $body
					--  end
					--
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),

					-- For choice node. inspired from
					-- https://www.reddit.com/r/neovim/comments/tbtiy9/comment/i0bje36/
					["<C-e>"] = cmp.mapping(function()
						if luasnip.choice_active() then
							luasnip.change_choice(1)
						end
					end, { "i", "s" }),
					-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
					--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
				}), -- }}}
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "buffer" },
				},
				formatting = {
					format = {
						mode = "symbol_text", -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						-- can also be a function to dynamically calculate max width such as
						-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
						show_labelDetails = true, -- show labelDetails in menu. Disabled by default
					},
				},
			})
		end,
		config = function(_, opts)
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})
			local lspkind = require("lspkind")

			cmp.setup(vim.tbl_deep_extend("force", opts, {
				formatting = {
					format = lspkind.cmp_format(opts.formatting.format),
				},
			}))
		end,
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
