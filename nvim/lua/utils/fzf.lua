local M = {}

-- The reason I added  'opts' as a paraameter is so you can
-- call this function with your own parameters / customizations
-- for example: 'git_files_cwd_aware({ cwd = <another git repo> })'
function M.git_files_cwd_aware(opts)
	opts = opts or {}
	local fzf_lua = require("fzf-lua")
	-- git_root() will warn us if we're not inside a git repo
	-- so we don't have to add another warning here, if
	-- you want to avoid the error message change it to:
	-- local git_root = fzf_lua.path.git_root(opts, true)
	local git_root = fzf_lua.path.git_root(opts)
	if not git_root then
		return
	end
	local relative = fzf_lua.path.relative_to(vim.loop.cwd(), git_root)
	opts.fzf_opts = { ["--query"] = git_root ~= relative and relative or nil }
	return fzf_lua.git_files(opts)
end

function M.files_git_or_cwd(opts)
	-- version 2: uses `git ls-files` for git dirs
	-- change to `false` if you'd like to see a message when not in a git repo
	if require("fzf-lua.path").is_git_repo(vim.loop.cwd(), true) then
		M.git_files_cwd_aware(opts)
	else
		require("fzf-lua").files(opts)
	end
end

M.git_files_or_cwd = function(opts)
	-- version 1: uses files for both git and cwd
	-- See https://github.com/ibhagwan/fzf-lua/issues/140#issuecomment-920966786
	opts = opts or {}
	opts.cwd = require("fzf-lua.path").git_root(vim.loop.cwd(), true) or vim.loop.cwd()
	opts.fzf_cli_args = ('--header="cwd = %s"'):format(vim.fn.shellescape(opts.cwd))
	require("fzf-lua").files(opts)
end

return M
