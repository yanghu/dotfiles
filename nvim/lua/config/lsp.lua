local M = {}

M.optional_servers = {
	beancount = require("config.servers.beancount").config,
}

M.local_servers = {
	bashls = {
		filetypes = {
			"sh",
			"bash",
		},
	},
	clangd = {
		cmd = { "/usr/bin/clangd" },
	},
	gopls = {},
	pyright = {},
	-- rust_analyzer = {},
	-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
	--
	-- Some languages (like typescript) have entire language plugins that can be useful:
	--    https://github.com/pmizio/typescript-tools.nvim
	--
	-- But for many setups, the LSP (`tsserver`) will work just fine
	-- tsserver = {},
	--
	jsonls = {},

	lua_ls = {
		-- cmd = {...},
		-- filetypes = { ...},
		-- capabilities = {},
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
				-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
				-- diagnostics = { disable = { 'missing-fields' } },
			},
		},
	},
	marksman = {},
	vimls = {},
}

if not require("utils.env").at_work() then
	M.servers = M.local_servers
else
	M.servers = {}
end

return M
