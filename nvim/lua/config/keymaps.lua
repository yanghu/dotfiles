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
	["<leader>e"] = { name = "easymotion" },
	["<leader>w"] = { name = "[W]orkspace" },
	["<leader>d"] = { name = "[D]iagnostics" },
})

-- ==============================================
-- [[ Basic Keymaps ]]
-- ==============================================

-- Use space to cancel search highlight
nmap("<CR>", "<cmd>nohlsearch<CR>")
-- Avoid going into ex mode
nmap("Q", "<Nop>")

-- Motion and Editing{{{2
nmap("<C-y>", "3<C-y>")
nmap("<C-e>", "3<C-e>")

-- Quickfix list
nmap("<c-j>", ":cnext<CR>")
nmap("<c-k>", ":cprev<CR>")
-- nmap('<leader>qs', vim.diagnostic.setqflist)
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

nmap("[c", function()
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

-- vim: foldmethod=marker foldlevel=1
