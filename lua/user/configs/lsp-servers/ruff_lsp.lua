local util = require("lspconfig.util")

return {
	cmd = { "ruff-lsp" },
	filetypes = { "python" },
	root_dir = function(fname)
		return util.root_pattern("pyproject.toml", "ruff.toml")(fname)
			or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
	end,
	single_file_support = true,
	settings = {},
}
