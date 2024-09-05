-- Please check `lua/core/settings.lua` to view the full list of configurable settings
local settings = {}

-- Examples
settings["use_ssh"] = true
settings["use_copilot"] = false

settings["colorscheme"] = "catppuccin"
settings["disabled_plugins"] = {
    -- "folke/flash.nvim",
	"romainl/vim-cool",
	"tpope/vim-sleuth",
	"zbirenbaum/neodim",
	"ojroques/nvim-bufdel",
    "lambdalisue/suda.vim",
    "andersevenrud/cmp-tmux",
	"kdheepak/cmp-latex-symbols",
	"nvim-neo-tree/neo-tree.nvim",
	-- "karb94/neoscroll.nvim",
}
return settings
