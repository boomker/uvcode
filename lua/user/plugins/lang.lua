local lang = {}

lang["barrett-ruth/live-server.nvim"] = {
	lazy = true,
	ft = { "html", "markdown" },
	build = "pnpm add -g live-server",
	cmd = { "LiveServerStart", "LiveServerStop" },
	config = true,
}

return lang
