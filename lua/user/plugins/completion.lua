local completion = {}

completion["Exafunction/codeium.nvim"] = {
	lazy = true,
	event = { "InsertEnter" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"hrsh7th/nvim-cmp",
	},
	config = require("user.configs.completion.codeium"),
}

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

completion["saghen/blink.cmp"] = {
	dependencies = "rafamadriz/friendly-snippets",

	-- use a release tag to download pre-built binaries
	version = "*",
	-- AND/OR build from source
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',
	opts_extend = { "sources.default" },
	config = require("user.configs.completion.blink-cmp"),
}
-- === overwrite plugins config -- ===

completion["nvimtools/none-ls.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("user.configs.completion.null-ls"),
	dependencies = { "nvim-lua/plenary.nvim", "jay-babu/mason-null-ls.nvim" },
}

--[[
completion["iurimateus/luasnip-latex-snippets.nvim"] = {
    lazy = true,
    ft = { "tex", "bib", "markdown" },
    config = require("configs.completion.luasnip-latex-snippets"),
}

completion["stevearc/aerial.nvim"] = {
	lazy = true,
	event = "LspAttach",
	config = require("user.configs.completion.aerial"),
}

]]

return completion
