local lang = {}

--[[ lang["fatih/vim-go"] = {
	lazy = true,
	ft = "go",
	build = ":GoInstallBinaries",
	config = require("lang.vim-go"),
} ]]

lang["ray-x/go.nvim"] = {
	lazy = true,
	ft = "go",
	-- run = ":GoInstallBinaries",
	-- config = conf.lang_go,
	config = require("lang.vim-go"),
}

lang["simrat39/rust-tools.nvim"] = {
	lazy = true,
	ft = "rust",
	config = require("lang.rust-tools"),
	dependencies = { "nvim-lua/plenary.nvim" },
}

--[[ lang["iamcco/markdown-preview.nvim"] = {
	lazy = true,
	ft = "markdown",
	build = ":call mkdp#util#install()",
} ]]

lang["chrisbra/csv.vim"] = {
	lazy = true,
	ft = "csv",
}
return lang
