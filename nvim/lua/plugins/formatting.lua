-- Formatting
return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		-- stylua: ignore
		keys = {
			{ "<localleader>f", function() require("conform").format({ async = true, lsp_fallback = true }) end,
				mode = "", desc = "Format buffer", },
			{ "<localleader>cF", function() require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 }) end,
				mode = { "n", "v" }, desc = "Format injected code blocks", },
		},

		opts = {
			-- Define your formatters
			formatters_by_ft = {
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
					-- args = { "--prose-wrap", "always" },
				},
			},
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}
