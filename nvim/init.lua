vim.opt.backup = true
vim.opt.formatoptions = crqn1j

vim.opt.breakindent = true
vim.opt.breakindentopt:append({shift=2})

-- Tabs
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.shiftround = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Ignore files
vim.opt.wildignore:append({
  '*.o', '*.d', '00*', 'nohup.out', 'tags', 
  '.hs-tags', '*.hi', '*.gcno', '*.gcda', '*.fasl', '*.pyc'
})
-- MacOS ignore
vim.opt.wildignore:append({
  '*/tmp/*', '*.so', '*.swp', '*.zip', '.DS_Store', '*/.metadata/*'
})
vim.opt.wildignorecase = true

-- Allows scrolling to next/prev lines with left/right
vim.opt.whichwrap:append("<,>,h,l,[,]")

-- Raise a dialog asking if you wish to save changed files
vim.opt.confirm = true

-- Enables magic regex
vim.opt.magic = true

-- ==============================================
--                      Appearnces
-- ==============================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cc = 80

