-- {{{2 Helper functions
local function map(kind, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(kind, lhs, rhs, options)
end

local function nmap(lhs, rhs, opts)
  map('n', lhs, rhs, opts)
end

local function imap(lhs, rhs, opts)
  map('i', lhs, rhs, opts)
end
-- }}}2

-- ==============================================
-- [[ which-key register ]]
-- ==============================================
local wk = require("which-key")
wk.register({
  ["<leader>e"] = { name = "easymotion" },
  ["<leader>w"] = { name = "[W]orkspace" },
  ["<leader>d"] = {
    name = "[D]iagnostics",
    j = { vim.diagnostic.goto_next, "Go to next diagnostics" },
    k = { vim.diagnostic.goto_prev, "Go to previous diagnostics" },
    d = { require('fzf-lua').diagnostics_document, "[D]iagnostics [D]ocument" },
    w = { require('fzf-lua').diagnostics_workspace, "[D]iagnostics [W]orkspace" },
  }
})

-- ==============================================
-- [[ Basic Keymaps ]]
-- ==============================================

-- Use space to cancel search highlight
nmap('<Space>', '<cmd>nohlsearch<CR>')
-- Avoid going into ex mode
nmap('Q', '<Nop>')

-- Motion and Editing{{{2
nmap('<C-y>', '3<C-y>')
nmap('<C-e>', '3<C-e>')

-- Switch buffers
nmap('<C-n>', vim.cmd.bnext)
nmap('<C-p>', vim.cmd.bprev)
-- Close the buffer and keep window
nmap('<C-c>', ':bp|bd #<CR>')

-- Toggle paste mode
nmap('<leader>p', ':se invpaste paste?<CR>')

-- %% expands to dir of the current buffer
vim.keymap.set('c', '%%', "getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'", {
  silent = true, expr = true, remap = false })
-- Quckly save file
nmap('XX', vim.cmd.update)
-- }}}


imap('jk', '<Esc>')

-- vim: foldmethod=marker foldlevel=1
