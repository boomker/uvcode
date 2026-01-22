--[[ local util = require("lspconfig.util")

return {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_dir = function(fname)
		return util.root_pattern("pyproject.toml", "ruff.toml", ".ruff.toml")(fname)
		-- or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
	end,
	single_file_support = true,
	settings = {},
} ]]
-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/ruff.lua
return {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },

	-- the following are added by nvimdots
	settings = {
		init_options = {
			settings = {
				lint = {
					select = {
						-- enable: pycodestyle
						"E",
						-- enable: pyflakes
						"F",
					},
					extendSelect = {
						-- enable: isort
						"I",
					},
					-- the same line length as black
					lineLength = 88,
				},
				configurationPreference = "filesystemFirst",
			},
		},
	},
}
