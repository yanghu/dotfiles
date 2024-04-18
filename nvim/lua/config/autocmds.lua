local aucmd = vim.api.nvim_create_autocmd
local function augroup(name, func)
  func(vim.api.nvim_create_augroup(name, { clear = true }))
end

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
aucmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Switch to relative number mode in normal mode.
augroup('NumberToggle', function(g)
  aucmd({ 'BufEnter', 'FocusGained', 'InsertLeave' }, {
    pattern = '*',
    group = g,
    command = 'set relativenumber',
  })
  aucmd({ 'BufLeave', 'FocusLost', 'InsertEnter' }, {
    pattern = '*',
    group = number_toggle,
    command = 'set norelativenumber',
  })
end)

