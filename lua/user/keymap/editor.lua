require("user.keymap.helpers")
local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
local et = bind.escape_termcode

-- Place global keymaps here.
local plug_map = {

	-- Plugin persisted.nvim
	["n|<leader>sr"] = map_cu("SessionLoadLast"):with_noremap():with_silent():with_desc("session: Load Last"),

	-- Plugin: comment.nvim
	--[[
    ["n|gb"] = map_cmd("<Plug>(comment_toggle_blockwise)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for block with operator"),
    ]]
	["n|gc"] = map_cmd("<Plug>(comment_toggle_linewise)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for line with operator"),
	["n|gcb"] = map_callback(function()
			return vim.v.count == 0 and et("<Plug>(comment_toggle_blockwise_current)")
				or et("<Plug>(comment_toggle_blockwise_count)")
		end)
		:with_silent()
		:with_noremap()
		:with_expr()
		:with_desc("edit: Toggle comment for block"),
	["x|gcc"] = map_cmd("<Plug>(comment_toggle_linewise_visual)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for line with selection"),
	["x|gcb"] = map_cmd("<Plug>(comment_toggle_blockwise_visual)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for block with selection"),

	-- Plugin Diffview
	["n|<Leader>dt"] = map_cr("DiffviewToggleFiles"):with_noremap():with_silent():with_desc("git: DiffviewToggleFiles"),
	-- { "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", desc = "git: File history" },
	["n|<Leader>df"] = map_callback(Toggle_diffview):with_silent():with_noremap():with_desc("git: Toggle diffview"),
	["n|<Leader>dF"] = map_callback(Toggle_files_diff)
		:with_silent()
		:with_noremap()
		:with_desc("git: Toggle files history"),

	-- Plugin: smart-splits.nvim
	["n|<C-k>"] = map_cu("SmartCursorMoveUp"):with_silent():with_noremap():with_desc("window: Focus up"),
	["n|<C-j>"] = map_cu("SmartCursorMoveDown"):with_silent():with_noremap():with_desc("window: Focus down"),
	["n|<C-h>"] = map_cu("SmartCursorMoveLeft"):with_silent():with_noremap():with_desc("window: Focus left"),
	["n|<C-l>"] = map_cu("SmartCursorMoveRight"):with_silent():with_noremap():with_desc("window: Focus right"),
	-- [[ToggleTerm
	["t|<D-Up>"] = map_cmd("<Esc><Cmd>SmartResizeUp<CR>"):with_silent(),
	["t|<D-Down>"] = map_cmd("<Esc><Cmd>SmartResizeDown<CR>"):with_silent(),
	["t|<D-Left>"] = map_cmd("<Esc><Cmd>SmartResizeLeft<CR>"):with_silent(),
	["t|<D-Right>"] = map_cmd("<Esc><Cmd>SmartResizeRight<CR>"):with_silent(),
	-- ToggleTerm]]
	["n|<D-Up>"] = map_cu("SmartResizeUp"):with_silent():with_noremap():with_desc("window: Resize +3 vertically"),
	["n|<D-Down>"] = map_cu("SmartResizeDown"):with_silent():with_noremap():with_desc("window: Resize -3 vertically"),
	["n|<D-Left>"] = map_cu("SmartResizeLeft"):with_silent():with_noremap():with_desc("window: Resize -3 horizontally"),
	["n|<D-Right>"] = map_cu("SmartResizeRight")
		:with_silent()
		:with_noremap()
		:with_desc("window: Resize +3 horizontally"),
	["n|<leader>sK"] = map_cu("SmartSwapUp"):with_silent():with_noremap():with_desc("window: Move window upward"),
	["n|<leader>sJ"] = map_cu("SmartSwapDown"):with_silent():with_noremap():with_desc("window: Move window downward"),
	["n|<leader>sH"] = map_cu("SmartSwapLeft"):with_silent():with_noremap():with_desc("window: Move window leftward"),
	["n|<leader>sL"] = map_cu("SmartSwapRight"):with_silent():with_noremap():with_desc("window: Move window rightward"),

	-- Plugin: nvim-spectre
	["n|<leader>sO"] = map_callback(function()
			require("spectre").toggle()
		end)
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle search & replace panel"),
	["n|<leader>sw"] = map_callback(function()
			require("spectre").open_visual({ select_word = true })
		end)
		:with_silent()
		:with_noremap()
		:with_desc("edit: search&replace current word (project)"),
	["v|<leader>sV"] = map_callback(function()
			require("spectre").open_visual()
		end)
		:with_silent()
		:with_noremap()
		:with_desc("edit: search & replace current word (project)"),
	["n|<leader>sf"] = map_callback(function()
			require("spectre").open_file_search({ select_word = true })
		end)
		:with_silent()
		:with_noremap()
		:with_desc("edit: search & replace current word (file)"),

	-- Plugin rmagatti/alternate-toggler
    ["n|<Leader>a"] = map_callback(
		function ()
			require("user.plugins.person.alternate-toggler").toggle()
		end
	)
	:with_noremap():with_silent():with_desc("Toggle pair"),

	-- Plugin nvim-multi-cursor
	["nx|gb"] = map_cmd("<Cmd>MultipleCursorsAddDown<CR>"):with_noremap():with_silent():with_desc("add cursor word"),
}

bind.nvim_load_mapping(plug_map)
