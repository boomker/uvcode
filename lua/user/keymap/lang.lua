local bind = require("keymap.bind")
-- local map_cr = bind.map_cr
-- local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
-- local map_callback = bind.map_callback
require("keymap.helpers")
local plug_map = {

	["n|<leader>ls"] = map_cmd("<Cmd>LiveServerStart<CR>")
		:with_noremap()
		:with_silent()
		:with_desc("LiveServer: Start"),
	["n|<leader>lt"] = map_cmd("<Cmd>LiveServerStop<CR>")
		:with_noremap()
		:with_silent()
		:with_desc("LiveServer: Stop"),
}
bind.nvim_load_mapping(plug_map)
