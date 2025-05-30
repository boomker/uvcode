require("user.keymap.helpers")
local bind = require("keymap.bind")
local map_cu = bind.map_cu
local map_cr = bind.map_cr
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback

local plug_map = {

	-- LiveServer, html
	["n|<Leader>ls"] = map_cmd("<Cmd>LiveServerStart<CR>"):with_noremap():with_silent():with_desc("LiveServer: Start"),
	["n|<Leader>lt"] = map_cmd("<Cmd>LiveServerStop<CR>"):with_noremap():with_silent():with_desc("LiveServer: Stop"),

	-- yaml
	["n|<Leader>fy"] = map_callback(Telescope_yaml_symbols):with_noremap():with_silent():with_desc("yaml_symbols"),
}
bind.nvim_load_mapping(plug_map)
