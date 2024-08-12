local settings = require("core.settings")
local global = require("core.global")

-- Create cache dir and data dirs
local createdir = function()
	local data_dirs = {
		global.cache_dir .. "/backup",
		global.cache_dir .. "/session",
		global.cache_dir .. "/swap",
		global.cache_dir .. "/tags",
		global.cache_dir .. "/undo",
	}
	-- Only check whether cache_dir exists, this would be enough.
	if vim.fn.isdirectory(global.cache_dir) == 0 then
		---@diagnostic disable-next-line: param-type-mismatch
		vim.fn.mkdir(global.cache_dir, "p")
		for _, dir in pairs(data_dirs) do
			if vim.fn.isdirectory(dir) == 0 then
				vim.fn.mkdir(dir, "p")
			end
		end
	end
end

local leader_map = function()
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "
	vim.api.nvim_set_keymap("n", " ", "", { noremap = true })
	vim.api.nvim_set_keymap("x", " ", "", { noremap = true })
end

local neovide_config = function()
	vim.g.neovide_theme = "dark"
	vim.g.gui_font_size = 17
	vim.g.gui_font_default_size = 17
	vim.g.neovide_transparency = 0.90
	vim.g.gui_font_face = settings.gui_config.gui_font_face
	vim.o.guifont = settings.gui_config.gui_font_face .. ":h17"

	-- vim.g.neovide_no_idle = true
	-- vim.g.neovide_refresh_rate = 60
	-- vim.g.neovide_cursor_trail_length = 0.05
	-- vim.g.neovide_cursor_animation_length = 0.05
	-- vim.g.neovide_cursor_vfx_opacity = 200.0
	-- vim.g.neovide_cursor_vfx_particle_speed = 20.0
	-- vim.g.neovide_cursor_vfx_particle_density = 5.0
	-- vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_cursor_vfx_mode = "railgun"
	vim.g.neovide_cursor_trail_size = 0
	vim.g.neovide_cursor_animation_length = 0
	vim.g.neovide_cursor_unfocused_outline_width = 0.061

	-- vim.g.neovide_input_ime = true
	vim.g.neovide_floating_blur = true
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0
	vim.g.neovide_floating_opacity = 0.15
	vim.g.neovide_scroll_animation_length = 0
	vim.g.neovide_underline_stroke_scale = 1.5

	vim.g.neovide_remember_window_size = true
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_input_macos_option_key_is_meta = "only_left"

	RefreshGuiFont = function()
		vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_default_size)
	end

	ResizeGuiFont = function(delta)
		vim.g.gui_font_size = vim.g.gui_font_default_size + delta
		RefreshGuiFont()
	end

	-- Keymaps

	local opts = { noremap = true, silent = true }

	vim.keymap.set({ "n", "i" }, "<D-=>", function()
		ResizeGuiFont(0)
	end, opts)

	vim.keymap.set({ "n", "i" }, "<D-+>", function()
		ResizeGuiFont(1)
	end, opts)

	vim.keymap.set({ "n", "i" }, "<D-->", function()
		ResizeGuiFont(-1)
	end, opts)
end

local clipboard_config = function()
	if global.is_mac then
		vim.g.clipboard = {
			name = "macOS-clipboard",
			copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
			paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
			cache_enabled = 0,
		}
	elseif global.is_wsl then
		vim.g.clipboard = {
			name = "win32yank-wsl",
			copy = {
				["+"] = "win32yank.exe -i --crlf",
				["*"] = "win32yank.exe -i --crlf",
			},
			paste = {
				["+"] = "win32yank.exe -o --lf",
				["*"] = "win32yank.exe -o --lf",
			},
			cache_enabled = 0,
		}
	end
end

local shell_config = function()
	if global.is_windows then
		if not (vim.fn.executable("pwsh") == 1 or vim.fn.executable("powershell") == 1) then
			vim.notify(
				[[
Failed to setup terminal config

PowerShell is either not installed, missing from PATH, or not executable;
cmd.exe will be used instead for `:!` (shell bang) and toggleterm.nvim.

You're recommended to install PowerShell for better experience.]],
				vim.log.levels.WARN,
				{ title = "[core] Runtime Warning" }
			)
			return
		end

		local basecmd = "-NoLogo -MTA -ExecutionPolicy RemoteSigned"
		local ctrlcmd = "-Command [console]::InputEncoding = [console]::OutputEncoding = [System.Text.Encoding]::UTF8"
		local set_opts = vim.api.nvim_set_option_value
		set_opts("shell", vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell", {})
		set_opts("shellcmdflag", string.format("%s %s;", basecmd, ctrlcmd), {})
		set_opts("shellredir", "-RedirectStandardOutput %s -NoNewWindow -Wait", {})
		set_opts("shellpipe", "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode", {})
		set_opts("shellquote", "", {})
		set_opts("shellxquote", "", {})
	end
end

local load_core = function()
	createdir()
	leader_map()

	neovide_config()
	clipboard_config()
	shell_config()

	require("core.options")
	require("core.mapping")
	require("keymap")
	require("core.event")
	require("core.pack")

	vim.api.nvim_set_option_value("background", settings.background, {})
	vim.cmd.colorscheme(settings.colorscheme)
end

load_core()
