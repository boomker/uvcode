return function()
	require("swenv").setup({
		venvs_path = vim.fn.expand("~/.venvs/"),
		get_venvs = function(venvs_path)
			return require("swenv.api").get_venvs(venvs_path)
		end,
		post_set_venv = function()
			vim.cmd("LspRestart")
		end,
	})
end
