-- Please check `lua/core/settings.lua` to view the full list of configurable settings
local settings = {}

-- Examples
settings["use_ssh"] = true
settings["use_copilot"] = false

settings["colorscheme"] = "catppuccin"
settings["disabled_plugins"] = {
    "nvim-tree/nvim-tree.lua",
    "kdheepak/cmp-latex-symbols",
    "andersevenrud/cmp-tmux",
    "ojroques/nvim-bufdel",
    "folke/flash.nvim",
    "romainl/vim-cool",
    "lambdalisue/suda.vim",
    "tpope/vim-sleuth",
}
return settings
