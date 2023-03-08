---@diagnostic disable: lowercase-global
_G._command_panel = function()
	require("telescope.builtin").keymaps({
		lhs_filter = function(lhs)
			return not string.find(lhs, "Þ")
		end,
		layout_config = {
			width = 0.6,
			height = 0.6,
			prompt_position = "top",
		},
	})
end

local _lazygit = nil
_G._toggle_lazygit = function()
	if vim.fn.executable("lazygit") then
		if not _lazygit then
			_lazygit = require("toggleterm.terminal").Terminal:new({
				cmd = "lazygit",
				direction = "float",
				close_on_exit = true,
				hidden = true,
			})
		end
		_lazygit:toggle()
	else
		vim.notify("Command [lazygit] not found!", vim.log.levels.ERROR, { title = "toggleterm.nvim" })
	end
end

-- local _lazygit = nil
function toggle_lazygit()
	if not _lazygit then
		local Terminal = require("toggleterm.terminal").Terminal
		_lazygit = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			direction = "float",
		})
	end
	_lazygit:toggle()
end

local _ipython = nil
function toggle_ipython()
	if not _ipython then
		local Terminal = require("toggleterm.terminal").Terminal
		_ipython = Terminal:new({
			cmd = "ipython",
			hidden = true,
			direction = "horizontal",
		})
	end
	_ipython:toggle()
end

function command_panel()
	local opts = {
		lhs_filter = function(lhs)
			return not string.find(lhs, "Þ")
		end,
		layout_config = {
			width = 0.6,
			height = 0.6,
			prompt_position = "top",
		},
	}
	require("telescope.builtin").keymaps(opts)
end

local function git_proj_root()
	local cwd_parent = vim.fn.expand("%:p:h")
	vim.fn.system("git rev-parse --is-inside-work-tree")
	if vim.v.shell_error == 0 then
		local cmd = "git -C " .. cwd_parent .. " rev-parse --show-toplevel"
		local output = vim.fn.systemlist(cmd)
		return true, output[1]
	end
	return false, cwd_parent
end

function Telescope_project_files()
	local is_git_repo, proj_path = git_proj_root()
	local git_files_opts = {
		git_command = {
			"git",
			"ls-files",
			"--exclude-standard",
			"--cached",
			"--others",
			":!:*.git*",
			":!:*.png*",
			":!:*.gif*",
			":!:*.jpg*",
			":!:*.jpeg*",
			":!:LICENSE",
		},
		use_git_root = true,
		show_untracked = true,
		cwd = proj_path,
	} -- define here if you want to define something

	local fd_files_opts = {
		find_command = { "fd", "-IH", "--type", "f", "--strip-cwd-prefix", "--follow" },
		cwd = proj_path,
	}

	if is_git_repo then
		require("telescope.builtin").git_files(git_files_opts)
	else
		require("telescope.builtin").find_files(fd_files_opts)
	end
end

function Telescope_rg_kw(matchWord)
	local _, proj_path = git_proj_root()

	local get_cursor_word = function()
		return vim.fn.escape(vim.fn.expand("<cword>"), [[\/]])
	end
	local options = {
		cwd = proj_path,
		-- search = get_cursor_word(),
		-- word_match = "-w",
		search_dirs = { proj_path },
		prompt_title = "Rg KW in Git_Root(" .. get_cursor_word() .. ")",
	}

	if matchWord then
		options.word_match = "-w"
		-- options.prompt_title = "Rg KW in Git_Root(" .. get_cursor_word() .. ")",
	end

	require("telescope.builtin").grep_string(options)
end

function Telescope_rg_live_grep(searchScope)
	local _, proj_path = git_proj_root()
	local options = {
		cwd = proj_path,
		search_dirs = { proj_path },
		-- grep_open_files = false,
		prompt_title = "live_Rg KW in Git_Root",
	}

	if searchScope.scope == "buffers" then
		options = {
			prompt_title = "live_Rg string in open buffers",
			grep_open_files = true,
		}
	end

	require("telescope.builtin").live_grep(options)
end

