local env = require("utils.env")

local local_lsp = function()
	if not env.at_work() then
		return {
			"neovim/nvim-lspconfig",
			event = "BufReadPre",
			dependencies = {
				-- Automatically install LSPs and related tools to stdpath for Neovim
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
				"WhoIsSethDaniel/mason-tool-installer.nvim",

				-- Useful status updates for LSP.
				-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
				{ "j-hui/fidget.nvim", opts = {} },

				-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
				-- used for completion, annotations and signatures of Neovim apis
				{ "folke/neodev.nvim", opts = {} , enabled=false},
				{
					"SmiteshP/nvim-navic",
					config = function()
						require("nvim-navic").setup({
							highlight = true,
						})
					end,
				},
				{
					"kosayoda/nvim-lightbulb",
					config = function()
						require("nvim-lightbulb").setup({
							autocmd = { enabled = true },
						})
					end,
				},
			},
			config = function()
				require("lspconfig.ui.windows").default_options.border = require("config.ui").borders
				-- Diagnostics Display
				local function toggle_diagnostics()
					local enabled = not vim.diagnostic.is_disabled(0)
					if not enabled then
						vim.diagnostic.enable(0)
						vim.notify("Diagnostics enabled", vim.log.levels.INFO, { title = "[LSP]" })
					else
						vim.diagnostic.disable(0)
						vim.notify("Diagnostics disabled", vim.log.levels.INFO, { title = "[LSP]" })
					end
				end
				vim.keymap.set("n", "[d", function()
					vim.diagnostic.goto_prev({ float = false })
				end, { desc = "Diagnostic: got to previous error" })
				vim.keymap.set("n", "]d", function()
					vim.diagnostic.goto_next({ float = false })
				end, { desc = "Diagnostic: got to next error" })
				vim.keymap.set("n", "<leader>dt", toggle_diagnostics, { desc = "Diagnostics: toggle" })
				vim.keymap.set(
					"n",
					"<leader>df",
					vim.diagnostic.open_float,
					{ desc = "Diagnostics: open floating window" }
				)
				vim.keymap.set(
					"n",
					"<leader>dl",
					vim.diagnostic.setloclist,
					{ desc = "Diagnostics: populate location list" }
				)
				vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Diagnostics: populate quickfix" })

				vim.diagnostic.config({
					float = {
						border = require("config.ui").borders,
						focusable = false,
						header = "",
						scope = "line",
						source = "always",
					},
					virtual_text = {
						source = "always",
					},
				})

				--  This function gets run when an LSP attaches to a particular buffer.
				--    That is to say, every time a new file is opened that is associated with
				--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
				--    function will be executed to configure the current buffer
				vim.api.nvim_create_autocmd("LspAttach", {
					group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
					callback = function(event)
						local nmap = function(keys, func, desc)
							vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
						end

						local imap = function(keys, func, desc)
							vim.keymap.set("i", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
						end
						-- Jump to the definition of the word under your cursor.
						--  This is where a variable was first declared, or where a function is defined, etc.
						--  To jump back, press <C-t>.
						-- nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

						-- Find references for the word under your cursor.
						-- nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

						-- Jump to the implementation of the word under your cursor.
						--  Useful when your language has ways of declaring types without an actual implementation.
						nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

						-- Jump to the type of the word under your cursor.
						--  Useful when you're not sure what type a variable is and you want to see
						--  the definition of its *type*, not where it was *defined*.
						nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

						-- Fuzzy find all the symbols in your current document.
						--  Symbols are things like variables, functions, types, etc.
						nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

						-- Fuzzy find all the symbols in your current workspace.
						--  Similar to document symbols, except searches over your entire project.
						nmap(
							"<leader>ws",
							require("telescope.builtin").lsp_dynamic_workspace_symbols,
							"[W]orkspace [S]ymbols"
						)

						-- Rename the variable under your cursor.
						--  Most Language Servers support renaming across files, etc.
						nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

						-- Execute a code action, usually your cursor needs to be on top of an error
						-- or a suggestion from your LSP for this to activate.
						-- nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

						-- Opens a popup that displays documentation about the word under your cursor
						--  See `:help K` for why this keymap.
						nmap("K", vim.lsp.buf.hover, "Hover Documentation")

						nmap("gK", vim.lsp.buf.signature_help, "Signature Help")
						imap("<c-s>", vim.lsp.buf.signature_help, "Signature Help")

						-- WARN: This is not Goto Definition, this is Goto Declaration.
						--  For example, in C this would take you to the header.
						nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

						-- The following two autocommands are used to highlight references of the
						-- word under your cursor when your cursor rests there for a little while.
						--    See `:help CursorHold` for information about when this is executed
						--
						-- When you move your cursor, the highlights will be cleared (the second autocommand).
						local client = vim.lsp.get_client_by_id(event.data.client_id)
						if client and client.server_capabilities.documentHighlightProvider then
							vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
								buffer = event.buf,
								callback = vim.lsp.buf.document_highlight,
							})

							vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
								buffer = event.buf,
								callback = vim.lsp.buf.clear_references,
							})
						end

						-- The following autocommand is used to enable inlay hints in your
						-- code, if the language server you are using supports them
						--
						-- This may be unwanted, since they displace some of your code
						if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
							nmap("<leader>th", function()
								vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
							end, "[T]oggle Inlay [H]ints")
						end

						if client.server_capabilities.documentSymbolProvider then
							require("nvim-navic").attach(client, event.buf)
						end
					end,
				})
				-- End of LSPAttach

				-- LSP servers and clients are able to communicate to each other what features they support.
				--  By default, Neovim doesn't support everything that is in the LSP specification.
				--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
				--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
				local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities =
					vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

				-- Enable the following language servers
				--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
				--
				--  Add any additional override configuration in the following tables. Available keys are:
				--  - cmd (table): Override the default command used to start the server
				--  - filetypes (table): Override the default list of associated filetypes for the server
				--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
				--  - settings (table): Override the default settings passed when initializing the server.
				--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
				local servers = require("config.lsp").servers

				-- Ensure the servers and tools above are installed
				--  To check the current status of installed tools and/or manually install
				--  other tools, you can run
				--    :Mason
				--
				--  You can press `g?` for help in this menu.
				require("mason").setup()

				-- You can add other tools here that you want Mason to install
				-- for you, so that they are available from within Neovim.
				local ensure_installed = vim.tbl_keys(servers or {})
				vim.list_extend(ensure_installed, {
					"stylua", -- Used to format Lua code
				})
				require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

				vim.list_extend(servers, require("config.lsp").optional_servers)
				require("mason-lspconfig").setup({
					handlers = {
						function(server_name)
							local server = servers[server_name] or {}
							-- This handles overriding only values explicitly passed
							-- by the server configuration above. Useful when disabling
							-- certain features of an LSP (for example, turning off formatting for tsserver)
							server.capabilities =
								vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
							require("lspconfig")[server_name].setup(server)
						end,
					},
				})
			end,
		}
	else
		return {}
	end
	-- code
	-- return nil
end

return {
	local_lsp(),
	{ -- nvimdev/lspsaga.nvim {{{2
		"nvimdev/lspsaga.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter",
		},
		event = "VeryLazy",
		cmd = "Lspsaga",
		opts = {
			scroll_preview = {
				scroll_down = "<c-d>",
				scroll_up = "<c-u>",
			},
			ui = {
				border = "rounded",
			},
			code_action = {
				keys = {
					quit = { "q", "<esc>" },
				},
			},
			symbol_in_winbar = {
				enable = false,
				hide_keyword = true,
				respect_root = true,
			},
			path_display = function(path, root)
				local pwd = vim.loop.cwd()
				if root and path:sub(1, #root) == root then
					root = root
				elseif path:sub(1, #pwd) == pwd then
					root = pwd
				else
					root = vim.env.HOME
				end
				local path_sep = require("lspsaga.util").path_sep
				if root ~= "" then
					root = root:sub(#root - #path_sep + 1) == path_sep and root or root .. path_sep
					path = path:sub(#root + 1)
				end
				return path
			end,
		},
		config = function(_, opts)
			require("lspsaga").setup(opts)
			if type(opts.path_display) == "function" then
				require("lspsaga.util").path_sub = opts.path_display
			end
			-- This is used in markdown files, but seems to be unique to CiderLSP.
			require("lspsaga.lspkind").kind[0] = { "Heading", "# ", "Heading" }
		end,
	}, -- }}}
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			"williamboman/mason.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "luvit-meta/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		keys = {
			{
				"gk",
				"<cmd>Lspsaga hover_doc<cr>",
				desc = "LSP hover",
			},
			{
				"<leader>ca",
				"<cmd>Lspsaga code_action<cr>",
				desc = "Code Actions",
			},
			{
				"gp",
				"<cmd>Lspsaga peek_definition<cr>",
				desc = "Peek definition",
			},
			{
				"gd",
				"<cmd>Lspsaga goto_definition<cr>",
				desc = "Goto definition",
			},
			{
				"gY",
				"<cmd>Lspsaga goto_type_definition<cr>",
				desc = "Goto itype definition",
			},
			{
				"gy",
				"<cmd>Lspsaga peek_type_definition<cr>",
				desc = "Peek type definition",
			},
			{
				"gr",
				"<cmd>Lspsaga finder<cr>",
				desc = "Show references",
			},
			{
				"gI",
				"<cmd>Lspsaga finder imp<cr>",
			},
			{
				"<leader>go",
				"<cmd>Lspsaga outline<cr>",
				desc = "Show outline",
			},
			{
				"[d",
				"<cmd>Lspsaga diagnostic_jump_prev<cr>",
				desc = "Goto previous diagnostic",
			},
			{
				"]d",
				"<cmd>Lspsaga diagnostic_jump_next<cr>",
				desc = "Goto next diagnostic",
			},
			{
				"[D",
				"<cmd>lua require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.ERROR })<cr>",
				desc = "Goto previous diagnostic error",
			},
			{
				"]D",
				"<cmd>lua require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.ERROR })<cr>",
				desc = "Goto next diagnostic error",
			},
			{
				"<leader>sl",
				"<cmd>Lspsaga show_line_diagnostics ++unfocus<cr>",
				desc = "Show line diagnostics",
			},
		},
	},
}

-- vim: foldmethod=marker foldlevel=1
