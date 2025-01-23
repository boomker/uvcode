local completion = {}

completion["yetone/avante.nvim"] = {
	event = "VeryLazy",
	lazy = false,
	version = false, -- set this if you want to always pull the latest change
	build = "make BUILD_FROM_SOURCE=true",
	dependencies = {
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = require("user.configs.completion.avante"),
}

completion["saghen/blink.compat"] = {
	version = "*",
	-- lazy.nvim will automatically load the plugin when it's required by blink.cmp
	lazy = true,
	-- make sure to set opts so that lazy.nvim calls blink.compat's setup
	opts = {},
}

completion["saghen/blink.cmp"] = {
	-- use a release tag to download pre-built binaries
	version = "*",
	-- build = 'cargo build --release',
	opts_extend = { "sources.default" },
	config = require("user.configs.completion.blink-cmp"),
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			build = "make install_jsregexp",
			config = require("completion.luasnip"),
			dependencies = { "rafamadriz/friendly-snippets" },
		},
		{
			"Exafunction/codeium.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"MunifTanjim/nui.nvim",
			},
			config = require("user.configs.completion.codeium"),
		},
	},
}

-- === overwrite plugins config === --

completion["neovim/nvim-lspconfig"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("completion.lsp"),
	dependencies = {
		{ "saghen/blink.cmp" },
		{ "folke/neoconf.nvim" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{
			"Jint-lzxy/lsp_signature.nvim",
			config = require("completion.lsp-signature"),
		},
	},
}

completion["nvimtools/none-ls.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("user.configs.completion.null-ls"),
	dependencies = { "nvim-lua/plenary.nvim", "jay-babu/mason-null-ls.nvim" },
}

return completion
