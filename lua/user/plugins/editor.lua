local editor = {}

editor["danymat/neogen"] = {
	lazy = true,
	cmd = { "Neogen" },
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = require("user.configs.editor.neogen"),
}

editor["gbprod/yanky.nvim"] = {
	lazy = true,
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	config = require("user.configs.editor.yanky"),
	dependencies = { "kkharji/sqlite.lua" },
}

--  "cshuaimin/ssr.nvim"
editor["gbprod/substitute.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = require("user.configs.editor.substitute"),
}

editor["fedepujol/move.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = function()
		require("move").setup()
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
				replace = "sr", -- Replace/change surrounding
				find = "sf", -- Find surrounding (to the right)
				find_left = "sF", -- Find surrounding (to the left)
				highlight = "sh", -- Highlight surrounding
				update_n_lines = "sn", -- Update `n_lines`
				suffix_last = "l", -- Suffix to search with "prev" method
				suffix_next = "n", -- Suffix to search with "next" method
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
	keys = {
		{ "gsb", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "x" }, desc = "Add cursor and move down" },
		{ "gsB", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "x" }, desc = "Add cursor and move up" },
		{ "gsL", "<Cmd>MultipleCursorsLock<CR>", mode = { "n", "x" }, desc = "Lock virtual cursors" },

		-- {"<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = {"n", "i", "x"}, desc = "Add cursor and move up"},
		-- {"<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = {"n", "i", "x"}, desc = "Add cursor and move down"},

		-- {"<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = {"n", "i"}, desc = "Add or remove cursor"},

		-- {"<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", mode = {"n", "x"}, desc = "Add cursors to cword"},
		-- {"<Leader>A", "<Cmd>MultipleCursorsAddMatchesV<CR>", mode = {"n", "x"}, desc = "Add cursors to cword in previous area"},

		-- {"<Leader>d", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = {"n", "x"}, desc = "Add cursor and jump to next cword"},
		-- {"<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>", mode = {"n", "x"}, desc = "Jump to next cword"},
	},
}

-- === overwrite plugins config -- ===
editor["sindrets/diffview.nvim"] = {
	lazy = true,
	cmd = { "DiffviewOpen", "DiffviewClose" },
	keys = {},
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
