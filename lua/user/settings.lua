-- Please check `lua/core/settings.lua` to view the full list of configurable settings
local settings = {}

settings["use_copilot"] = false
settings["format_on_save"] = false
settings["transparent_background"] = true
settings["format_modifications_only"] = true
settings["diagnostics_level"] = "WARN"
settings["colorscheme"] = "catppuccin-frappe"

settings["gui_config"] = {
	font_size = 17,
	font_name = "JetBrainsMono Nerd Font",
	gui_font_face = "JetBrainsMono Nerd Font Mono:#e-antialias",
}

settings["neovide_config"] = {
	no_idle = true,
	refresh_rate = 60,
	cursor_vfx_mode = "railgun",
	cursor_vfx_opacity = 200.0,
	cursor_antialiasing = true,
	cursor_trail_length = 0.05,
	cursor_animation_length = 0.03,
	cursor_vfx_particle_speed = 20.0,
	cursor_vfx_particle_density = 5.0,
	cursor_vfx_particle_lifetime = 1.2,
}

settings["formatter_block_list"] = {
	yaml = true,
}

settings["lsp_deps"] = {
	"pylsp",
	"volar",
	"gopls",
	"bashls",
	"jsonls",
	"lua_ls",
	"dockerls",
}

settings["null_ls_deps"] = {
	"ruff",
	"black",
	"shfmt",
	"stylua",
	"prettier",
	"yamllint",
	"goimports",
}

settings["treesitter_deps"] = {
	"bash",
	"css",
	"dockerfile",
	"go",
	"gomod",
	"html",
	"javascript",
	"typescript",
	"json",
	"jsonc",
	"latex",
	"lua",
	"make",
	"python",
	"vimdoc",
	"vue",
	"yaml",
	"toml",
	"markdown",
	"markdown_inline",
}

settings["disabled_plugins"] = {
	"smoka7/hop.nvim", -- 不支持直接在 Telescope 中使用
    "folke/paint.nvim",
    "chrisbra/csv.vim",
	"romainl/vim-cool", -- makes hlsearch more useful
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	"zbirenbaum/neodim", -- dimming the highlights of unused functions, etc.
	"gelguy/wilder.nvim", -- A more adventurous wildmenu(/,?,:)
	"tpope/vim-fugitive",
	"pysan3/fcitx5.nvim",
	"tzachar/cmp-tabnine",
    "mrcjkb/rustaceanvim",
    "Saecki/crates.nvim",
    "zbirenbaum/copilot.lua",
    "zbirenbaum/copilot-cmp",
	"ojroques/nvim-bufdel",
	"lambdalisue/suda.vim", -- read or write files with sudo command
	"andersevenrud/cmp-tmux",
	"ibhagwan/smartyank.nvim",
	"kdheepak/cmp-latex-symbols",
	"nvim-neo-tree/neo-tree.nvim",
	"mfussenegger/nvim-treehopper",
    "iamcco/markdown-preview.nvim",
	"aaronhallaert/advanced-git-search.nvim",
}

settings["dashboard_image"] = {
	[[UUUUUUUU     UUUUUUUU                             CCCCCCCCCCCCC                           dddddddd                    ]],
	[[U::::::U     U::::::U                          CCC::::::::::::C                           d::::::d                    ]],
	[[U::::::U     U::::::U                        CC:::::::::::::::C                           d::::::d                    ]],
	[[UU:::::U     U:::::UU                       C:::::CCCCCCCC::::C                           d:::::d                     ]],
	[[ U:::::U     U:::::vvvvvvv           vvvvvvC:::::C       CCCCCC  ooooooooooo      ddddddddd:::::d    eeeeeeeeeeee     ]],
	[[ U:::::D     D:::::Uv:::::v         v:::::C:::::C              oo:::::::::::oo  dd::::::::::::::d  ee::::::::::::ee   ]],
	[[ U:::::D     D:::::U v:::::v       v:::::vC:::::C             o:::::::::::::::od::::::::::::::::d e::::::eeeee:::::ee ]],
	[[ U:::::D     D:::::U  v:::::v     v:::::v C:::::C             o:::::ooooo:::::d:::::::ddddd:::::de::::::e     e:::::e ]],
	[[ U:::::D     D:::::U   v:::::v   v:::::v  C:::::C             o::::o     o::::d::::::d    d:::::de:::::::eeeee::::::e ]],
	[[ U:::::D     D:::::U    v:::::v v:::::v   C:::::C             o::::o     o::::d:::::d     d:::::de:::::::::::::::::e  ]],
	[[ U:::::D     D:::::U     v:::::v:::::v    C:::::C             o::::o     o::::d:::::d     d:::::de::::::eeeeeeeeeee   ]],
	[[ U::::::U   U::::::U      v:::::::::v      C:::::C       CCCCCo::::o     o::::d:::::d     d:::::de:::::::e            ]],
	[[ U:::::::UUU:::::::U       v:::::::v        C:::::CCCCCCCC::::o:::::ooooo:::::d::::::ddddd::::::de::::::::e           ]],
	[[  UU:::::::::::::UU         v:::::v          CC:::::::::::::::o:::::::::::::::od:::::::::::::::::de::::::::eeeeeeee   ]],
	[[    UU:::::::::UU            v:::v             CCC::::::::::::Coo:::::::::::oo  d:::::::::ddd::::d ee:::::::::::::e   ]],
	[[      UUUUUUUUU               vvv                 CCCCCCCCCCCCC  ooooooooooo     ddddddddd   ddddd   eeeeeeeeeeeeee   ]],
}

return settings
