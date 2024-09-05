local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
local et = bind.escape_termcode

local plug_map = {

	-- Plugin persisted.nvim
	["n|<leader>ss"] = map_cu("SessionSave"):with_noremap():with_silent():with_desc("session: Save"),
	["n|<leader>sl"] = map_cu("SessionLoad"):with_noremap():with_silent():with_desc("session: Load current"),
	["n|<leader>sr"] = map_cu("SessionLoadLast"):with_noremap():with_silent():with_desc("session: Load Last"),
	-- ["n|<leader>sd"] = map_cu("SessionDelete"):with_noremap():with_silent():with_desc("session: Delete"),

	-- Plugin: MiniBufremove
	["n|<C-q>"] = map_cu("lua require('mini.bufremove').delete()")
		:with_noremap()
		:with_silent()
		:with_desc("buffer: Close current"),

	-- Plugin: comment.nvim
	["n|gcc"] = map_callback(function()
			return vim.v.count == 0 and et("<Plug>(comment_toggle_linewise_current)")
				or et("<Plug>(comment_toggle_linewise_count)")
		end)
		:with_silent()
		:with_noremap()
		:with_expr()
		:with_desc("edit: Toggle comment for line"),
	["n|gcb"] = map_callback(function()
			return vim.v.count == 0 and et("<Plug>(comment_toggle_blockwise_current)")
				or et("<Plug>(comment_toggle_blockwise_count)")
		end)
		:with_silent()
		:with_noremap()
		:with_expr()
		:with_desc("edit: Toggle comment for block"),
	--[[ ["n|gb"] = map_cmd("<Plug>(comment_toggle_blockwise)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for block with operator"), ]]
	["n|gc"] = map_cmd("<Plug>(comment_toggle_linewise)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for line with operator"),
	["x|gcc"] = map_cmd("<Plug>(comment_toggle_linewise_visual)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for line with selection"),
	["x|gcb"] = map_cmd("<Plug>(comment_toggle_blockwise_visual)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for block with selection"),

    --[[
	-- Plugin: diffview
	-- ["n|<leader>do"] = map_cr("DiffviewOpen"):with_silent():with_noremap():with_desc("git: Show diff"),
	-- ["n|<leader>dc"] = map_cr("DiffviewClose"):with_silent():with_noremap():with_desc("git: Close diff"),

	-- Plugin: hop
	-- ["nv|<leader>jw"] = map_cmd("<Cmd>HopWordMW<CR>"):with_noremap():with_desc("jump: Goto word"),
	-- ["nv|<leader>jk"] = map_cmd("<Cmd>HopLineMW<CR>"):with_noremap():with_desc("jump: Goto line"),

    -- Plugin: smart-splits.nvim
    ["n|<A-h>"] = map_cu("SmartResizeLeft"):with_silent():with_noremap():with_desc("window: Resize -3 horizontally"),
    ["n|<A-j>"] = map_cu("SmartResizeDown"):with_silent():with_noremap():with_desc("window: Resize -3 vertically"),
    ["n|<A-k>"] = map_cu("SmartResizeUp"):with_silent():with_noremap():with_desc("window: Resize +3 vertically"),
    ["n|<A-l>"] = map_cu("SmartResizeRight"):with_silent():with_noremap():with_desc("window: Resize +3 horizontally"),
    ["n|<C-h>"] = map_cu("SmartCursorMoveLeft"):with_silent():with_noremap():with_desc("window: Focus left"),
    ["n|<C-j>"] = map_cu("SmartCursorMoveDown"):with_silent():with_noremap():with_desc("window: Focus down"),
    ["n|<C-k>"] = map_cu("SmartCursorMoveUp"):with_silent():with_noremap():with_desc("window: Focus up"),
    ["n|<C-l>"] = map_cu("SmartCursorMoveRight"):with_silent():with_noremap():with_desc("window: Focus right"),
    --]]

    ["n|<leader>Wh"] = map_cu("SmartSwapLeft"):with_silent():with_noremap():with_desc("window: Move window leftward"),
    ["n|<leader>Wj"] = map_cu("SmartSwapDown"):with_silent():with_noremap():with_desc("window: Move window downward"),
    ["n|<leader>Wk"] = map_cu("SmartSwapUp"):with_silent():with_noremap():with_desc("window: Move window upward"),
    ["n|<leader>Wl"] = map_cu("SmartSwapRight"):with_silent():with_noremap():with_desc("window: Move window rightward"),

	-- Plugin: treehopper
	-- ["x|m"] = map_cu("lua require('tsht').nodes()"):with_silent():with_desc("jump: Operate across syntax tree"),

	-- Plugin suda.vim
	-- ["n|<A-s>"] = map_cu("SudaWrite"):with_silent():with_noremap():with_desc("editn: Save file using sudo"),
}

bind.nvim_load_mapping(plug_map)
