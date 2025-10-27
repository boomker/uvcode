require("user.keymap.helpers")
local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
local et = bind.escape_termcode

-- Place global keymaps here.
local mappings = {

	builtins = {
		["n|<leader>sP"] = map_cr("setlocal spell! spelllang=en_us"):with_desc("edit: Toggle spell check"),
	},

	plugins = {
		-- Plugin persisted.nvim
		["n|<leader>sr"] = map_cu("SessionLoadLast"):with_noremap():with_silent():with_desc("session: Load Last"),

		-- Plugin: comment.nvim
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
		["n|<Leader>df"] = map_callback(Toggle_diffview):with_silent():with_noremap():with_desc("git: Toggle diffview"),
		["n|<Leader>dh"] = map_callback(Toggle_files_history)
			:with_silent()
			:with_noremap()
			:with_desc("git: Toggle files history"),

		-- Plugin: grug-far
		["n|<leader>sp"] = map_callback(function()
				require("grug-far").open()
			end)
			:with_silent()
			:with_noremap()
			:with_desc("editn: Toggle search & replace panel"),
		["n|<leader>sw"] = map_callback(function()
				require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
			end)
			:with_silent()
			:with_noremap()
			:with_desc("editn: search&replace current word (project)"),
		["v|<leader>sW"] = map_callback(function()
				require("grug-far").with_visual_selection()
			end)
			:with_silent()
			:with_noremap()
			:with_desc("edit: search & replace current word (project)"),
		["n|<leader>sf"] = map_callback(function()
				require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
			end)
			:with_silent()
			:with_noremap()
			:with_desc("editn: search & replace current word (file)"),

		-- Plugin rmagatti/alternate-toggler
		["n|<Leader>a"] = map_callback(function()
				require("user.plugins.personal.alternate-toggler").toggle()
			end)
			:with_noremap()
			:with_silent()
			:with_desc("Toggle pair"),
	},
}

return mappings
