local lang = {}

lang["ray-x/go.nvim"] = {
	lazy = true,
	ft = "go",
	build = ":GoInstallBinaries",
	init = require("lang.vim-go"),
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
