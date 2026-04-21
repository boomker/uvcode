return function()
	local is_tmux_tui = vim.env.TMUX and not vim.g.neovide

	vim.g.matchup_transmute_enabled = 1
	vim.g.matchup_surround_enabled = 1
	vim.g.matchup_matchparen_offscreen = { method = "popup" }
	vim.g.matchup_treesitter_enabled = not is_tmux_tui
end
