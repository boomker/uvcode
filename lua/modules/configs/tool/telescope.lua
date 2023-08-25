return function()
    require("modules.configs.tool.telescope_ui")
    local icons = {ui = require("modules.utils.icons").get("ui", true)}
    local lga_actions = require("telescope-live-grep-args.actions")

    local actions_layout = require("telescope.actions.layout")
    local action_state = require("telescope.actions.state")
    local actions = require("telescope.actions")
    local copy_to_clipboard_action = function(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        local entry_val = entry.value
        vim.fn.setreg("+", entry_val)
        vim.fn.setreg('"', entry_val)

        vim.notify("Copied " .. entry_val .. " to clipboard",
                   vim.log.levels.INFO)
        actions.close(prompt_bufnr)
    end

    local flash_pick = function(prompt_bufnr)
        require("flash").jump({
            pattern = "^",
            label = {after = {0, 0}},
            search = {
                mode = "search",
                exclude = {
                    function(win)
                        return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~=
                                   "TelescopeResults"
                    end
                }
            },
            action = function(match)
                local picker =
                    require("telescope.actions.state").get_current_picker(
                        prompt_bufnr)
                picker:set_selection(match.pos[1] - 1)
            end
        })
    end

	require("telescope").setup({
		defaults = {
			vimgrep_arguments = {
				"rg",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			initial_mode = "insert",
			prompt_prefix = " " .. icons.ui.Telescope .. " ",
			selection_caret = icons.ui.ChevronRight,
			scroll_strategy = "limit",
			results_title = false,
			layout_strategy = "horizontal",
			path_display = { "absolute" },
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			color_devicons = true,
			file_ignore_patterns = { ".git/", ".cache", "build/", "%.class", "%.pdf", "%.mkv", "%.mp4", "%.zip" },
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.85,
				height = 0.92,
				preview_cutoff = 120,
			},
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
			file_sorter = require("telescope.sorters").get_fuzzy_file,
			generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
			buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		},
		extensions = {
			fzf = {
				fuzzy = false,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
			frecency = {
				show_scores = true,
				show_unindexed = true,
				ignore_patterns = { "*.git/*", "*/tmp/*" },
			},
			live_grep_args = {
				auto_quoting = true, -- enable/disable auto-quoting
				-- define mappings, e.g.
				mappings = { -- extend mappings
					i = {
						["<C-k>"] = lga_actions.quote_prompt(),
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
		},
	})

    require("telescope").load_extension("frecency")
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("live_grep_args")
    require("telescope").load_extension("notify")
    require("telescope").load_extension("projects")
    require("telescope").load_extension("undo")
    require("telescope").load_extension("zoxide")
    require('telescope').load_extension('smart_history')
    require("telescope").load_extension("persisted")
end
