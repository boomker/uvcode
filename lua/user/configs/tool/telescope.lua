return function()
	require("user.configs.ui.telescope_ui")
	local icons = { ui = require("modules.utils.icons").get("ui", true) }
	local lga_actions = require("telescope-live-grep-args.actions")

	local actions_layout = require("telescope.actions.layout")
	local action_state = require("telescope.actions.state")
	local actions = require("telescope.actions")

	local function multiopen(prompt_bufnr, open_cmd)
		local picker = action_state.get_current_picker(prompt_bufnr)
		local num_selections = #picker:get_multi_selection()
		if num_selections > 1 then
			vim.cmd("enew!")
			for _, entry in pairs(picker:get_multi_selection()) do
				local file_path = entry.value:find(":[0-9]+") and entry.value:gsub(":[0-9]+.*", "") or entry.value
				vim.cmd(string.format("%s %s", open_cmd, file_path))
			end
			vim.cmd("stopinsert")
		else
			if open_cmd == "vsplit" then
				actions.file_vsplit(prompt_bufnr)
			elseif open_cmd == "split" then
				actions.file_split(prompt_bufnr)
			elseif open_cmd == "tabe" then
				actions.file_tab(prompt_bufnr)
			else
				actions.file_edit(prompt_bufnr)
			end
		end
	end
	local function multi_selection_open_vsplit(prompt_bufnr)
		multiopen(prompt_bufnr, "vsplit")
	end
	local function multi_selection_open_split(prompt_bufnr)
		multiopen(prompt_bufnr, "split")
	end
	local function multi_selection_open_tab(prompt_bufnr)
		multiopen(prompt_bufnr, "tabe")
	end
	local function multi_selection_open(prompt_bufnr)
		multiopen(prompt_bufnr, "edit")
	end

	local copy_path_to_clipboard = function(prompt_bufnr)
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
				local picker = action_state.get_current_picker(prompt_bufnr)
				picker:set_selection(match.pos[1] - 1)
			end,
		})
	end

	require("modules.utils").load_plugin("telescope", {
		defaults = {
			winblend = 0,
			results_title = false,
			color_devicons = true,
			initial_mode = "insert",
			scroll_strategy = "limit",
			layout_strategy = "flex",
			path_display = { "smart" },
			set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
			selection_caret = icons.ui.ChevronRight,
			prompt_prefix = " " .. icons.ui.Telescope .. " ",
			mappings = {
				i = {
					-- ["<C-a>"] = false,
					["<C-u>"] = false,
					["<C-s>"] = flash_pick,
					["<C-y>"] = copy_path_to_clipboard,
					["<C-O>"] = multi_selection_open,
					["<C-t>"] = multi_selection_open_tab,
					["<C-x>"] = multi_selection_open_split,
					["<C-v>"] = multi_selection_open_vsplit,
					["<esc>"] = actions.close,
					["<C-h>"] = actions.which_key,
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,
					["<C-b>"] = actions.preview_scrolling_up,
					["<C-e>"] = actions_layout.toggle_preview,
					["<C-j>"] = actions.toggle_selection + actions.move_selection_next,
					["<C-k>"] = actions.toggle_selection + actions.move_selection_previous,
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
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
			file_sorter = require("telescope.sorters").get_fuzzy_file,
			generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
			buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		},
		pickers = {
			keymaps = { theme = "dropdown" },
			buffers = {
				path_display = { "smart" },
				mappings = {
					i = { ["<C-d>"] = actions.delete_buffer + actions.move_to_bottom },
					n = { ["d"] = actions.delete_buffer + actions.move_to_bottom },
				},
			},
			find_files = {
				mappings = { i = { ["<C-y>"] = copy_path_to_clipboard } },
				find_command = { "fd", "-H", "--type", "f", "--strip-cwd-prefix" },
			},
			git_files = {
				mappings = { i = { ["<C-y>"] = copy_path_to_clipboard } },
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
						["<C-e>"] = actions_layout.toggle_preview,
						["<C-y>"] = copy_path_to_clipboard,
					},
				},
			},
			live_grep = {
				additional_args = { "--hidden", "--glob=!.git*", "--no-ignore" },
				mappings = {
					i = {
						["<C-f>"] = actions.to_fuzzy_refine,
						["<C-e>"] = actions_layout.toggle_preview,
						["<C-y>"] = copy_path_to_clipboard,
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
						-- ["<C-e>"] = lga_actions.quote_prompt({ postfix = " -w -t" }),
						["<A-i>"] = lga_actions.quote_prompt({
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
			--[[
            advanced_git_search = {
				diff_plugin = "diffview",
				git_flags = { "-c", "delta.side-by-side=false" },
				-- git_diff_flags = { "-c", "delta.side-by-side=false" },
				entry_default_author_or_date = "author", -- one of "author" or "date"
			}, ]]
			projects = {
				base_dirs = { { path = "~/gitrepos/", max_depth = 2 } },
				theme = "dropdown",
				order_by = "asc",
				hidden_files = true, -- default: false
				sync_with_nvim_tree = true, -- default false
			},
		},
	})

	require("telescope").load_extension("fzf")
	require("telescope").load_extension("undo")
	require("telescope").load_extension("notify")
	require("telescope").load_extension("zoxide")
	require("telescope").load_extension("cmdline")
	require("telescope").load_extension("frecency")
	require("telescope").load_extension("projects")
	require("telescope").load_extension("persisted")
	require("telescope").load_extension("yank_history")
	require("telescope").load_extension("live_grep_args")
	-- require("telescope").load_extension("advanced_git_search")
end
