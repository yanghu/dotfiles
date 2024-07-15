local icons = require("config.ui").icons
return {
	{ -- akinsho/bufferline.nvim {{{2
		"akinsho/bufferline.nvim",
		version = "*",
		event = "VeryLazy",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				-- highlights = require("catppuccin.groups.integrations.bufferline").get(),
				options = {
					numbers = "bufer_id",
					diagnostics = "nvim_lsp",
					indicator = { style = "underline" },
					show_buffer_close_icons = false,
					show_close_icon = false,
					separator_style = "slant",
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
		-- enabled = false,
		-- event = "VeryLazy",
		lazy = false,
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					-- ["vim.lsp.util.stylize_markdown"] = true,
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
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			{ "MunifTanjim/nui.nvim", branch = "main" },
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		config = function(_, opts)
			require("noice").setup(opts)
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
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"folke/noice.nvim",
			"nvimdev/lspsaga.nvim",
		},
		-- lazy = false,
		event = "VeryLazy",
		opts = {
			-- options = { theme = "catppuccin" },
			options = { theme = "gruvbox-material" },
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
					-- {
					-- 	"navic",
					-- 	color_correction = nil,
					-- 	navic_opts = nil,
					-- },
				},
			},
			extensions = { "aerial", "quickfix", "trouble" },
			winbar = {},
		},
		config = function(_, opts)
			-- Setup lualine
			opts.sections.lualine_c = { { require("lspsaga.symbol.winbar").get_bar } }

			opts.sections.lualine_x = {
				{
					require("noice").api.statusline.mode.get,
					cond = require("noice").api.statusline.mode.has,
					color = { fg = "#ff9e64" },
				},
			}
			require("lualine").setup(opts)
		end,
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

				-- Navigation
				map("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]h", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, "Next hunk")

				map("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[h", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, "Prev hunk")

				-- Actions
				map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
				map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
				map("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Stage hunk")
				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Reset hunk")
				-- map("n", "<leader>hp", gitsigns.preview_hunk)
				map("n", "<leader>htb", gs.toggle_current_line_blame, "Toggle line blame")
				map("n", "<leader>htd", gs.toggle_deleted, "Toggle delete hunk view")

				-- stylua: ignore start
				map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
				map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")
				map("n", "<leader>hp", gs.preview_hunk_inline, "Preview Hunk Inline")
				map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame Line")
				map("n", "<leader>hd", gs.diffthis, "Diff This")
				map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff This ~")
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
				-- return from diff mode
				map("n", "<leader>hq", "<cmd>wincmd p | q<CR>", "Quit diff view")
			end,
		},
	}, -- }}}
	{ -- b0o/incline.nvim {{{2
		-- Displays a mini "winbar" on top right of a window.
		-- Type icon and filename are displayed. More can be added
		"b0o/incline.nvim",
		config = function()
			local helpers = require("incline.helpers")
			local devicons = require("nvim-web-devicons")
			require("incline").setup({
				window = {
					padding = 0,
					margin = { horizontal = 0 },
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if filename == "" then
						filename = "[No Name]"
					end
					local ft_icon, ft_color = devicons.get_icon_color(filename)
					local modified = vim.bo[props.buf].modified
					return {
						ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
							or "",
						" ",
						{ filename, gui = modified and "bold,italic" or "bold" },
						" ",
						guibg = "#44406e",
					}
				end,
			})
		end,
		branch = "main",
		-- Optional: Lazy load Incline
		event = "VeryLazy",
	}, -- }}}
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			local sign = function(hl, icon)
				vim.fn.sign_define(hl, {
					texthl = hl,
					text = icon,
					numhl = "",
				})
			end
			sign("DiagnosticSignError", "󰅚") -- \udb80\udd5a nf-md-close_circle_outline
			sign("DiagnosticSignWarn", "󰀪") -- \udb80\udc2a nf-md-alert_outline
			sign("DiagnosticSignHint", "󰌶") -- \udb80\udf36 nf-md-lightbulb_outline
			sign("DiagnosticSignInfo", "") -- \uf449 nf-oct-info
		end,
	},
	{
		"NStefan002/screenkey.nvim",
		lazy = false,
		version = "*", -- or branch = "dev", to use the latest commit
	},
}

-- vim: foldmethod=marker foldlevel=1
