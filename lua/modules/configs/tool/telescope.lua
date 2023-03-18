return function()
    require("modules.configs.tool.telescope_ui")
	local icons          = { ui = require("modules.utils.icons").get("ui", true) }
	local lga_actions    = require("telescope-live-grep-args.actions")

	local actions_layout = require("telescope.actions.layout")
	local action_state   = require("telescope.actions.state")
	local actions        = require("telescope.actions")
	local copy_to_clipboard_action = function(prompt_bufnr)
		local entry = action_state.get_selected_entry()
		local entry_val = entry.value
		vim.fn.setreg("+", entry_val)
		vim.fn.setreg('"', entry_val)

		vim.notify("Copied " .. entry_val .. " to clipboard", vim.log.levels.INFO)
		actions.close(prompt_bufnr)
	end
    -- local cwd_path = vim.fn.expand("%:p:h")

	require("telescope").setup({
		defaults = {
			initial_mode = "insert",
			prompt_prefix = " " .. icons.ui.Telescope .. " ",
			selection_caret = icons.ui.ChevronRight,
			scroll_strategy = "limit",
			results_title = false,
			path_display = { "smart" },
			color_devicons = true,
			set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
			file_ignore_patterns = {
				".git/",
				"node_modules/",
				"target/",
				"vendor/",
				".cache",
				"%.class",
				"%.pdf",
				"%.mkv",
				"%.mp4",
				"%.zip",
			},
			mappings = {
				i = {
					-- ["<C-j>"] = actions.move_selection_next,
					-- ["<C-k>"] = actions.move_selection_previous,
					["<C-u>"] = false,
					["<esc>"] = actions.close,
					["<C-space>"] = actions_layout.toggle_preview,
					["<C-h>"] = actions.which_key,
					["<C-b>"] = actions.preview_scrolling_up,
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,
					["<C-a>"] = actions.toggle_all,
					["<C-j>"] = actions.toggle_selection + actions.move_selection_next,
					["<C-k>"] = actions.toggle_selection + actions.move_selection_previous,
					-- ["<C-m>"] = custom_actions.multi_selection_open,
					-- ["<C-v>"] = custom_actions.multi_selection_open_vsplit,
					-- ["<C-s>"] = custom_actions.multi_selection_open_split,
					-- ["<C-t>"] = custom_actions.multi_selection_open_tab,
					["<C-y>"] = copy_to_clipboard_action,
				},
			},
			layout_strategy = "flex",
			layout_config = {
				width = 0.88,
				height = 0.88,

				horizontal = {
					-- width = { padding = 0.15 },
					preview_width = 0.4,
				},
				vertical = {
					preview_height = 0.75,
				},
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
		},
		pickers = {
			keymaps = {
				theme = "dropdown",
			},
			find_files = {
				-- copy_to_clipboard,
				mappings = {
					i = {
						["<C-y>"] = copy_to_clipboard_action,
					},
				},
				-- "--no-ignore-vcs",
				find_command = { "fd", "-H", "--type", "f", "--strip-cwd-prefix" },
                -- cwd = "cwd",
			},
			git_files = {
				mappings = {
					i = {
						["<C-y>"] = copy_to_clipboard_action,
					},
				},
				git_command = {
					"git",
					"ls-files",
					"--exclude-standard",
					"--cached",
					":!:*.git*",
					":!:*.png*",
					":!:*.gif*",
					":!:LICENSE",
				},
				-- "--others",
				-- show_untracked = true,
			},

			grep_string = {
				additional_args = { "--hidden", "--glob=!.git*", "--no-ignore" },
				mappings = {
					i = {
						["<C-f>"] = actions.to_fuzzy_refine,
						["<C-space>"] = actions_layout.toggle_preview,
						["<C-y>"] = copy_to_clipboard_action,
					},
				},
			},
			live_grep = {
				additional_args = { "--hidden", "--glob=!.git*", "--no-ignore" },
				mappings = {
					i = {
						["<C-f>"] = actions.to_fuzzy_refine,
						["<C-space>"] = actions_layout.toggle_preview,
						["<C-y>"] = copy_to_clipboard_action,
					},
				},
			},
		},
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
			frecency = {
				-- show_scores = true,
				show_unindexed = true,
				ignore_patterns = { "*.git/*", "*/tmp/*" },
			},
			live_grep_args = {
				auto_quoting = true, -- enable/disable auto-quoting
				-- define mappings, e.g.
				mappings = { -- extend mappings
					i = {
						["<C-e>"] = lga_actions.quote_prompt({ postfix = " -t"}),
						["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
					},
				},
			},
			undo = {
				side_by_side = true,
				mappings = { -- this whole table is the default
					i = {
						-- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
						-- you want to use the following actions. This means installing as a dependency of
						-- telescope in it's `requirements` and loading this extension from there instead of
						-- having the separate plugin definition as outlined above. See issue #6.
						["<cr>"] = require("telescope-undo.actions").yank_additions,
						["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
						["<C-cr>"] = require("telescope-undo.actions").restore,
					},
				},
			},
			projects = {
				base_dirs = {
					{ path = "~/gitrepos/", max_depth = 2 },
				},
				theme = "dropdown",
				order_by = "asc",
                hidden_files = true, -- default: false
				sync_with_nvim_tree = true, -- default false
			},
		},
	})

	require("telescope").load_extension("frecency")
	require("telescope").load_extension("fzf")
	require("telescope").load_extension("live_grep_args")
	require("telescope").load_extension("notify")
	require("telescope").load_extension("projects")
	require("telescope").load_extension("undo")
	require("telescope").load_extension("zoxide")
end
