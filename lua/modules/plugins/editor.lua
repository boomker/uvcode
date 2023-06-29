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
editor["ojroques/nvim-bufdel"] = {
	lazy = true,
	event = "BufReadPost",
}

--[[ editor["rhysd/clever-f.vim"] = {
	lazy = true,
	event = { "BufReadPost", "BufAdd", "BufNewFile" },
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
				find           = "", -- Find surrounding (to the right)
				find_left      = "", -- Find surrounding (to the left)
				highlight      = "", -- Highlight surrounding
				update_n_lines = "sN", -- Update `n_lines`
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

editor["phaazon/hop.nvim"] = {
	lazy = true,
	branch = "v2",
	event = "BufReadPost",
	config = require("editor.hop"),
}

editor["RRethy/vim-illuminate"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.vim-illuminate"),
}

--[[ editor["luukvbaal/stabilize.nvim"] = {
	lazy = true,
	event = "BufReadPost",
} ]]
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
			vim.api.nvim_command("TSUpdate")
		end
	end,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.treesitter"),
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects" },
		{ "mrjones2014/nvim-ts-rainbow" },
		{ "JoosepAlviste/nvim-ts-context-commentstring" },
		{ "mfussenegger/nvim-treehopper" },
		{ "andymass/vim-matchup" },
		{
			"nvim-treesitter/nvim-treesitter-context",
			config = require("editor.ts-context"),
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
			"abecodes/tabout.nvim",
			config = require("editor.tabout"),
		},
	},
}

return editor
