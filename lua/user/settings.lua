-- Please check `lua/core/settings.lua` to view the full list of configurable settings
local settings = {}

settings["use_copilot"] = false
settings["format_on_save"] = true
settings["format_timeout"] = 2000
settings["transparent_background"] = true
settings["format_modifications_only"] = true
settings["diagnostics_level"] = "WARN"
settings["colorscheme"] = "catppuccin-frappe"

settings["gui_config"] = {
	font_size = 15,
	font_name = "JetBrainsMono Nerd Font",
	gui_font_face = "JetBrainsMono Nerd Font Mono",
}

settings["neovide_config"] = {
	-- input_ime = true,
	theme = "dark",
	no_idle = true,
	refresh_rate = 60,
	gui_font_size = 15,
	transparency = 0.95,
    scale_factor = 0.9,
	cursor_vfx_mode = "railgun",
	cursor_vfx_opacity = 200.0,
	cursor_vfx_particle_speed = 20.0,
	cursor_vfx_particle_density = 5.0,
	cursor_vfx_particle_lifetime = 1.0,
	cursor_antialiasing = true,
	cursor_trail_size = 0,
	cursor_trail_length = 0.05,
	cursor_animation_length = 0.03,
	cursor_unfocused_outline_width = 0.06,
	scroll_animation_length = 0,
    light_radius = 5,
	floating_blur = true,
	floating_opacity = 0.15,
	floating_blur_amount_x = 2.0,
	floating_blur_amount_y = 2.0,
	underline_stroke_scale = 1.5,
	remember_window_size = true,
	hide_mouse_when_typing = true,
    detach_on_quit = 'always_quit',
    input_use_logo = 1, -- logo(cmd) key
	input_macos_option_key_is_meta = "both", -- only_left
}

settings["formatter_block_list"] = {
	lua = true, -- example
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
	"basedpyright",
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
    "Saecki/crates.nvim",
	"mrcjkb/rustaceanvim",
    "tzachar/cmp-tabnine",
	"zbirenbaum/copilot.lua",
	"zbirenbaum/copilot-cmp",
    -- "Exafunction/codeium.nvim",
	"ojroques/nvim-bufdel",
	"lambdalisue/suda.vim", -- read or write files with sudo command
	"andersevenrud/cmp-tmux",
	"ibhagwan/smartyank.nvim",
	"kdheepak/cmp-latex-symbols",
	"nvim-tree/nvim-tree.lua",
	"mfussenegger/nvim-treehopper",
	"iamcco/markdown-preview.nvim",
	"aaronhallaert/advanced-git-search.nvim",
    -- "joechrisellis/lsp-format-modifications.nvim"
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
