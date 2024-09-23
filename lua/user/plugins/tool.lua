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
	config = require("user.configs.tool.nvim-ufo"),
	dependencies = { { "kevinhwang91/promise-async", lazy = true } },
}

tool["kevinhwang91/nvim-hlslens"] = {
	lazy = true,
	event = "SearchWrapped",
	config = require("user.configs.tool.nvim-hlslens"),
}

tool["chentoast/marks.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = require("user.configs.tool.marks"),
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

-- Open files and command output from neovim terminals in your current neovim instance
tool["willothy/flatten.nvim"] = {
	lazy = false,
	-- event = "VeryLazy",
	config = require("user.configs.tool.flatten"),
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

tool["smjonas/inc-rename.nvim"] = {
	lazy = true,
	event = "LspAttach",
	config = function()
		vim.keymap.set("n", "<leader>rN", function()
			return ":IncRename " .. vim.fn.expand("<cword>")
		end, { expr = true })
		require("inc_rename").setup({
			input_buffer_type = "dressing",
		})
	end,
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
	config = require("user.configs.tool.neo-tree"),
}

-- === overwrite plugins config -- ===

tool["folke/which-key.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("user.configs.tool.which-key"),
}

tool["akinsho/toggleterm.nvim"] = {
	lazy = true,
	cmd = {
		"ToggleTerm",
		"ToggleTermSetName",
		"ToggleTermToggleAll",
		"ToggleTermSendVisualLines",
		"ToggleTermSendCurrentLine",
		"ToggleTermSendVisualSelection",
	},
	config = require("user.configs.tool.toggleterm"),
}

tool["nvim-tree/nvim-tree.lua"] = {
	lazy = true,
	cmd = {
		"NvimTreeToggle",
		"NvimTreeOpen",
		"NvimTreeFindFile",
		"NvimTreeFindFileToggle",
		"NvimTreeRefresh",
	},
	config = require("user.configs.tool.nvim-tree"),
}

tool["nvim-telescope/telescope.nvim"] = {
	lazy = true,
	cmd = "Telescope",
	config = require("user.configs.tool.telescope"),
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-tree/nvim-web-devicons" },
		{ "jvgrootveld/telescope-zoxide" },
		{ "debugloop/telescope-undo.nvim" },
		{ "jonarrien/telescope-cmdline.nvim" },
		{ "nvim-telescope/telescope-frecency.nvim" },
		{ "nvim-telescope/telescope-live-grep-args.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{
			"FabianWirth/search.nvim",
			config = require("user.configs.tool.search"),
		},
		{
			"ahmedkhalf/project.nvim",
			event = { "CursorHold", "CursorHoldI" },
			config = require("tool.project"),
		},
		{
			"aaronhallaert/advanced-git-search.nvim",
			cmd = { "AdvancedGitSearch" },
			dependencies = {
				"tpope/vim-rhubarb",
				"tpope/vim-fugitive",
				"sindrets/diffview.nvim",
			},
		},
	},
}

--[[
tool["zeioth/garbage-day.nvim"] = {
	lazy = true,
	event = "LspAttach",
}

tool["numToStr/Navigator.nvim"] = {
	lazy = true,
	event = "VeryLazy",
	config = require("user.configs.tool.navigator"),
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
	config = require("user.configs.tool.remote-nvim"),
}
--]]

return tool
