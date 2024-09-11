return function()
	require("user.configs.ui.telescope_ui")
	local icons = { ui = require("modules.utils.icons").get("ui", true) }
	local lga_actions = require("telescope-live-grep-args.actions")

	local actions_layout = require("telescope.actions.layout")
	local action_state = require("telescope.actions.state")
	local actions = require("telescope.actions")
	local copy_to_clipboard = function(prompt_bufnr)
		local entry = action_state.get_selected_entry()
		local entry_val = entry.value
		vim.fn.setreg("+", entry_val)
		vim.fn.setreg('"', entry_val)

		vim.notify("Copied " .. entry_val .. " to clipboard", vim.log.levels.INFO)
		actions.close(prompt_bufnr)
	end

	local flash_pick = function(prompt_bufnr)
		require("flash").jump({
			pattern = "^",
			label = { after = { 0, 0 } },
			search = {
				mode = "search",
				exclude = {
					function(win)
						return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
					end,
				},
			},
			action = function(match)
				local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
				picker:set_selection(match.pos[1] - 1)
			end,
		})
	end

	require("modules.utils").load_plugin("telescope", {
		defaults = {
			initial_mode = "insert",
			prompt_prefix = " " .. icons.ui.Telescope .. " ",
			selection_caret = icons.ui.ChevronRight,
			color_devicons = true,
			results_title = false,
			scroll_strategy = "limit",
			layout_strategy = "flex",
			path_display = { "smart" },
			set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
			file_ignore_patterns = {
				".git/",
				".venv/",
				".cache/",
				"build/",
				"target/",
				"vendor/",
				"__pycache__/",
				"node_modules/",
				"%.pdf",
				"%.mkv",
				"%.mp4",
				"%.zip",
				"%.class",
			},
			mappings = {
				i = {
					["<C-u>"] = false,
					["<C-s>"] = flash_pick,
					["<C-y>"] = copy_to_clipboard,
					["<esc>"] = actions.close,
					["<C-h>"] = actions.which_key,
					["<C-a>"] = actions.toggle_all,
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,
                    ["<C-b>"] = actions.preview_scrolling_up,
					["<C-v>"] = actions_layout.toggle_preview,
					["<C-j>"] = actions.toggle_selection + actions.move_selection_next,
					["<C-k>"] = actions.toggle_selection + actions.move_selection_previous,
					-- ["<C-m>"] = custom_actions.multi_selection_open,
					-- ["<C-v>"] = custom_actions.multi_selection_open_vsplit,
					-- ["<C-t>"] = custom_actions.multi_selection_open_split,
				},
			},
			layout_config = {
				width = 0.88,
				height = 0.88,
				preview_cutoff = 120,

				horizontal = {
					-- width = { padding = 0.15 },
					preview_width = 0.48,
				},
				vertical = { preview_height = 0.75 },
			},
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--trim", -- To trim the indentation at the beginning of presented line in the result window
			},
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
			file_sorter = require("telescope.sorters").get_fuzzy_file,
			generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
			buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		},
		pickers = {
			keymaps = { theme = "dropdown" },
			find_files = {
				mappings = { i = { ["<C-y>"] = copy_to_clipboard } },
				find_command = { "fd", "-H", "--type", "f", "--strip-cwd-prefix" },
			},
			git_files = {
				mappings = { i = { ["<C-y>"] = copy_to_clipboard } },
				git_command = {
					"git",
					"ls-files",
					"--exclude-standard",
					"--cached",
					":!:*.git*",
					":!:*.png*",
					":!:*.gif*",
					":!:LICENSE",
					":!:build/",
				},
				-- "--others",
				-- show_untracked = true,
			},

			grep_string = {
				additional_args = { "--hidden", "--glob=!.git*", "--no-ignore" },
				mappings = {
					i = {
						["<C-f>"] = actions.to_fuzzy_refine,
						["<C-v>"] = actions_layout.toggle_preview,
						["<C-y>"] = copy_to_clipboard,
					},
				},
			},
			live_grep = {
				additional_args = { "--hidden", "--glob=!.git*", "--no-ignore" },
				mappings = {
					i = {
						["<C-f>"] = actions.to_fuzzy_refine,
						["<C-v>"] = actions_layout.toggle_preview,
						["<C-y>"] = copy_to_clipboard,
					},
				},
			},
		},
		extensions = {
			aerial = {
				show_lines = false,
				show_nesting = {
					["_"] = false, -- This key will be the default
					lua = true, -- You can set the option for specific filetypes
				},
			},
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
			frecency = {
				use_sqlite = false,
				-- show_scores = true,
				db_safe_mode = false,
				show_unindexed = true,
				ignore_patterns = { "*.git/*", "*/tmp/*" },
			},
			live_grep_args = {
				auto_quoting = true, -- enable/disable auto-quoting
				mappings = { -- extend mappings
					i = {
						["<C-e>"] = lga_actions.quote_prompt({ postfix = " -w -t" }),
						["<C-i>"] = lga_actions.quote_prompt({
							postfix = " --iglob *.",
						}),
					},
				},
			},
			undo = {
				side_by_side = true,
				mappings = {
					i = {
						["<cr>"] = require("telescope-undo.actions").yank_additions,
						["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
						["<C-cr>"] = require("telescope-undo.actions").restore,
					},
				},
			},
			projects = {
				base_dirs = { { path = "~/gitrepos/", max_depth = 2 } },
				theme = "dropdown",
				order_by = "asc",
				hidden_files = true, -- default: false
				sync_with_nvim_tree = true, -- default false
			},
            --[[
            advanced_git_search = {
				diff_plugin = "diffview",
				git_flags = { "-c", "delta.side-by-side=false" },
				-- git_diff_flags = { "-c", "delta.side-by-side=false" },
				entry_default_author_or_date = "author", -- one of "author" or "date"
			}, ]]
		},
	})

	require("telescope").load_extension("fzf")
	require("telescope").load_extension("undo")
	require("telescope").load_extension("notify")
	require("telescope").load_extension("zoxide")
	require("telescope").load_extension("aerial")
    require("telescope").load_extension('cmdline')
	require("telescope").load_extension("frecency")
	require("telescope").load_extension("projects")
	require("telescope").load_extension("persisted")
	require("telescope").load_extension("yank_history")
	require("telescope").load_extension("live_grep_args")
	-- require("telescope").load_extension("advanced_git_search")
end
