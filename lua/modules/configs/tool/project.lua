return function()
	require("modules.utils").load_plugin("project", {
		manual_mode = false,
		patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
		lsp = {
			enabled = true, ---@type boolean
			-- ignore = {}, ---@type string[]
			ignore = { "null-ls", "copilot" },
			use_pattern_matching = false, ---@type boolean
			-- WARNING: USE AT YOUR OWN DISCRETION!!!!
			no_fallback = false, ---@type boolean
		},
		exclude_dirs = {},
		show_hidden = false,
		silent_chdir = true,
		scope_chdir = "global",
		datapath = vim.fn.stdpath("data"),
	})
end
