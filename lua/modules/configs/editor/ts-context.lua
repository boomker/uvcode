return function()
	local is_tmux_tui = vim.env.TMUX and not vim.g.neovide

	require("modules.utils").load_plugin("treesitter-context", {
		enable = not is_tmux_tui,
		line_numbers = true,
		max_lines = 3,
		min_window_height = 0,
		multiline_threshold = 20,
		trim_scope = "outer",
		mode = "cursor",
		-- Ensure compatibility with Glance's preview window
		zindex = 50,
	})
end
