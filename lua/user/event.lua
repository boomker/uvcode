local definitions = {
	-- Example
	bufs = {
        { "BufEnter", "*", "silent! lcd %:p:h"},
		{ "FileType", "markdown,tex,bib", "set wrap" },
		{ "BufWritePre", "COMMIT_EDITMSG", "setlocal noundofile" },
	},
}

return definitions
