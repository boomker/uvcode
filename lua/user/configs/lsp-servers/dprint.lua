local util = require("lspconfig.util")

return {
	cmd = { "dprint", "lsp" },
	filetypes = {
		"yml",
		"yaml",
		"toml",
		"json",
		"jsonc",
		"graphql",
        "markdown",
		"javascript",
		"typescript",
        "javascriptreact",
		"typescriptreact",
	},
	root_dir = util.root_pattern("dprint.json", ".dprint.json", "dprint.jsonc", ".dprint.jsonc"),
	single_file_support = true,
	settings = {},
}
