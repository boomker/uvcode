local bind = require("keymap.bind")
-- local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
local et = bind.escape_termcode

-- Place global keymaps here.
local plug_map = {
	-- Plugin: comment.nvim
	["n|gcb"] = map_callback(function()
			return vim.v.count == 0 and et("<Plug>(comment_toggle_blockwise_current)")
				or et("<Plug>(comment_toggle_blockwise_count)")
		end)
		:with_silent()
		:with_noremap()
		:with_expr()
		:with_desc("editn: Toggle comment for block"),

	-- Plugin Diffview
	["n|<Leader>jd"] = map_cu("DiffviewFocusFiles"):
		with_noremap():
		with_silent():
		with_desc("git: DiffviewFocusFiles"),
	["n|<Leader>df"] = map_callback(toggle_show_diff):
		with_silent():
		with_noremap():
		with_desc("git: Show diff"),
	["n|<Leader>dh"] = map_callback(toggle_file_history)
		:with_silent()
		:with_noremap()
		:with_desc("git: show file history"),

	-- Plugin rmagatti/alternate-toggler
	["n|<Leader>a"] = map_cu("ToggleAlternate"):
		with_noremap():
		with_silent():
		with_desc("Toggle bool"),

	-- Plugin nvim-multi-cursor
	["nx|gb"] = map_cmd("<Cmd>MultipleCursorsAddDown<CR>"):
		with_noremap():
		with_silent():
		with_desc("add cursor word"),

}

bind.nvim_load_mapping(plug_map)
