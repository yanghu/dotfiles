local aucmd = vim.api.nvim_create_autocmd
local function augroup(name, func)
	func(vim.api.nvim_create_augroup(name, { clear = true }))
end

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
aucmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Switch to relative number mode in normal mode.
augroup("NumberToggle", function(g)
	aucmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
		pattern = "*",
		group = g,
		callback = function()
			if vim.opt.number:get() then
				vim.opt.relativenumber = true
			end
		end,
	})
	aucmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
		pattern = "*",
		group = g,
		callback = function()
			vim.opt.relativenumber = false
		end,
	})
end)

-- Check if we need to reload the file when it changed
augroup("checktime", function(g)
	aucmd({ "TermLeave", "FocusGained", "TermClose" }, {
		pattern = "*",
		group = g,
		callback = function()
			if vim.o.buftype ~= "nofile" then
				vim.cmd("checktime")
			end
		end,
	})
end)

-- close some filetypes with <q>, and hide line numbers
augroup("close_with_q", function(g)
	aucmd("FileType", {
		pattern = {
			"PlenaryTestPopup",
			"aerial",
			"floggraph",
			"help",
			"lspinfo",
			"netrw",
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
		callback = function(event)
			vim.bo[event.buf].buflisted = false
			vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
			vim.opt_local.number = false
			vim.opt_local.relativenumber = false
			vim.b.miniindentscope_disable = true
		end,
	})
end)

-- Wrap and check for spell in text files
augroup("wrap_spell_text", function(g)
	aucmd("FileType", {
		pattern = {
			"gitcommit",
			-- Do not wrap markdown, as we always format it within 80 columns.
			-- "markdown",
		},
		group = g,
		callback = function()
			vim.opt_local.wrap = true
			vim.opt_local.spell = true
		end,
	})
end)

-- Auto create dir when saving a file, in case some intermediate directory does not exist
augroup("auto_create_dir", function(g)
	aucmd("BufWritePre", {
		pattern = "*",
		group = g,
		callback = function(event)
			if event.match:match("^%w%w+:[\\/][\\/]") then
				return
			end
			local file = vim.uv.fs_realpath(event.match) or event.match
			vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
		end,
	})
end)

--  source: https://github.com/ibhagwan/nvim-lua/blob/b2b15c1304558bff54fddaf03265b3cc700c4164/lua/autocmd.lua#L111
--  Automatically toggle search HL. See also https://www.reddit.com/r/neovim/comments/1ct2w2h/lua_adaptation_of_vimcool_auto_nohlsearch/
augroup("ibhagwan/ToggleSearchHL", function(g)
	aucmd("InsertEnter", {
		group = g,
		callback = function()
			vim.schedule(function()
				vim.cmd("nohlsearch")
			end)
		end,
	})
	aucmd("CursorMoved", {
		group = g,
		callback = function()
			-- No bloat lua adpatation of: https://github.com/romainl/vim-cool
			local view, rpos = vim.fn.winsaveview(), vim.fn.getpos(".")
			assert(view.lnum == rpos[2])
			assert(view.col + 1 == rpos[3])
			-- Move the cursor to a position where (whereas in active search) pressing `n`
			-- brings us to the original cursor position, in a forward search / that means
			-- one column before the match, in a backward search ? we move one col forward
			vim.cmd(
				string.format(
					"silent! keepjumps go%s",
					(vim.fn.line2byte(view.lnum) + view.col + 1 - (vim.v.searchforward == 1 and 2 or 0))
				)
			)
			-- Attempt to goto next match, if we're in an active search cursor position
			-- should be equal to original cursor position
			local ok, _ = pcall(vim.cmd, "silent! keepjumps norm! n")
			local insearch = ok
				and (function()
					local npos = vim.fn.getpos(".")
					return npos[2] == rpos[2] and npos[3] == rpos[3]
				end)()
			-- restore original view and position
			vim.fn.winrestview(view)
			if not insearch then
				vim.schedule(function()
					vim.cmd("nohlsearch")
				end)
			end
		end,
	})
end)
