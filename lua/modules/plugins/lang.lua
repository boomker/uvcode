local lang = {}

--[[ lang["AckslD/swenv.nvim"] = {
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

lang["simrat39/rust-tools.nvim"] = {
	lazy = true,
	ft = "rust",
	config = require("lang.rust-tools"),
	dependencies = { "nvim-lua/plenary.nvim" },
}

lang["Saecki/crates.nvim"] = {
	lazy = true,
	event = "BufReadPost Cargo.toml",
	config = require("lang.crates"),
	dependencies = { "nvim-lua/plenary.nvim" },
}

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
