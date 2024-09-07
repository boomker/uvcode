local bind = require("keymap.bind")
local map_cr = bind.map_cr
-- local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
require("keymap.helpers")
local plug_map = {

    -- LiveServer, html
	["n|<Leader>ls"] = map_cmd("<Cmd>LiveServerStart<CR>")
		:with_noremap()
		:with_silent()
		:with_desc("LiveServer: Start"),
	["n|<Leader>lt"] = map_cmd("<Cmd>LiveServerStop<CR>")
		:with_noremap()
		:with_silent()
		:with_desc("LiveServer: Stop"),

    -- yaml
	["n|<Leader>fy"] = map_callback(Telescope_yaml_symbols)
        :with_noremap()
        :with_silent()
        :with_desc("yaml_symbols"),

	-- Plugin swenv, ft: python
	["n|<Leader>sV"] = map_cr("lua require('swenv.api').pick_venv()")
		:with_noremap()
		:with_silent()
		:with_desc("swenv: switch venv"),
}
bind.nvim_load_mapping(plug_map)
