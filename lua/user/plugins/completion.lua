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
completion["zeioth/garbage-day.nvim"] = {
    lazy = true,
    event = "LspAttach",
}

completion["iurimateus/luasnip-latex-snippets.nvim"] = {
    lazy = true,
    ft = { "tex", "bib", "markdown" },
    config = require("configs.completion.luasnip-latex-snippets"),
}

completion["hrsh7th/cmp-cmdline"] = {
	lazy = true,
	event = { "InsertEnter" },
	dependencies = { "hrsh7th/nvim-cmp" },
	opts = function()
		local cmp = require("cmp")
		return {
			{
				type = "/",
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			},
			{
				type = ":",
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			},
		}
	end,
	config = function(_, opts)
		local cmp = require("cmp")
		vim.tbl_map(function(val)
			cmp.setup.cmdline(val.type, val)
		end, opts)
	end,
}
]]

return completion
