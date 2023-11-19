local editor = {}

editor["rainbowhxch/accelerated-jk.nvim"] = {
	lazy = true,
	event = "VeryLazy",
	config = require("editor.accelerated-jk"),
}
editor["olimorris/persisted.nvim"] = {
	lazy = true,
	cmd = {
		"SessionToggle",
		"SessionStart",
		"SessionStop",
		"SessionSave",
		"SessionLoad",
		"SessionLoadLast",
		"SessionLoadFromFile",
		"SessionDelete",
	},
	config = require("editor.persisted"),
}
editor["m4xshen/autoclose.nvim"] = {
	lazy = true,
	event = "InsertEnter",
	config = require("editor.autoclose"),
}
editor["max397574/better-escape.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.better-escape"),
}
editor["LunarVim/bigfile.nvim"] = {
	lazy = false,
	config = require("editor.bigfile"),
	cond = require("core.settings").load_big_files_faster,
}

--[[ editor["rhysd/clever-f.vim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.cleverf"),
} ]]

editor["numToStr/Comment.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.comment"),
}
editor["sindrets/diffview.nvim"] = {
	lazy = true,
	cmd = { "DiffviewOpen", "DiffviewClose" },
	config = require("editor.diffview"),
}

editor["echasnovski/mini.align"] = {
	lazy = true,
	version = false,
	event = { "VeryLazy" },
	config = function()
		require("mini.align").setup()
	end,
}

editor["echasnovski/mini.surround"] = {
	lazy = true,
	version = false,
	event = { "VeryLazy" },
	config = function()
		require("mini.surround").setup({
			mappings = {
				add            = "sm", -- Add surrounding `mark` in Normal and Visual modes
				delete         = "sd", -- Delete surrounding
                replace        = "sc", -- Replace/change surrounding
				find           = "sf", -- Find surrounding (to the right)
				find_left      = "sF", -- Find surrounding (to the left)
				highlight      = "sh", -- Highlight surrounding
				update_n_lines = "sn", -- Update `n_lines`
			},
		})
	end,
}

editor["echasnovski/mini.bracketed"] = {
    version = false,
    config = function()
        require("mini.bracketed").setup({
            comment    = { suffix = 'a', options = {} },
            diagnostic = { suffix = 'e' },
            file       = { suffix = 'v', options = {} },
        })
    end,
}

editor["echasnovski/mini.bufremove"] = {
	lazy = true,
	version = false,
	event = { "VeryLazy" },
	config = function()
		require("mini.bufremove").setup()
	end,
}

editor["smoka7/hop.nvim"] = {
	lazy = true,
	version = "*",
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.hop"),
}

editor["folke/flash.nvim"] = {
	lazy = true,
	event = "VeryLazy",
    keys = function() return {} end,
	config = require("editor.flash"),
}

editor["RRethy/vim-illuminate"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.vim-illuminate"),
}

--[[ editor["romainl/vim-cool"] = {
	lazy = true,
	event = { "CursorMoved", "InsertEnter" },
} ]]

----------------------------------------------------------------------
--                  :treesitter related plugins                    --
----------------------------------------------------------------------
editor["nvim-treesitter/nvim-treesitter"] = {
	lazy = true,
	build = function()
		if #vim.api.nvim_list_uis() ~= 0 then
			vim.api.nvim_command([[TSUpdate]])
		end
	end,
	event = "BufReadPre",
	config = require("editor.treesitter"),
	dependencies = {
		{ "andymass/vim-matchup" },
		{ "mfussenegger/nvim-treehopper" },
		{ "nvim-treesitter/nvim-treesitter-textobjects" },
		{
			"abecodes/tabout.nvim",
			config = require("editor.tabout"),
		},
		{
			"windwp/nvim-ts-autotag",
			config = require("editor.autotag"),
		},
		{
			"NvChad/nvim-colorizer.lua",
			config = require("editor.colorizer"),
		},
		{
			"hiphish/rainbow-delimiters.nvim",
			config = require("editor.rainbow_delims"),
		},
		{
			"nvim-treesitter/nvim-treesitter-context",
			config = require("editor.ts-context"),
		},
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			config = require("editor.ts-context-commentstring"),
		},
	},
}

return editor
