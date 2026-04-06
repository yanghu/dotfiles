local M = {}
-- icons
M.icons = {
	diagnostics = {
		" ",
		" ",
		" ",
		" ",
		"󰄭 ",
	},
	git = {
		-- added = '󰐖 ', modified = '󰅗  ', removed = '󰍵  ', renamed = '󰛂 '
		-- added = '󰜄  ', modified = '󰅘  ', removed = '󰛲  ', renamed = '󰜶 '
		added = "󰐙 ",
		modified = "󰅚  ",
		removed = "󰍷  ",
		renamed = "󰳠 ",
		untracked = " ",
		ignored = " ",
		unstaged = " ",
		staged = " ",
		conflict = " ",
	},
	kinds = {
		Array = " ", -- ' ', -- '󰕤 ',
		Boolean = " ", -- ' ', --'󰘨 ',
		Class = " ", -- '󰌗 ', -- ' ',
		Color = " ", -- '󰏘 ', -- ' ',
		Constant = " ", -- ' ',
		Constructor = " ", -- ' ', -- ' ', -- ' ',
		Enum = " ", -- ' ', -- '󰕘 ',
		EnumMember = " ", -- ' ', -- ' ',
		Event = " ", -- ' ', -- ' ',
		Field = " ", -- '󰆧 ', -- ' ',
		File = " ", -- ' ', -- ' ',
		Folder = " ", -- ' ',
		Function = "󰊕 ", -- ' ',
		Interface = " ", -- ' ', -- ' ',
		Keyword = " ", -- ' ', -- '󰌋 ', -- ' ',
		Method = " ", -- '󰊕 ',
		Module = " ", -- '󰅩 ',
		Namespace = " ", -- '󰅩 ',
		Number = " ", -- ' ', -- '󰐣 ',
		Object = " ", -- '󰗀 ',
		Operator = " ", -- '󰒕 ',
		Package = " ", -- ' ', -- '󰏖  ',
		Property = " ", -- ' ', -- ' ',
		Reference = " ", -- '  ', -- '󰈇 ' -- ' ',
		Snippet = " ", -- ' ', '󰈙 ', -- ' ', !!!
		String = " ", -- ' ', -- ' ',
		Struct = " ", -- ' ',  --'󱏒 ', -- ' ',
		Text = " ", -- '  ', -- ' ',
		TypeParameter = " ", -- ' ', -- ' ', -- ' ',
		Unit = "󰺾 ", -- '󰑭 ', -- '󰜫 '  --' ',
		Value = "󰎠 ", -- ' ',
		Variable = " ", -- '󰆧 ', -- ' ',
	},
	lazy = {
		cmd = " ",
		config = " ",
		event = " ",
		ft = " ",
		import = " ",
		init = " ",
		keys = " ",
		plugin = " ",
		runtime = " ",
		source = " ",
		start = " ",
		task = " ",
	},
}

-- borders --
-- M.borders = { '╤', '═', '╤', '│', '╧', '═', '╧', '│' }
-- M.borders = { '╓', '─', '╖', '║', '╜', '─', '╙', '║' }
-- M.borders = { '┯', '━', '┯', '│', '┷', '━', '┷', '│' }
-- M.borders = { '·', '─', '·', '│', '·', '─', '·', '│' }
-- M.borders = { '╏', '🮂', '╏', '╏', '╏', '▂', '╏', '╏' }
-- M.borders = { '┎', '─', '┒', '┃', '┚', '─', '┖', '┃' }
-- M.borders = { '┬', '─', '┬', '│', '┴', '─', '┴', '│' }
M.borders = "rounded"

local function startify_button(sc, txt, on_press)
	local keybind_opts = { noremap = true, silent = true, nowait = true }
	local opts = {
		position = "left",
		shortcut = "[" .. sc .. "] ",
		cursor = 1,
		-- width = 50,
		align_shortcut = "left",
		hl_shortcut = { { "Operator", 0, 1 }, { "Number", 1, #sc + 1 }, { "Operator", #sc + 1, #sc + 2 } },
		shrink_margin = false,
		keymap = { "n", sc, on_press, keybind_opts },
	}

	return {
		type = "button",
		val = txt,
		on_press = on_press,
		opts = opts,
	}
end

M.git_files = function()
	-- local key = vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true)
	-- vim.api.nvim_feedkeys(key, "t", false)
	-- version 1: uses files for both git and cwd
	-- See https://github.com/ibhagwan/fzf-lua/issues/140#issuecomment-920966786
	local opts = {}
	opts.cwd = require("fzf-lua.path").git_root(vim.uv.cwd(), true) or vim.uv.cwd()
	opts.fzf_cli_args = ('--header="cwd = %s"'):format(vim.fn.shellescape(opts.cwd))
	require("fzf-lua").files(opts)
end

-- Start up screen config
M.alpha_config = function()
	local alpha = require("alpha")
	local startify = require("alpha.themes.startify")

	startify.section.header.val = {
		"                                                     ",
		"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
		"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
		"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
		"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
		"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
		"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
		"                                                     ",
	}

	-- add margins to the top and left
	startify.opts.layout[1].val = 2
	startify.opts.opts.margin = 40

	-- disable MRU
	startify.section.mru.val = { { type = "padding", val = 0 } }
	-- Set menu
	startify.section.top_buttons.val = {
		startify.button("e", " > New File", "<cmd>ene<CR>"),
		-- startify.button("f", "󰈞 > Find File", "<cmd>Telescope find_files<CR>"),
		-- startify.button("f", "󰈞 > Find Files in Git repo", "<leader>gf"), -- use fzf which is faster
		startify_button("f", "󰈞 > Find Files in Git repo", M.git_files), -- use fzf which is faster
		startify.button("o", " > Recent Files", "<cmd>FzfLua oldfiles<CR>"),
		startify.button("g", "󱎸 > Live Grep", "<cmd>FzfLua live_grep<CR>"),
		startify.button("s", "󰪺 > Restore Session For Current Directory", "<cmd>SessionLoad<CR>"),
		startify.button("l", "󰖲 > Restore Last Session", "<cmd>SessionLoadLast<CR>"),
		startify.button("p", "󰖲 > Recent Sessions", "<cmd>Telescope persisted<CR>"),
		startify.button("t", "󰙅 > Toggle file explorer", "<cmd>Oil .<CR>"),
	}

	-- Send config to alpha
	alpha.setup(startify.config)

	-- Disable folding on alpha buffer
	vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
end

return M
