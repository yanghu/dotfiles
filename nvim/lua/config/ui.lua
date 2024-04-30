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
	startify.opts.opts.margin = 45

	-- disable MRU
	startify.section.mru.val = { { type = "padding", val = 0 } }
	-- Set menu
	startify.section.top_buttons.val = {
		startify.button("e", " > New File", "<cmd>ene<CR>"),
		startify.button("f", "󰈞 > Find File", "<cmd>Telescope find_files<CR>"),
		startify.button("o", " > Recent Files", "<cmd>Telescope oldfiles<CR>"),
		startify.button("g", "󱎸 > Live Grep", "<cmd>Telescope live_grep<CR>"),
		startify.button("s", "󰪺 > Restore Session For Current Directory", "<cmd>SessionLoad<CR>"),
		startify.button("l", "󰖲 > Restore Last Session", "<cmd>SessionLoadLast<CR>"),
		startify.button("p", "󰖲 > Recent Sessions", "<cmd>Telescope persisted<CR>"),
		startify.button("t", "󰙅 > Toggle file explorer", "<cmd>Neotree toggle current reveal_force_cwd<CR>"),
	}

	-- Send config to alpha
	alpha.setup(startify.config)

	-- Disable folding on alpha buffer
	vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
end

return M
