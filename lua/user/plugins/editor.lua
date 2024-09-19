local editor = {}

editor["danymat/neogen"] = {
	lazy = true,
	cmd = { "Neogen" },
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = require("user.configs.editor.neogen"),
}

editor["gbprod/yanky.nvim"] = {
	lazy = true,
	event = "VimEnter",
	config = require("user.configs.editor.yanky"),
	dependencies = { "kkharji/sqlite.lua" },
}

--  "cshuaimin/ssr.nvim"
editor["gbprod/substitute.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = require("user.configs.editor.substitute"),
}

editor["booperlv/nvim-gomove"] = {
	lazy = true,
	event = "BufRead",
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
				replace = "sr", -- Replace/change surrounding
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
	event = "VeryLazy",
	config = function()
		require("multiple-cursors").setup()
	end,
}

-- === overwrite plugins config -- ===
editor["sindrets/diffview.nvim"] = {
	lazy = true,
	cmd = { "DiffviewOpen", "DiffviewClose" },
	keys = {
		{ "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", desc = "git: File history" },
	},
	config = require("user.configs.editor.diffview"),
}

editor["m4xshen/autoclose.nvim"] = {
	lazy = true,
	event = "InsertEnter",
	config = require("user.configs.editor.autoclose"),
}

editor["folke/flash.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("user.configs.editor.flash"),
}

--[[
editor["smoka7/hop.nvim"] = {
	lazy = true,
	version = "*",
	event = { "CursorHold", "CursorHoldI" },
	config = require("user.configs.editor.hop"),
}
]]

return editor
