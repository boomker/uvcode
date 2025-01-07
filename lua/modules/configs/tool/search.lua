return function()
	local builtin = require("telescope.builtin")
	local extensions = require("telescope").extensions
	local vim_path = require("core.global").vim_path

	require("modules.utils").load_plugin("search", {
		collections = {
			-- Search using filenames
			file = {
				initial_tab = 1,
				tabs = {
					{
						name = "Files",
						tele_func = function(opts)
							opts = opts or {}
							if vim.fn.getcwd() == vim_path then
								builtin.find_files(vim.tbl_deep_extend("force", opts, { no_ignore = true }))
							elseif vim.fn.isdirectory(".git") == 1 then
								builtin.git_files(opts)
							else
								builtin.find_files(opts)
							end
						end,
					},
					{
						name = "Frecency",
						tele_func = function()
							extensions.frecency.frecency()
						end,
					},
					{
						name = "Oldfiles",
						tele_func = function()
							builtin.oldfiles()
						end,
					},
					{
						name = "Buffers",
						tele_func = function()
							builtin.buffers()
						end,
					},
				},
			},
			-- Search using patterns
			pattern = {
				initial_tab = 1,
				tabs = {
					{
						name = "Word in project",
						tele_func = function()
							local opts = {}
							if vim.fn.getcwd() == vim_path then
								opts["additional_args"] = { "--no-ignore" }
							end
							extensions.live_grep_args.live_grep_args(opts)
						end,
					},
					{
						name = "Word under cursor",
						tele_func = function(opts)
							opts = opts or {}
							if vim.fn.getcwd() == vim_path then
								opts["additional_args"] = { "--no-ignore" }
							end
							builtin.grep_string(opts)
						end,
					},
					{
						name = "Word in buffers",
						tele_func = function(opts)
							opts = {
								grep_open_files = true,
							}
							builtin.grep_string(opts)
						end,
					},
				},
			},
			-- Search Git objects (branches, commits)
			git = {
				initial_tab = 2,
				tabs = {
					{
						name = "Status diff",
						tele_func = function()
							-- builtin.git_branches()
							Telescope_git_status()
						end,
					},
					{
						name = "Commits",
						tele_func = function()
							-- builtin.git_commits()
							Telescope_git_commits()
						end,
					},
					{
                        name = "File history",
						tele_func = function()
							Telescope_git_bcommits()
						end,
					},
                    --[[
					{
						tele_func = function()
							extensions.advanced_git_search.search_log_content_file()
						end,
					},
					{
						name = "Diff file",
						tele_func = function()
							extensions.advanced_git_search.diff_commit_file()
						end,
					},
                    --]]
				},
			},
			-- Retrieve dossiers
			dossier = {
				initial_tab = 1,
				tabs = {
					{
						name = "Sessions",
						tele_func = function()
							extensions.persisted.persisted()
						end,
					},
					{
						name = "Projects",
						tele_func = function()
							extensions.projects.projects({})
						end,
					},
					{
						name = "Zoxide",
						tele_func = function()
							extensions.zoxide.list()
						end,
					},
				},
			},
			-- Miscellaneous
			misc = {
				initial_tab = 1,
				tabs = {
					{
						name = "Colorschemes",
						tele_func = function()
							builtin.colorscheme({ enable_preview = true })
						end,
					},
					{
						name = "Notify",
						tele_func = function()
							extensions.notify.notify()
						end,
					},
				},
			},
			-- History
			history = {
				initial_tab = 1,
				tabs = {
					{
						name = "Yank History",
						tele_func = function()
							extensions.yank_history.yank_history()
						end,
					},
					{
						name = "Command History",
						tele_func = function()
							builtin.command_history()
						end,
					},
					{
						name = "Undo History",
						tele_func = function()
							extensions.undo.undo()
						end,
					},
				},
			},
		},
	})
end
