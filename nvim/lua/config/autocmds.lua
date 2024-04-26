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
    callback = function ()
      if vim.opt.number:get() then
        vim.opt.relativenumber = true
      end
    end
  })
  aucmd({ 'BufLeave', 'FocusLost', 'InsertEnter' }, {
    pattern = '*',
    group = g,
    callback = function ()
      vim.opt.relativenumber = false
    end
  })
end)


-- Check if we need to reload the file when it changed
augroup('checktime', function(g)
  aucmd({ 'TermLeave', 'FocusGained', 'TermClose' }, {
    pattern = '*',
    group = g,
    callback = function ()
      if vim.o.buftype ~= "nofile" then
        vim.cmd("checktime")
      end
    end
  })
end)

-- close some filetypes with <q>, and hide line numbers
augroup('close_with_q', function(g)
  aucmd("FileType", {
    pattern = {
      "PlenaryTestPopup",
      "aerial",
      "help",
      "lspinfo",
      "notify",
      "qf",
      "query",
      "spectre_panel",
      "startuptime",
      "tsplayground",
      "trouble",
      "neotest-output",
      "checkhealth",
      "neotest-summary",
      "neotest-output-panel",
    },
    group = g,
    callback = function (event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.b.miniindentscope_disable = true
    end
  })
end)


-- Wrap and check for spell in text files
augroup('wrap_spell_text', function(g)
  aucmd("FileType", {
    pattern = {
      "gitcommit", "markdown"
    },
    group = g,
    callback = function ()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end
  })
end)


-- Auto create dir when saving a file, in case some intermediate directory does not exist
augroup('auto_create_dir', function(g)
  aucmd("BufWritePre", {
    pattern = "*",
    group = g,
    callback = function(event)
      if event.match:match("^%w%w+:[\\/][\\/]") then
        return
      end
      local file = vim.uv.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end
  })
end)

