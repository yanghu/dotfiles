local prefix = vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config")
local o = vim.opt

o.mouse = ""
o.backup = true
o.backupdir = { prefix .. "/nvim/backup//" }
o.undofile = true
o.formatoptions = "crqn1j"

-- Enable breakindent
o.breakindent = true
o.breakindentopt:append({ shift = 2 })

-- Tabs
o.tabstop = 2
o.expandtab = true
o.shiftwidth = 2
o.shiftround = true

-- Case-insensitive search
o.ignorecase = true
o.smartcase = true

-- Ignore files
o.wildignore:append({
	"*.o",
	"*.d",
	"00*",
	"nohup.out",
	"tags",
	".hs-tags",
	"*.hi",
	"*.gcno",
	"*.gcda",
	"*.fasl",
	"*.pyc",
})
-- MacOS ignore
o.wildignore:append({
	"*/tmp/*",
	"*.so",
	"*.swp",
	"*.zip",
	".DS_Store",
	"*/.metadata/*",
})
o.wildignorecase = true

-- Allows scrolling to next/prev lines with left/right
o.whichwrap:append("<,>,h,l,[,]")

-- Raise a dialog asking if you wish to save changed files
o.confirm = true

-- Enables magic regex
o.magic = true

-- Configure how new splits should be opened
o.splitright = true
o.splitbelow = true

vim.g.have_nerd_font = true
-- ==============================================
--                      Appearnces
-- ==============================================
o.number = true
o.relativenumber = true
o.wrap = false

-- highlight the current line
o.cursorline = true

-- Display whitespaces
o.list = true
o.listchars = { tab = "» ", trail = "-", nbsp = "␣" }

-- Preview substitutions live, as you type!
o.inccommand = "split"

-- Minimal number of screen lines to keep above and below the cursor.
o.scrolloff = 5

-- Full width status line always at bottom
-- o.laststatus = 3
-- Need to set vim.go, because otherwise lualine will try to set it to 2.
-- See: https://www.reddit.com/r/neovim/comments/1clx1cu/comment/l2xza81/
-- The following would work though.
-- vim.cmd([[set laststatus=3]])
vim.go.laststatus = 3

-- Ruler
o.ruler = true
o.colorcolumn = "80"
o.signcolumn = "yes"

-- Don't show mode
o.showmode = false

vim.filetype.add({
	extension = {
		bean = "beancount",
		keymap = "c",
		bundle = "pbtxt",
		pi = "piccolo",
	},
})

-- Themes
vim.o.background = "dark" -- or "light" for light mode
