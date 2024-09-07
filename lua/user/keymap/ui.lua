local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

local plug_map = {

	["n|<Leader>sc"] = map_cu("Telescope colorscheme"):with_noremap():with_silent():with_desc("ui: Change colorscheme"),

	-- Bufferline
	["n|<Leader>k"] = map_cr("BufferLinePick"):with_noremap():with_silent():with_desc("Pick buffer"),
	["n|<Leader>bn"] = map_cr("BufferLineCycleNext"):with_noremap():with_silent():with_desc("Buffer: Switch to next"),
	["n|<Leader>bu"] = map_cr("BufferLineCyclePrev"):with_noremap():with_silent():with_desc("Buffer: Switch to prev"),
	["n|<Leader>nn"] = map_cu(":enew"):with_noremap():with_silent():with_desc("Buffer: New"),
	["n|<Leader>jl"] = map_cmd("<C-6>"):with_noremap():with_silent():with_desc("Buffer: goto last"),

	-- plugin todo-comments
	["n|<Leader>tl"] = map_cu("TodoTelescope")
        :with_noremap()
        :with_silent()
        :with_desc("TodoTelescope"),
	["n|<Leader>tn"] = map_cr("lua require('todo-comments').jump_next()")
		:with_noremap()
		:with_silent()
		:with_desc("jump next todo-comments"),
	["n|<Leader>tu"] = map_cr("lua require('todo-comments').jump_prev()")
		:with_noremap()
		:with_silent()
		:with_desc("jump prev todo-comments"),

	-- Plugin marks
	["n|<Leader>ml"] = map_cu("MarksListAll"):with_noremap():with_silent():with_desc("Search All Marks"),
	["n|<Leader>bl"] = map_cu("BookmarksListAll"):with_noremap():with_silent():with_desc("Search All Bookmarks"),
}

bind.nvim_load_mapping(plug_map)
