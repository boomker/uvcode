---@diagnostic disable: lowercase-global
local utils = require("core.utils")

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

_G._telescope_collections = function(picker_type)
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local conf = require("telescope.config").values
	local finder = require("telescope.finders")
	local pickers = require("telescope.pickers")
	picker_type = picker_type or {}

	local collections = vim.tbl_keys(require("search.tabs").collections)
	pickers
		.new(picker_type, {
			prompt_title = "Telescope Collections",
			finder = finder.new_table({ results = collections }),
			sorter = conf.generic_sorter(picker_type),
			attach_mappings = function(bufnr)
				actions.select_default:replace(function()
					actions.close(bufnr)
					local selection = action_state.get_selected_entry()
					require("search").open({ collection = selection[1] })
				end)

				return true
			end,
		})
		:find()
end

_G._flash_esc_or_noh = function()
	local flash_active, state = pcall(function()
		return require("flash.plugins.char").state
	end)
	if flash_active and state then
		state:hide()
	else
		pcall(vim.cmd.noh)
	end
end

local _lazygit = nil
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
			cmd = "~/.venv/bin/ipython3",
			hidden = true,
			direction = "horizontal",
		})
	end
	_ipython:toggle()
end

function Telescope_find_file(searchScope)
	local is_git_repo, proj_path = utils.git_proj_root()
	local cwd = vim.fn.expand("%:p:h")
	local git_files_opts = {
		git_command = {
			"git",
			"ls-files", -- "--exclude-standard",
			"--cached",
			"--others",
			":!:*.git*",
			":!:*.png*",
			":!:*.gif*",
			":!:*.jpg*",
			":!:*.jpeg*",
			":!:*.obsidian*",
			":!:LICENSE",
			":!:build/",
		},
		use_git_root = true,
		show_untracked = true,
		cwd = proj_path,
	} -- define here if you want to define something

	local fd_files_opts = {
		find_command = {
			"fd",
			"-IH",
			"--type",
			"f",
			"--strip-cwd-prefix",
			"--follow",
		},
		cwd = cwd,
		layout_config = {
			width = 0.88,
			height = 0.88,

			horizontal = { preview_width = 0.6 },
		},
	}

	if is_git_repo and searchScope.scope ~= "cwd" then
		require("telescope.builtin").git_files(git_files_opts)
	else
		require("telescope.builtin").find_files(fd_files_opts)
	end
end

function Telescope_rg_word(matchWord)
	local _, proj_path = utils.git_proj_root()

	local get_cursor_word = function()
		return vim.fn.escape(vim.fn.expand("<cword>"), [[\/]])
	end
	local options = {
		cwd = proj_path,
		search_dirs = { proj_path },
		prompt_title = "Rg word in Git_Root(" .. get_cursor_word() .. ")",
	}

	if matchWord then
		options.word_match = "-w"
	end

	require("telescope.builtin").grep_string(options)
end

function Telescope_rg_live_word(searchScope)
	local _, proj_path = utils.git_proj_root()
	local options = {
		cwd = proj_path,
		search_dirs = { proj_path },
		prompt_title = "Live rg word in Git_Root",
	}

	if searchScope.scope == "buffers" then
		options = {
			prompt_title = "Live rg word in open buffers",
			grep_open_files = true,
		}
	end

	require("telescope.builtin").live_grep(options)
end

Telescope_find_neovim_config = function(opts)
	opts = opts or {}
	opts = {
		cwd = vim.env.HOME .. "/gitrepos/uvcode",
		prompt_title = "Find file in uvcode",
	}
	require("telescope.builtin").find_files(opts)
end

Telescope_git_commits = function(opts)
	opts = opts or {}
	opts.previewer = {
		-- delta,
		require("telescope.previewers").new_termopen_previewer({
			get_command = function(entry)
				return {
					"git",
					"-c",
					"core.pager=delta",
					"-c",
					"delta.side-by-side=false",
					"diff",
					entry.value .. "^!",
				}
			end,
		}),
		require("telescope.previewers").git_commit_message.new(opts),
		require("telescope.previewers").git_commit_diff_as_was.new(opts),
	}

	require("telescope.builtin").git_commits(opts)
end

Telescope_git_bcommits = function(opts)
	opts = opts or {}
	opts.previewer = {
		require("telescope.previewers").new_termopen_previewer({
			get_command = function(entry)
				return {
					"git",
					"-c",
					"core.pager=delta",
					"-c",
					"delta.side-by-side=false",
					"diff",
					entry.value .. "^!",
					"--",
					entry.current_file,
				}
			end,
		}),
		require("telescope.previewers").git_commit_message.new(opts),
		require("telescope.previewers").git_commit_diff_as_was.new(opts),
	}

	require("telescope.builtin").git_bcommits(opts)
end

Telescope_git_status = function(opts)
	opts = opts or {}
	opts.previewer = {
		require("telescope.previewers").new_termopen_previewer({
			get_command = function(entry)
				return {
					"git",
					"-c",
					"core.pager=delta",
					"-c",
					"delta.side-by-side=false",
					"diff",
					entry.value,
				}
			end,
		}),
		require("telescope.previewers").git_file_diff.new(opts),
	}
	opts.layout_config = {
		width = 0.88,
		height = 0.88,

		horizontal = { preview_width = 0.60 },
	}
	require("telescope.builtin").git_status(opts)
end

-- ╭───────────────────────────────────────────────────────────────╮
-- │ From Ecovim Custom toggle file history function via <leader>dh│
-- ╰───────────────────────────────────────────────────────────────╯
toggle_file_history = function()
	local view = require("diffview.lib").get_current_view()
	if view == nil then
		require("diffview").file_history()
		return
	end

	if view then
		view:close()
		require("diffview.lib").dispose_view(view)
	end
end

-- ╭───────────────────────────────────────────────────────────────╮
-- │ From Ecovim Custom toggle file diff function via <leader>df   │
-- ╰───────────────────────────────────────────────────────────────╯
toggle_show_diff = function()
	local view = require("diffview.lib").get_current_view()
	if view == nil then
		require("diffview").open()
		return
	end

	if view then
		view:close()
		require("diffview.lib").dispose_view(view)
	end
end

-- yaml_symbols

---@diagnostic disable-next-line: unused-local
local function visit_yaml_node(node, name, yaml_path, result, file_path, bufnr)
	local key = ""
	if node:type() == "block_mapping_pair" then
		local field_key = node:field("key")[1]
		key = vim.treesitter.get_node_text(field_key, bufnr)
	end

	if key ~= nil and string.len(key) > 0 then
		table.insert(yaml_path, key)
		local line, col = node:start()
		table.insert(result, {
			lnum = line + 1,
			col = col + 1,
			bufnr = bufnr,
			filename = file_path,
			text = table.concat(yaml_path, "."),
		})
	end

	---@diagnostic disable-next-line: redefined-local
	for node, name in node:iter_children() do
		visit_yaml_node(node, name, yaml_path, result, file_path, bufnr)
	end

	if key ~= nil and string.len(key) > 0 then
		table.remove(yaml_path, tonumber(utils.table_maxn(yaml_path)))
	end
end

local function gen_from_yaml_nodes(opts)
	opts = opts or {}
	local make_entry = require("telescope.make_entry")
	local entry_display = require("telescope.pickers.entry_display")
	local displayer = entry_display.create({
		separator = " │ ",
		items = { { width = 5 }, { remaining = true } },
	})

	opts.layout_config = {
		width = 0.88,
		height = 0.88,
		horizontal = { preview_width = 0.6 },
	}
	local make_display = function(entry)
		return displayer({
			{ entry.lnum, "TelescopeResultsSpecialComment" },
			{
				entry.text,
				function()
					return {}
				end,
			},
		})
	end

	return function(entry)
		return make_entry.set_default_entry_mt({
			ordinal = entry.text,
			display = make_display,
			filename = entry.filename,
			lnum = entry.lnum,
			text = entry.text,
			col = entry.col,
		}, opts)
	end
end

Telescope_yaml_symbols = function(opts)
	opts = opts or {}
	local pickers = require("telescope.pickers")
	local conf = require("telescope.config").values
	local finders = require("telescope.finders")
	local yaml_path = {}
	local result = {}
	local bufnr = vim.api.nvim_get_current_buf()
	local ft = vim.api.nvim_get_option_value("ft", { buf = bufnr })
	local tree = vim.treesitter.get_parser(bufnr, ft):parse()[1]
	local file_path = vim.api.nvim_buf_get_name(bufnr)
	local root = tree:root()
	for node, name in root:iter_children() do
		visit_yaml_node(node, name, yaml_path, result, file_path, bufnr)
	end

	-- return result
	pickers
		.new(opts, {
			prompt_title = "YAML symbols",
			finder = finders.new_table({
				results = result,
				entry_maker = opts and opts.entry_maker or gen_from_yaml_nodes(opts),
			}),
			sorter = conf.generic_sorter(opts),
			previewer = conf.grep_previewer(opts),
		})
		:find()
end
