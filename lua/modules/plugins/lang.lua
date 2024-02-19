local lang = {}

--[[ lang["kevinhwang91/nvim-bqf"] = {
	lazy = true,
	ft = "qf",
	config = require("lang.bqf"),
	dependencies = {
		{ "junegunn/fzf", build = ":call fzf#install()" },
	},
}

lang["AckslD/swenv.nvim"] = {
	lazy = true,
	ft = "python",
	config = function()
		require("swenv").setup({
			get_venvs = function(venvs_path)
				return require("swenv.api").get_venvs(venvs_path)
			end,
			venvs_path = {
                dva = vim.fn.expand("~/gitrepos/django-vue-admin/backend/.venv"),
            },
			post_set_venv = nil,
		})
	end,
	dependencies = { "nvim-lua/plenary.nvim" },
} ]]

lang["ray-x/go.nvim"] = {
	lazy = true,
	ft = "go",
	-- run = ":GoInstallBinaries",
	config = require("lang.vim-go"),
}
--[[
lang["mrcjkb/rustaceanvim"] = {
	lazy = true,
	ft = "rust",
	version = "^3",
	config = require("lang.rust"),
	dependencies = { "nvim-lua/plenary.nvim" },
}

lang["Saecki/crates.nvim"] = {
	lazy = true,
	event = "BufReadPost Cargo.toml",
	config = require("lang.crates"),
	dependencies = { "nvim-lua/plenary.nvim" },
} ]]

-- https://github.com/jose-elias-alvarez/typescript.nvim

-- lang["iamcco/markdown-preview.nvim"] = {
-- 	lazy = true,
-- 	ft = "markdown",
-- 	build = ":call mkdp#util#install()",
-- }

--[[ lang["chrisbra/csv.vim"] = {
	lazy = true,
	ft = "csv",
} ]]
return lang
