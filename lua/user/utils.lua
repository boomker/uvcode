local M = {}

M.table_maxn = function(t)
	local mn = nil
	for _, v in pairs(t) do
		if mn == nil then
			mn = v
		end
		if mn < v then
			mn = v
		end
	end
	return mn
end

M.git_proj_root = function()
	local cwd = vim.fn.expand("%:p:h")
	vim.fn.system("git rev-parse --is-inside-work-tree")
	if vim.v.shell_error == 0 then
		local cmd = "git -C " .. cwd .. " rev-parse --show-toplevel"
		local output = vim.fn.systemlist(cmd)
		return true, output[1]
	end
	return false, cwd
end

return M
