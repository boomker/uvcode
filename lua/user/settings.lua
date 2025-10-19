-- Please check `lua/core/settings.lua` to view the full list of configurable settings
local settings = {}

settings["use_copilot"] = false
settings["format_timeout"] = 3000
settings["format_on_save"] = true
-- settings["format_modifications_only"] = true
settings["transparent_background"] = true
settings["diagnostics_level"] = "WARN"
settings["colorscheme"] = "catppuccin-frappe"

settings["gui_config"] = {
	font_size = 15,
	font_name = "Maple Mono NF CN",
	gui_font_face = "Maple Mono NF CN",
}

settings["neovide_config"] = {
	theme = "dark",
	opacity = 0.9,
	light_radius = 5,
	refresh_rate = 60,
	scale_factor = 0.9,
	gui_font_size = 15,
	-- box-drawing = "native",
	cursor_vfx_opacity = 200.0,
	cursor_vfx_particle_speed = 20.0,
	cursor_vfx_particle_density = 0.8,
	cursor_vfx_particle_lifetime = 0.6,
	cursor_vfx_particle_highlight_lifetime = 0.3,
	cursor_vfx_mode = { "railgun", "pixiedust" },
	cursor_unfocused_outline_width = 0.06,
	cursor_trail_size = 0.8,
	cursor_trail_length = 0.10,
	cursor_animation_length = 0.03,
	underline_stroke_scale = 1.5,
	scroll_animation_length = 0.3,
	scroll_animation_far_lines = 1,
	position_animation_length = 0.15,
	no_idle = true,
	fullscreen = false,
	-- input_ime = true,
	floating_blur = true,
	cursor_antialiasing = true,
	remember_window_size = true,
	hide_mouse_when_typing = true,
	detach_on_quit = "always_quit",
	input_use_logo = 1, -- logo(cmd) key
	input_macos_option_key_is_meta = "both", -- only_left
}

settings["format_disabled_dirs"] = {}

settings["formatter_block_list"] = {
	-- lua = true,
	yaml = true,
}

settings["server_formatting_block_list"] = {
	clangd = true,
	lua_ls = true,
	ts_ls = true,
}

settings["lsp_deps"] = {
	"ruff",
	"dprint",
	"taplo",
	"gopls",
	"jsonls",
	"lua_ls",
	"yamlls",
	"dockerls",
	-- "pylsp",
	-- "bashls",
	"basedpyright",
}

settings["null_ls_deps"] = {
	"shfmt",
	"black",
	"stylua",
	"prettier",
	"yamllint",
	"goimports",
}

settings["treesitter_deps"] = {
	"go",
	"awk",
	"css",
	"vue",
	"lua",
	"make",
	"bash",
	"yaml",
	"toml",
	"gomod",
	"html",
	"json",
	"jsonc",
	"python",
	"vimdoc",
	"gitignore",
	"ssh_config",
	"dockerfile",
	"javascript",
	"typescript",
	"markdown",
	"markdown_inline",
}

settings["disabled_plugins"] = {
	"smoka7/hop.nvim", -- not support Telescope
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
	"hrsh7th/nvim-cmp",
	"yetone/avante.nvim",
	"tzachar/cmp-tabnine",
	"zbirenbaum/copilot.lua",
	"zbirenbaum/copilot-cmp",
	"andersevenrud/cmp-tmux",
	"Exafunction/codeium.nvim",
	"kdheepak/cmp-latex-symbols",
	"ojroques/nvim-bufdel",
	"lambdalisue/suda.vim",
	"ibhagwan/smartyank.nvim",
	"nvim-tree/nvim-tree.lua",
	"mfussenegger/nvim-treehopper",
	"ThePrimeagen/refactoring.nvim",
	"iamcco/markdown-preview.nvim",
	"aaronhallaert/advanced-git-search.nvim",
	"joechrisellis/lsp-format-modifications.nvim",
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

settings["search_backend"] = "fzf" -- "telescope"

return settings
