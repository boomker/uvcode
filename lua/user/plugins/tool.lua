local tool = {}

tool["stevearc/dressing.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = function()
		require("dressing").setup({})
	end,
}

tool["m-demare/hlargs.nvim"] = {
	lazy = true,
	event = "BufRead",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = function()
		require("hlargs").setup({})
	end,
}

tool["kevinhwang91/nvim-ufo"] = {
	lazy = true,
	event = "BufRead",
	config = require("configs.tool.nvim-ufo"),
	dependencies = { { "kevinhwang91/promise-async", lazy = true } },
}

tool["kevinhwang91/nvim-hlslens"] = {
	lazy = true,
	event = "SearchWrapped",
	config = require("configs.tool.nvim-hlslens"),
}

tool["chentoast/marks.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = require("configs.tool.marks"),
}

-- [ + upper-suffix : go first.
-- [ + lower-suffix : go backward.
-- ] + lower-suffix : go forward.
-- ] + upper-suffix : go last.
tool["echasnovski/mini.bracketed"] = {
	version = false,
	config = function()
		require("mini.bracketed").setup({
			comment = { suffix = "a", options = {} },
			oldfile = { suffix = "r", options = {} },
			file = { suffix = "v", options = {} },
		})
	end,
}

tool["echasnovski/mini.bufremove"] = {
	lazy = true,
	version = false,
	event = { "VeryLazy" },
	config = function()
		require("mini.bufremove").setup()
	end,
}

tool["willothy/flatten.nvim"] = {
	lazy = false,
	-- event = "VeryLazy",
	config = require("configs.tool.flatten"),
}

tool["LintaoAmons/scratch.nvim"] = {
	lazy = true,
	event = "VeryLazy",
	config = function()
		require("scratch").setup({
			use_telescope = true,
			file_picker = "telescope", -- "fzflua" | "telescope" | nil
			filetypes = {
				"sh",
				"py",
				"js",
				"go",
				"lua",
				"awk",
				"html",
				"json",
				"toml",
				"yaml",
			},
		})
	end,
}

tool["ThePrimeagen/refactoring.nvim"] = {
	lazy = true,
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("refactoring").setup()
	end,
}

--[[
tool["numToStr/Navigator.nvim"] = {
	lazy = true,
	event = "VeryLazy",
	config = require("configs.tool.navigator"),
}

tool["amitds1997/remote-nvim.nvim"] = {
	lazy = true,
	cmd = { "RemoteStart", "RemoteStop", "RemoteInfo", "RemoteCleanup", "RemoteConfigDel", "RemoteLog" },
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim", -- For standard functions
		"MunifTanjim/nui.nvim", -- To build the plugin UI
		"nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
	},
	config = require("configs.tool.remote-nvim"),
}

tool["nvim-neo-tree/neo-tree.nvim"] = {
	lazy = true,
	cmd = {
		"Neotree",
	},
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim",
	},
	config = require("configs.tool.neo-tree"),
}

]]

return tool
