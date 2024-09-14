return function()
	vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
	vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
	vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
	vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

	require("neo-tree").setup({
		sources = {
			"filesystem",
			"git_status",
			-- "buffers",
		},
		source_selector = {
			winbar = true, -- toggle to show selector on winbar
			statusline = false, -- toggle to show selector on statusline
			show_scrolled_off_parent_node = false, -- this will replace the tabs with the parent path
			-- of the top visible node when scrolled down.
			sources = {
				{ source = "filesystem" },
				{ source = "git_status" },
				-- { source = "buffers" },
			},
			content_layout = "center", -- only with `tabs_layout` = "equal", "focus"
			--                start  : |/ 󰓩 bufname     \/...
			--                end    : |/     󰓩 bufname \/...
			--                center : |/   󰓩 bufname   \/...
			tabs_layout = "equal", -- start, end, center, equal, focus
			--             start  : |/  a  \/  b  \/  c  \            |
			--             end    : |            /  a  \/  b  \/  c  \|
			--             center : |      /  a  \/  b  \/  c  \      |
			--             equal  : |/    a    \/    b    \/    c    \|
			--             active : |/  focused tab    \/  b  \/  c  \|
			truncation_character = "…", -- character to use when truncating the tab label
			tabs_min_width = nil, -- nil | int: if int padding is added based on `content_layout`
			tabs_max_width = nil, -- this will truncate text even if `text_trunc_to_fit = false`
			padding = 0, -- can be int or table
			-- padding = { left = 2, right = 0 },
			-- separator = "▕", -- can be string or table, see below
			separator = { left = "▏", right = "▕" },
			-- separator = { left = "/", right = "\\", override = nil },     -- |/  a  \/  b  \/  c  \...
			-- separator = { left = "/", right = "\\", override = "right" }, -- |/  a  \  b  \  c  \...
			-- separator = { left = "/", right = "\\", override = "left" },  -- |/  a  /  b  /  c  /...
			-- separator = { left = "/", right = "\\", override = "active" },-- |/  a  / b:active \  c  \...
			-- separator = "|",                                              -- ||  a  |  b  |  c  |...
			separator_active = nil, -- set separators around the active tab. nil falls back to `source_selector.separator`
			show_separator_on_edge = false,
			--                       true  : |/    a    \/    b    \/    c    \|
			--                       false : |     a    \/    b    \/    c     |
			highlight_tab = "NeoTreeTabInactive",
			highlight_tab_active = "NeoTreeTabActive",
			highlight_background = "NeoTreeTabInactive",
			highlight_separator = "NeoTreeTabSeparatorInactive",
			highlight_separator_active = "NeoTreeTabSeparatorActive",
		},
		enable_git_status = true,
		enable_diagnostics = true,
		close_if_last_window = true,
		default_source = "filesystem",
		popup_border_style = "rounded",
		-- when opening files, do not use windows containing these filetypes or buftypes
		sort_case_insensitive = false, -- used when sorting files and directories in the tree
		sort_function = function(a, b)
			if a.type == b.type then
				return a.path > b.path
			else
				return a.type > b.type
			end
		end, -- this sorts files and directories descendantly
		default_component_configs = {
			container = {
				enable_character_fade = true,
			},
			indent = {
				indent_size = 2,
				padding = 1, -- extra padding on left hand side
				-- indent guides
				with_markers = true,
				indent_marker = "│",
				last_indent_marker = "└",
				highlight = "NeoTreeIndentMarker",
				-- expander config, needed for nesting files
				with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
			icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "󰜌",
				-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
				-- then these will never be used.
				default = "*",
				highlight = "NeoTreeFileIcon",
			},
			modified = {
				symbol = "[+]",
				highlight = "NeoTreeModified",
			},
			name = {
				trailing_slash = false,
				use_git_status_colors = true,
				highlight = "NeoTreeFileName",
			},
			git_status = {
				symbols = {
					-- Change type
					added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
					modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
					deleted = "✖", -- this can only be used in the git_status source
					renamed = "󰁕", -- this can only be used in the git_status source
					-- Status type
					untracked = "",
					ignored = "",
					unstaged = "󰄱",
					staged = "",
					conflict = "",
				},
			},
			-- If you don't want to use these columns, you can set `enabled = false` for each of them individually
			file_size = {
				enabled = true,
				required_width = 64, -- min width of window required to show this column
			},
			type = {
				enabled = true,
				required_width = 122, -- min width of window required to show this column
			},
			last_modified = {
				enabled = true,
				required_width = 88, -- min width of window required to show this column
			},
			created = {
				enabled = true,
				required_width = 110, -- min width of window required to show this column
			},
			symlink_target = {
				enabled = false,
			},
		},
		commands = {
			copy_relative_path = function(state)
				local node = state.tree:get_node()
				local filepath = node:get_id()
				local modify = vim.fn.fnamemodify
				local short_path = modify(filepath, ":.")
				vim.fn.setreg("+", short_path)
				vim.notify(("Copied path: `%s`"):format(short_path))
			end,

			copy_absolute_path = function(state)
				local node = state.tree:get_node()
				local filepath = node:get_id()
				vim.fn.setreg("+", filepath)
				vim.notify(("Copied path: `%s`"):format(filepath))
			end,

			copy_selector = function(state)
				local node = state.tree:get_node()
				local filepath = node:get_id()
				local filename = node.name
				local modify = vim.fn.fnamemodify

				local vals = {
					["FILENAME"] = filename,
					["BASENAME"] = modify(filename, ":r"),
					["EXTENSION"] = modify(filename, ":e"),
					["PATH (relative)"] = modify(filepath, ":."),
					["PATH (home)"] = modify(filepath, ":~"),
					["PATH (uri)"] = vim.uri_from_fname(filepath),
					["PATH (absolute)"] = filepath,
				}

				local options = vim.tbl_filter(function(val)
					return vals[val] ~= ""
				end, vim.tbl_keys(vals))
				if vim.tbl_isempty(options) then
					vim.notify("No values to copy", vim.log.levels.WARN)
					return
				end
				table.sort(options)
				vim.ui.select(options, {
					prompt = "Choose to copy to clipboard:",
					format_item = function(item)
						return ("%s: %s"):format(item, vals[item])
					end,
				}, function(choice)
					local result = vals[choice]
					if result then
						vim.notify(("Copied: `%s`"):format(result))
						vim.fn.setreg("+", result)
					end
				end)
			end,

			open_and_clear_filter = function(state)
				local node = state.tree:get_node()
				if node and node.type == "file" then
					local file_path = node:get_id()
					-- reuse built-in commands to open and clear filter
					local cmds = require("neo-tree.sources.filesystem.commands")
					cmds.open(state)
					cmds.clear_filter(state)
					-- reveal the selected file without focusing the tree
					require("neo-tree.sources.filesystem").navigate(state, state.path, file_path)
				end
			end,

			git_files_history = function()
				require("diffview").file_history()
			end,

			git_files_status = function()
				require("diffview").open()
			end,
		},
		nesting_rules = {},
		window = {
			position = "left",
			width = 30,
			mapping_options = {
				noremap = true,
				nowait = true,
			},
			mappings = {
				["<space>"] = {
					"toggle_node",
					nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
				},
				["o"] = "open",
				["l"] = "open",
				["<cr>"] = "open",
				-- ["<cr>"] = "open_drop",
				["<2-LeftMouse>"] = "open",
				["<esc>"] = "cancel", -- close preview or floating neo-tree window
				["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
				-- Read `# Preview Mode` for more information
				["V"] = "focus_preview",
				["w"] = false,
				["ww"] = "open_with_window_picker",
				["wh"] = "split_with_window_picker",
				["wv"] = "vsplit_with_window_picker",
				["wt"] = "open_tab_drop",
				["<c-s>"] = "open_split",
				["<c-v>"] = "open_vsplit",
				["<c-t>"] = "open_tabnew",
				["h"] = "close_node",
				["z"] = false,
				["zh"] = "close_all_nodes",
				["zl"] = "expand_all_nodes",
				["zc"] = "close_all_subnodes",
				-- ['C'] = 'close_all_subnodes',
				["t"] = {
					"add",
					-- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
					-- some commands may take optional config options, see `:h neo-tree-mappings` for details
					config = {
						show_path = "none", -- "none", "relative", "absolute"
					},
				},
				["a"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
				["d"] = "delete",
				["r"] = "rename",
				["Y"] = "copy_selector",
				["y"] = false,
				["yy"] = "copy_to_clipboard",
				["ys"] = "copy_relative_path", -- short path
				["yf"] = "copy_absolute_path", -- full path
				["c"] = "copy_to_clipboard",
				["x"] = "cut_to_clipboard",
				["p"] = "paste_from_clipboard",
				["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
				["q"] = "close_window",
				["R"] = "refresh",
				["?"] = "show_help",
				["<"] = "prev_source",
				[">"] = "next_source",
				["i"] = "show_file_details",
			},
		},
		filesystem = {
			filtered_items = {
				visible = false, -- when true, they will just be displayed differently than normal items
				hide_dotfiles = true,
				hide_gitignored = true,
				hide_hidden = true, -- only works on Windows for hidden files/directories
				hide_by_name = {
					"node_modules",
				},
				hide_by_pattern = {
					"*.gif",
					"*.pdf",
					"*.png",
					"*.sim",
					"*.digi",
					"*.mdf",
					"*.dst",
					"test_catalog-*.000000.xml",
				},
				always_show = { -- remains visible even if other settings would normally hide it
					".config",
					".gitignore",
					"config.json",
					"histo.root",
					"tuple.root",
					"yaml",
					".schema.json",
				},
				never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
					".DS_Store",
					"thumbs.db",
					"__pycache__",
				},
				never_show_by_pattern = { -- uses glob style patterns
					".null-ls_*",
					"*.gram",
				},
			},
			follow_current_file = {
				enabled = true, -- This will find and focus the file in the active buffer every time
				--              -- the current file is changed while the tree is open.
				leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
			},
			group_empty_dirs = false, -- when true, empty folders will be grouped together
			hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
			-- in whatever position is specified in window.position
			-- "open_current",  -- netrw disabled, opening a directory opens within the
			-- window like netrw would, regardless of window.position
			-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
			use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
			-- instead of relying on nvim autocmd events.
			window = {
				mappings = {
					["<bs>"] = "navigate_up",
					["o"] = "open_and_clear_filter",
					["<cr>"] = "open_and_clear_filter",
					["."] = "set_root",
					["H"] = "toggle_hidden",
					["/"] = "fuzzy_finder",
					["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
					-- ["D"] = "fuzzy_sorter_directory",
					["D"] = "fuzzy_finder_directory",
					["f"] = "filter_on_submit",
					["<c-x>"] = "clear_filter",
					["[g"] = "prev_git_modified",
					["]g"] = "next_git_modified",
					["s"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "s" } },
					["sc"] = { "order_by_created", nowait = false },
					["sd"] = { "order_by_diagnostics", nowait = false },
					["sg"] = { "order_by_git_status", nowait = false },
					["sm"] = { "order_by_modified", nowait = false },
					["sn"] = { "order_by_name", nowait = false },
					["ss"] = { "order_by_size", nowait = false },
					["st"] = { "order_by_type", nowait = false },
				},
				fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
					["<down>"] = "move_cursor_down",
					["<C-n>"] = "move_cursor_down",
					["<up>"] = "move_cursor_up",
					["<C-p>"] = "move_cursor_up",
				},
			},

			commands = {}, -- Add a custom command or override a global one using the same function name
		},
		buffers = {
			follow_current_file = {
				enabled = true, -- This will find and focus the file in the active buffer every time
				--              -- the current file is changed while the tree is open.
				leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
			},
			group_empty_dirs = true, -- when true, empty folders will be grouped together
			show_unloaded = true,
			window = {
				mappings = {
					["bd"] = "buffer_delete",
					["<bs>"] = "navigate_up",
					["."] = "set_root",
					["s"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "s" } },
					["sc"] = { "order_by_created", nowait = false },
					["sd"] = { "order_by_diagnostics", nowait = false },
					["sm"] = { "order_by_modified", nowait = false },
					["sn"] = { "order_by_name", nowait = false },
					["ss"] = { "order_by_size", nowait = false },
					["st"] = { "order_by_type", nowait = false },
				},
			},
		},
		git_status = {
			window = {
				position = "float",
				mappings = {
					["A"] = "git_add_all",
					["gs"] = "git_files_status",
					["gh"] = "git_files_history",
					["gu"] = "git_unstage_file",
					["ga"] = "git_add_file",
					["gr"] = "git_revert_file",
					["gc"] = "git_commit",
					["gp"] = "git_push",
					["gg"] = "git_commit_and_push",
					["s"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "s" } },
					["sc"] = { "order_by_created", nowait = false },
					["sd"] = { "order_by_diagnostics", nowait = false },
					["sm"] = { "order_by_modified", nowait = false },
					["sn"] = { "order_by_name", nowait = false },
					["ss"] = { "order_by_size", nowait = false },
					["st"] = { "order_by_type", nowait = false },
				},
			},
		},
		open_files_do_not_replace_types = {
			-- "git",
			-- "edgy",
			-- "overseerlist",
			-- "OverseerList",
			"qf",
			"diff",
			"notify",
			"Outline",
			"trouble",
			"terminal",
			"NvimTree",
			"dap-repl",
			"fugitive",
			"undotree",
			"toggleterm",
			"fugitiveblame",
			"TelescopePrompt",
		},
	})
end
