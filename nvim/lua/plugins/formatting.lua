-- Formatting
return {
	{ -- stevearc/conform.nvim {{{2
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		-- stylua: ignore
		keys = {
			{ "<localleader>f", function() require("conform").format({ async = true, lsp_fallback = true }) end,
				mode = "", desc = "Format buffer", },
			{ "<localleader>mf", function() require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 }) end,
				mode = { "n", "v" }, desc = "Format injected code blocks", },
		},

		opts = {
			-- Define your formatters
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
				go = { "goimports", "gofmt" },
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { { "prettierd", "prettier" } },
				markdown = { { "prettierd", "prettier" } },
			},
			-- Set up format-on-save
			format_on_save = function(bufnr)
				-- Whitelist file types that uses autoformat
				local af_filetypes = { "go", "lua", "markdown" }
				if not vim.tbl_contains(af_filetypes, vim.bo[bufnr].filetype) then
					return
				end
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_fallback = true }
			end,
			-- Customize formatters
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2" },
				},
				-- Always wrap markdown files to text width
				prettierd = {
					env = {
						PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/utils/linter-config/.prettierrc.toml"),
					},
				},
			},
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

			-- Create custom command for disable auto format
			vim.api.nvim_create_user_command("FormatDisable", function(args)
				if args.bang then
					-- FormatDisable! will disable formatting just for this buffer
					vim.b.disable_autoformat = true
				else
					vim.g.disable_autoformat = true
				end
			end, {
				desc = "Disable autoformat-on-save",
				bang = true,
			})
			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
			end, {
				desc = "Re-enable autoformat-on-save",
			})
		end,
	}, -- }}}
}

-- vim: foldmethod=marker foldlevel=1
