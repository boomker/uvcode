local tool = {}

-- tool["numToStr/Navigator.nvim"] = {
-- 	lazy = true,
-- 	event = "VeryLazy",
-- 	config = require("configs.tool.navigator"),
-- }

-- tool["amitds1997/remote-nvim.nvim"] = {
-- 	lazy = true,
-- 	cmd = { "RemoteStart", "RemoteStop", "RemoteInfo", "RemoteCleanup", "RemoteConfigDel", "RemoteLog" },
-- 	version = "*",
-- 	dependencies = {
-- 		"nvim-lua/plenary.nvim", -- For standard functions
-- 		"MunifTanjim/nui.nvim", -- To build the plugin UI
-- 		"nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
-- 	},
-- 	-- config = true,
-- 	config = require("configs.tool.remote-nvim"),
-- }

tool["nvim-neo-tree/neo-tree.nvim"] = {
	lazy = true,
	cmd = {
		"Neotree",
	},
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = require("configs.tool.neo-tree"),
}

tool["ThePrimeagen/refactoring.nvim"] = {
	lazy = true,
	envet = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("refactoring").setup()
	end,
}

tool["kevinhwang91/nvim-ufo"] = {
	lazy = true,
	event = "BufRead",
	config = require("configs.tool.nvim-ufo"),
	dependencies = { { "kevinhwang91/promise-async", lazy = true } },
}

tool["kevinhwang91/nvim-bqf"] = {
	lazy = true,
	ft = "qf",
	config = require("configs.tool.nvim-bqf"),
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
		{
			"junegunn/fzf",
			build = function()
				vim.fn["fzf#install"]()
			end,
		},
	},
}

tool["LintaoAmons/scratch.nvim"] = {
	lazy = true,
	event = "BufRead",
}

tool["AckslD/swenv.nvim"] = {
	lazy = true,
	ft = "python",
	event = { "BufRead", "BufNew" },
	config = function()
		require("swenv").setup({
			venvs_path = vim.fn.expand("/usr/local/opt/pyenv/versions/3.12.2/envs"),
			get_venvs = function(venvs_path)
				return require("swenv.api").get_venvs(venvs_path)
			end,
			post_set_venv = function()
				vim.cmd("LspRestart")
			end,
		})
	end,
	dependencies = { "nvim-lua/plenary.nvim" },
}

return tool
