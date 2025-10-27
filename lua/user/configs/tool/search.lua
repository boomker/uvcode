return function()
	local vim_path = require("core.global").vim_path
	local builtins = require("telescope.builtin")
	local extensions = require("telescope").extensions
	local prompt_pos = require("telescope.config").values.layout_config.horizontal.prompt_position

	local pickers = {
		-- Search using filenames
		file = {
			{
				"Files",
				function(opts)
					opts = opts or {}
					if vim.fn.getcwd() == vim_path then
						builtins.find_files(vim.tbl_deep_extend("force", opts, { no_ignore = true }))
					elseif vim.fn.isdirectory(".git") == 1 then
						builtins.git_files(opts)
					else
						builtins.find_files(opts)
					end
				end,
			},
			{
				"Frequency",
				function()
					extensions.frecency.frecency()
				end,
			},
			{
				"Oldfiles",
				function()
					builtins.oldfiles()
				end,
			},
			{
				"Buffers",
				function()
					builtins.buffers()
				end,
			},
		},
		-- Search using patterns
		pattern = {
			{
				"Word in project",
				function()
					local opts = {}
					if vim.fn.getcwd() == vim_path then
						opts["additional_args"] = { "--no-ignore" }
					end
					extensions.live_grep_args.live_grep_args(opts)
				end,
			},
			{
				"Word under cursor",
				function(opts)
					opts = opts or {}
					if vim.fn.getcwd() == vim_path then
						opts["additional_args"] = { "--no-ignore" }
					end
					builtins.grep_string(opts)
				end,
			},
			{
				"Word in buffers",
				function(opts)
					opts = {
						grep_open_files = true,
					}
					builtins.grep_string(opts)
				end,
			},
		},
		-- Search Git objects (branches, commits)
		git = {
			{
				"Commits",
				function()
					Telescope_git_commits()
				end,
			},
			{
				"Status diff",
				function()
					Telescope_git_status()
				end,
			},
			{
				"File history",
				function()
					Telescope_git_bcommits()
				end,
			},
			-- { "Diff current file", extensions.advanced_git_search.diff_commit_file },
		},
		-- Retrieve dossiers
		dossier = {
			{
				"Sessions",
				function()
					extensions.persisted.persisted()
				end,
			},
			{
				"Projects",
				function()
					extensions.projects.projects({})
				end,
			},
			{
				"Zoxide",
				function()
					extensions.zoxide.list()
				end,
			},
		},
		-- Miscellaneous
		misc = {
			{
				"Colorschemes",
				function()
					builtins.colorscheme({ enable_preview = true })
				end,
			},
			{
				"Notify",
				function()
					extensions.notify.notify()
				end,
			},
		},
		-- History
		history = {
			{
				"Yank History",
				function()
					extensions.yank_history.yank_history()
				end,
			},
			{
				"Command History",
				function()
					builtins.command_history()
				end,
			},
			{
				"Undo History",
				function()
					extensions.undo.undo()
				end,
			},
		},
	}

	-- Build collections
	local collections = {}
	for kind, list in pairs(pickers) do
		local init = { initial_tab = 1, tabs = {} }
		for _, entry in ipairs(list) do
			table.insert(init.tabs, { name = entry[1], tele_func = entry[2] })
		end
		collections[kind] = init
	end

	require("modules.utils").load_plugin("search", {
		prompt_position = prompt_pos,
		collections = collections,
	})
end
