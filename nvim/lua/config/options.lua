local indent = 2


vim.opt.backup = true
vim.opt.undofile = true
vim.opt.formatoptions = crqn1j


-- Enable breakindent
vim.opt.breakindent = true
vim.opt.breakindentopt:append({shift=2})

-- Tabs
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.shiftround = true

-- Case-insensitive search
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

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.g.have_nerd_font = true
-- ==============================================
--                      Appearnces
-- ==============================================
vim.opt.number = true
vim.opt.relativenumber = true

-- highlight the current line
vim.opt.cursorline = true

-- Display whitespaces
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '-', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Ruler
vim.opt.ruler = true
vim.opt.cc = '80'

-- Don't show mode
vim.opt.showmode = false

