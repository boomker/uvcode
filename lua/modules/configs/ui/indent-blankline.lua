return function()
	vim.opt.termguicolors = true

	vim.api.nvim_command([[highlight IndentBlanklineChar guifg=#6e6c7e gui=nocombine]])
    vim.cmd([[highlight IndentBlanklineContextChar guifg=#C678DD  gui=nocombine]])
	vim.cmd([[highlight IndentBlanklineContextStart guisp=#C678DD gui=underline]])

	require("indent_blankline").setup({

		char = "│",
		show_first_indent_level = true,
		filetype_exclude = {
			"", -- for all buffers without a file type
			"NvimTree",
			"TelescopePrompt",
			"dashboard",
			"dotooagenda",
			"flutterToolsOutline",
			"fugitive",
			"git",
			"gitcommit",
			"help",
			"json",
			"log",
			"markdown",
			"peekaboo",
			"startify",
			"todoist",
			"txt",
			"vimwiki",
			"vista",
		},
		buftype_exclude = { "terminal", "nofile" },
		show_trailing_blankline_indent = false,
		show_current_context = true,
		show_current_context_start = true,
		context_patterns = {
			"^if",
			"^table",
			"block",
			"class",
			"for",
			"function",
			"if_statement",
			"import",
			"list_literal",
			"method",
			"selector",
			"type",
			"var",
			"while",
		},
		space_char_blankline = " ",
	})
end
