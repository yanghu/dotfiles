local M = {}

function M.at_work()
	return vim.env.ATWORK == 1
end

return M
