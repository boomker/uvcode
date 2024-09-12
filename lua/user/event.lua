vim.api.nvim_create_augroup("StickyBuf", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = "StickyBuf",
	pattern = "*",
	callback = function()
		local filetypes = { "neo-tree", "NvimTree", "toggleterm", "OverseerList" }
		local buftypes = { "man", "help", "terminal", "toggleterm" } -- "nofile",
		if vim.tbl_contains(buftypes, vim.bo.buftype) and vim.tbl_contains(filetypes, vim.bo.filetype) then
			vim.cmd("set winfixbuf")
		end
	end,
})

local definitions = {
	bufs = {
		{ "BufEnter", "*", "silent! lcd %:p:h" },
		{ "FileType", "markdown,tex,bib", "set wrap" },
		{ "BufWritePre", "COMMIT_EDITMSG", "setlocal noundofile" },
	},
}

return definitions
