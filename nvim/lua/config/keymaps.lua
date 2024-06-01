-- {{{2 Helper functions
local function map(kind, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(kind, lhs, rhs, options)
end

local function nmap(lhs, rhs, opts)
	map("n", lhs, rhs, opts)
end

local function imap(lhs, rhs, opts)
	map("i", lhs, rhs, opts)
end
-- }}}2

-- ==============================================
-- [[ which-key register ]]
-- ==============================================
local wk = require("which-key")
wk.register({
	-- ["<leader>w"] = { name = "[W]orkspace" },
	["<localleader>cc"] = { name = "... copy file path" },
	["<leader>c"] = { name = "...code action" },
	["<leader>d"] = { name = "[D]iagnostics" },
	["<leader>g"] = { name = "Git" },
	["<leader>h"] = { name = "[H]unk gitsigns" },
	["<leader>ht"] = { name = "[T]oggle hunk visibilities" },
	["<leader>m"] = { name = "Grapple" },
	["<leader>r"] = { name = "...rename" },
	["<leader>s"] = { name = "Search" },
	["<leader>sn"] = { name = "[N]oice" },
	["<leader>u"] = { name = "Toggle options" },
	["<leader>x"] = { name = "Trouble" },
	-- Do not show some keys
	--   switch paste mode
	["<leader>M"] = { name = "which_key_ignore" },
	["<leader>W"] = { name = "which_key_ignore" },
	["<leader>e"] = { name = "which_key_ignore" },
	["<leader>j"] = { name = "which_key_ignore" },
	["<leader>k"] = { name = "which_key_ignore" },
	["<leader>p"] = { name = "which_key_ignore" },
	["<leader>w"] = { name = "which_key_ignore" },
})

-- ==============================================
-- [[ Toggle options ]]
-- ==============================================
-- stylua: ignore
nmap("<leader>uw", function() vim.wo.wrap = not vim.wo.wrap end, { desc = "Toggle Wrap" })

-- ==============================================
-- [[ Basic Keymaps ]]
-- ==============================================

-- Use space to cancel search highlight
nmap("<CR>", require("notify").dismiss)
-- Avoid going into ex mode
nmap("Q", "<Nop>")
nmap("QQ", "<cmd>qa<CR>")
-- Motion and Editing{{{2
nmap("<C-y>", "3<C-y>")
nmap("<C-e>", "3<C-e>")

-- Window movements
nmap("<C-h>", "<C-w>h")
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")

-- Switch buffers
nmap("<C-n>", vim.cmd.bnext)
nmap("<C-p>", vim.cmd.bprev)
-- Close the buffer and keep window
nmap("<C-c>", ":bp|bd #<CR>")

-- Toggle paste mode
nmap("<leader>p", ":se invpaste paste?<CR>")

-- %% expands to dir of the current buffer
vim.keymap.set("c", "%%", "getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'", {
	silent = true,
	expr = true,
	remap = false,
})
-- Quckly save file
nmap("XX", vim.cmd.update)
-- }}}

imap("jk", "<Esc>")

nmap("[x", function()
	require("treesitter-context").go_to_context(vim.v.count1)
end)

-- "where am I" from vim-matchup plugin. (M for "Matchup")
nmap("<c-m>", "<cmd>MatchupWhereAmI??<CR>")
--
-- -- Diagnostics motion
-- nmap("[d", vim.diagnostic.goto_prev, { desc = 'Previous [D]iagnostics'})
-- nmap("]d", vim.diagnostic.goto_next, { desc = 'Next [D]iagnostics'})

-- copy paths to system clipboard
vim.api.nvim_create_user_command("CP", [[let @+ = expand("%:.")]], {})
vim.api.nvim_create_user_command("CF", [[let @+ = expand("%:p")]], {})
vim.api.nvim_create_user_command("CN", [[let @+ = expand("%:t")]], {})

-- Yanks the current file path to " and + registers
-- If "g" or "d" are used as argument, include the depot or google3 portion of the path.
vim.api.nvim_create_user_command("GCF", function(opts)
	local prefix_to_remove = "^//depot/google3/"
	if opts.args ~= "" then
		if string.match(opts.fargs[1], "^g") then
			prefix_to_remove = "^//depot/"
		elseif string.match(opts.fargs[1], "^d") then
			prefix_to_remove = ""
		end
	end
	local depot_path = vim.fn["piperlib#GetDepotPath"](vim.fn.expand("%:p")):gsub(prefix_to_remove, "")
	vim.fn.setreg("+", depot_path)
	vim.fn.setreg('"', depot_path)
end, { desc = "Return relative path in workspace", nargs = "?" })

-- Keymaps to copy file paths
nmap("<localleader>ccf", "<cmd>GCF<CR>", { desc = "copy file path" })
nmap("<localleader>ccg", "<cmd>GCF g3<CR>", { desc = "copy file path including g3" })
nmap("<localleader>ccd", "<cmd>GCF depot<CR>", { desc = "copy depot file path" })

-- change pwd to buffer cwd
nmap("<leader>cd", function()
	vim.api.nvim_set_current_dir(vim.fn.expand("%:h"))
end)

-- Plugins
-- Noice LSP hover scroll
vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
	if not require("noice.lsp").scroll(4) then
		return "<c-f>"
	end
end, { silent = true, expr = true })

vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
	if not require("noice.lsp").scroll(-4) then
		return "<c-b>"
	end
end, { silent = true, expr = true })

-- vim: foldmethod=marker foldlevel=1
