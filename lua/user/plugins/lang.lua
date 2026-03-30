local lang = {}

lang["barrett-ruth/live-server.nvim"] = {
	lazy = true,
	config = true,
	ft = { "html", "markdown" },
	build = "pnpm add -g live-server",
	cmd = { "LiveServerStart", "LiveServerStop" },
}

lang["bezhermoso/tree-sitter-ghostty"] = {
	build = "make nvim_install",
	ft = "ghostty",
}

lang["linux-cultist/venv-selector.nvim"] = {
	opts = {
		options = {
			enable_default_searches = false,
		},
		search = {
			cwd_venvs = {
				command = "/opt/homebrew/bin/fd '/bin/python$' '$CWD' --full-path --color never",
			},
			ws_venvs = {
				command = "/opt/homebrew/bin/fd '/bin/python$' '$WORKSPACE_PATH' --full-path --color never",
			},
		},
	},
	ft = "python", -- Load when opening Python files
	keys = {
		{ "<leader>se", "<cmd>VenvSelect<cr>", desc = "Select venv" },
	},
	dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
}

-- === overwrite plugins config -- ===

lang["MeanderingProgrammer/render-markdown.nvim"] = {
	lazy = true,
	ft = { "markdown", "Avante" },
	config = require("lang.render-markdown"),
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-treesitter/nvim-treesitter",
	},
}

return lang
