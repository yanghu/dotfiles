local icons = require("config.ui").icons
return {
	{ -- akinsho/bufferline.nvim {{{2
		"akinsho/bufferline.nvim",
		version = "*",
		event = "VeryLazy",
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
	{ -- lukas-reineke/indent-blankline.nvim {{{2
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
		event = "VeryLazy",
	}, -- }}}
	{ "echasnovski/mini.indentscope", version = "*", config = true, ft = { "lua", "python", "c", "go", "java" } },
	{ -- noice.nvim {{{
		"folke/noice.nvim",
		-- event = "VeryLazy",
		lazy = false,
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
				routes = {
					{ -- route long messages to split
						filter = {
							event = "msg_show",
							any = { { min_height = 5 }, { min_width = 200 } },
							["not"] = {
								kind = { "confirm", "confirm_sub", "return_prompt", "quickfix", "search_count" },
							},
							blocking = false,
						},
						view = "messages",
						opts = { stop = true },
					},
					{ -- route long messages to split
						filter = {
							event = "msg_show",
							any = { { min_height = 5 }, { min_width = 200 } },
							["not"] = {
								kind = { "confirm", "confirm_sub", "return_prompt", "quickfix", "search_count" },
							},
							blocking = true,
						},
						view = "mini",
					},
					{ -- hide `written` message
						filter = {
							event = "msg_show",
							kind = "",
							find = "written",
						},
						opts = { skip = true },
					},
					{ -- send annoying msgs to mini
						filter = {
							event = "msg_show",
							any = {
								{ find = "; after #%d+" },
								{ find = "; before #%d+" },
								{ find = "fewer lines" },
							},
						},
						view = "mini",
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = true, -- add a border to hover docs and signature help
				},
			})
			local lualine_x = require("lualine").get_config().sections.lualine_x
			local merged_line = vim.tbl_deep_extend("force", lualine_x, {
				{
					require("noice").api.statusline.mode.get,
					cond = require("noice").api.statusline.mode.has,
					color = { fg = "#ff9e64" },
				},
			})
			require("lualine").setup({
				sections = {
					lualine_x = merged_line,
				},
			})
		end,
		-- stylua: ignore
		keys = {
			-- { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
			{ "<leader>snl", function() require("noice").cmd("last") end,                                   desc = "Noice Last Message" },
			{ "<leader>snh", function() require("noice").cmd("history") end,                                desc = "Noice History" },
			{ "<leader>sna", function() require("noice").cmd("all") end,                                    desc = "Noice All" },
			{ "<leader>snd", function() require("noice").cmd("dismiss") end,                                desc = "Dismiss All" },
			{ "<c-f>",       function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,  silent = true,              expr = true, desc = "Scroll Forward",  mode = { "i", "n", "s" } },
			{ "<c-b>",       function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true,              expr = true, desc = "Scroll Backward", mode = { "i", "n", "s" } },
		},
	}, -- }}}
	{ -- nvim-lualine/lualine.nvim {{{2
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "folke/noice.nvim" },
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
					"grapple",
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
}

-- vim: foldmethod=marker foldlevel=1
