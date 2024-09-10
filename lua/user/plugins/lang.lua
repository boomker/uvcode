local utils = require("core.utils")
local _, _venvs_path = utils.git_proj_root()

local lang = {}

lang["barrett-ruth/live-server.nvim"] = {
	lazy = true,
	ft = { "html", "markdown" },
	build = "pnpm add -g live-server",
	cmd = { "LiveServerStart", "LiveServerStop" },
	config = true,
}

lang["AckslD/swenv.nvim"] = {
	lazy = true,
	ft = "python",
	event = { "BufRead", "BufNew" },
	config = function()
		require("swenv").setup({
			venvs_path = vim.fn.expand(_venvs_path .. '/.venv'),
			get_venvs = function(venvs_path)
				return require("swenv.api").get_venvs(venvs_path)
			end,
			post_set_venv = function()
				vim.cmd("LspRestart")
			end,
		})
	end,
	dependencies = { "nvim-lua/plenary.nvim" },
}

return lang
