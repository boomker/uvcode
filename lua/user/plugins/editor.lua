local editor = {}

editor["danymat/neogen"] = {
	lazy = true,
	cmd = { "Neogen" },
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = require("configs.editor.neogen"),
}

editor["gbprod/yanky.nvim"] = {
	lazy = true,
	event = "VimEnter",
	config = require("configs.editor.yanky"),
	dependencies = { "kkharji/sqlite.lua" },
}

editor["gbprod/substitute.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = require("configs.editor.substitute"),
}

editor["booperlv/nvim-gomove"] = {
	lazy = true,
	event = "BufRead",
}

editor["rmagatti/alternate-toggler"] = {
	lazy = true,
	event = "BufReadPost",
	config = function()
		require("alternate-toggler").setup({
			alternates = {
				["yes"] = "no",
				["<="] = ">=",
				["=="] = "!=",
				["~="] = "==",
				['"""'] = "'''",
			},
		})
	end,
}

editor["echasnovski/mini.surround"] = {
	lazy = true,
	version = false,
	event = { "VeryLazy" },
	config = function()
		require("mini.surround").setup({
			mappings = {
				add = "sm", -- Add surrounding `mark` in Normal and Visual modes
				delete = "sd", -- Delete surrounding
				replace = "sc", -- Replace/change surrounding
				find = "sf", -- Find surrounding (to the right)
				find_left = "sF", -- Find surrounding (to the left)
				highlight = "sh", -- Highlight surrounding
				update_n_lines = "sn", -- Update `n_lines`
			},
		})
	end,
}

-- "smoka7/multicursors.nvim"
editor["brenton-leighton/multiple-cursors.nvim"] = {
	lazy = true,
	version = "*",
	event = "BufRead",
	config = function()
		require("multiple-cursors").setup()
	end,
}

return editor
