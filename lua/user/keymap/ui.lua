local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

local plug_map = {
	-- Bufferline
	["n|<leader>k"] = map_cr("BufferLinePick"):with_noremap():with_silent(),
	["n|<leader>jl"] = map_cmd("<C-6>"):with_noremap():with_silent(),
	["n|<leader>jn"] = map_cr("BufferLineCycleNext"):with_noremap():with_silent():with_desc("buffer: Switch to next"),
	["n|<leader>jp"] = map_cr("BufferLineCyclePrev"):with_noremap():with_silent():with_desc("buffer: Switch to prev"),

	-- plugin todo-comments
	["n|<leader>tj"] = map_cr("lua require('todo-comments').jump_next()"):with_noremap():with_silent(),
	["n|<leader>tk"] = map_cr("lua require('todo-comments').jump_prev()"):with_noremap():with_silent(),
	-- ["n|[t"] = map_cr("lua require('todo-comments').jump_next()"):with_noremap():with_silent(),
	-- ["n|]t"] = map_cr("lua require('todo-comments').jump_prev()"):with_noremap():with_silent(),

	-- Plugin marks
	["n|<Leader>ml"] = map_cu("MarksListAll"):with_noremap():with_silent():with_desc("Search All Marks"),
	["n|<Leader>bl"] = map_cu("BookmarksListAll"):with_noremap():with_silent():with_desc("Search All Bookmarks"),
}

bind.nvim_load_mapping(plug_map)
