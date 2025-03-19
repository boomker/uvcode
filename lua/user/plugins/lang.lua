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
		name = ".venv",
		auto_refresh = false,
	},
	branch = "regexp",
	event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
	keys = {
		{ "<leader>se", "<cmd>VenvSelect<cr>" },
		-- { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
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
