vim.api.nvim_create_augroup("StickyBuf", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = "StickyBuf",
	pattern = "*",
	callback = function()
		local buftypes = { "nofile", "man", "help", "terminal", "toggleterm" }
		local filetypes = { "neo-tree", "NvimTree", "toggleterm", "OverseerList" }
		if vim.tbl_contains(buftypes, vim.bo.buftype) and vim.tbl_contains(filetypes, vim.bo.filetype) then
			vim.opt_local.winfixbuf = true
		end
	end,
})

vim.api.nvim_create_augroup("Exit", { clear = true })
vim.api.nvim_create_autocmd("ExitPre", {
	group = "Exit",
	command = "set guicursor=a:ver90",
	desc = "Set cursor back to beam when leaving Neovim.",
})

vim.api.nvim_create_user_command("ClearRegisters", function()
	for i = string.byte("a"), string.byte("z") do
		vim.fn.setreg(string.char(i), "")
	end
end, {})

local definitions = {
	bufs = {
		{ "BufEnter", "*", "silent! lcd %:p:h" },
		{ "FileType", "markdown,tex,bib", "set wrap" },
		{ "BufWritePre", "COMMIT_EDITMSG", "setlocal noundofile" },
	},
}

return definitions
