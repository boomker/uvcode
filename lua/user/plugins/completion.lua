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

--[[
{
      "yetone/avante.nvim",
      event = "VeryLazy",
      lazy = false,
      version = false, -- set this if you want to always pull the latest change
}

completion["iurimateus/luasnip-latex-snippets.nvim"] = {
    lazy = true,
    ft = { "tex", "bib", "markdown" },
    config = require("configs.completion.luasnip-latex-snippets"),
}

]]

return completion
