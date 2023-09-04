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
	["n|<leader>df"] = map_callback(toggle_show_diff):with_silent():with_noremap():with_desc("git: Show diff"),
	["n|<leader>dh"] = map_callback(toggle_file_history)
		:with_silent()
		:with_noremap()
		:with_desc("git: show file history"),

	-- Plugin Tabout
	["i|<D-S-l>"] = map_cmd("<Plug>(TaboutMulti)"):with_silent():with_noremap():with_desc("editi: Goto end of pair"),
	["i|<D-S-h>"] = map_cmd("<Plug>(TaboutBackMulti)")
		:with_silent()
		:with_noremap()
		:with_desc("editi: Goto begin of pair"),

	-- Plugin rmagatti/alternate-toggler
	["n|<leader>a"] = map_cu("ToggleAlternate"):with_noremap():with_silent(),

	-- Plugin vim-visual-multi
	-- NOTE: `Tab`:switch mode; `q, Q`: skip, remove region; n, N: goto next/prev
	["nx|gsa"] = map_cmd([[<Plug>(VM-Select-All)]]):with_noremap():with_silent(),
	-- ["x|gsa"] = map_cmd([[<Plug>(VM-Select-All)]]):with_silent(),
	["n|<D-d>"] = map_cmd([[<Plug>(VM-Find-Under)]]):with_noremap():with_silent(),
	["n|<A-d>"] = map_cmd([[<Plug>(VM-Find-Under)]]):with_noremap():with_silent(),
	["x|<D-d>"] = map_cmd([[<Plug>(VM-Find-Subword-Under)]]):with_silent(),

	-- refactoring
	["v|<leader>re"] = map_cmd([[<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]])
		:with_noremap()
		:with_silent()
		:with_desc("[R]efactor: [E]xtract function"),
	["v|<leader>rf"] = map_cmd([[<Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]])
		:with_noremap()
		:with_silent()
		:with_desc("[R]efactor: Extract function to [F]ile"),
	["v|<leader>rv"] = map_cmd([[<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]])
		:with_noremap()
		:with_silent()
		:with_desc("[R]efactor: Extract [V]ariable"),
	["v|<leader>ri"] = map_cmd([[<Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]])
		:with_noremap()
		:with_silent()
		:with_desc("[R]efactor: [I]nline variable"),
	-- Extract block doesn't need visual mode
	["n|<leader>rb"] = map_cmd([[<Cmd>lua require('refactoring').refactor('Extract Block')<CR>]])
		:with_noremap()
		:with_silent()
		:with_desc("[R]efactor: Extract [B]lock"),
	["n|<leader>rB"] = map_cmd([[<Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]])
		:with_noremap()
		:with_silent()
		:with_desc("[R]efactor: Extract [B]lock to [F]ile"),
	-- Inline variable can also pick up the identifier currently under the cursor without visual mode
	["n|<leader>ri"] = map_cmd([[<Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]])
		:with_noremap()
		:with_silent()
		:with_desc("[R]efactor: [I]nline variable"),

	-- Plugin: flash
	["nv|<leader>jw"] = map_callback(function()
			require("flash").jump({
				search = {
					mode = function(str)
						return "\\<" .. str
					end,
				},
			})
		end)
		:with_noremap()
		:with_desc("jump: Goto word"),
	["nv|<leader>je"] = map_callback(function()
			require("flash").jump({
				search = { forward = false, wrap = false, multi_window = false },
			})
		end)
		:with_noremap()
		:with_desc("jump: Goto word"),
	["nv|<leader>jd"] = map_callback(function()
			require("flash").jump({
				search = { forward = true, wrap = false, multi_window = false },
			})
		end)
		:with_noremap()
		:with_desc("jump: Goto word"),
	["nv|<leader>jk"] = map_callback(function()
			require("flash").jump({
				search = {
					mode = "search",
					max_length = 0,
					forward = false,
					wrap = false,
				},
				label = { after = { 1, 0 }, uppercase = false },
				pattern = "^",
			})
		end)
		:with_noremap()
		:with_desc("jump: Goto line"),
	["nv|<leader>jj"] = map_callback(function()
			require("flash").jump({
				search = {
					mode = "search",
					max_length = 0,
					forward = true,
					wrap = false,
				},
				label = { after = { 1, 0 }, uppercase = false },
				pattern = "^",
			})
		end)
		:with_noremap()
		:with_desc("jump: Goto line"),
	["nxo|<leader>jf"] = map_callback(function()
			require("flash").jump()
		end)
		:with_noremap()
		:with_desc("jump: Goto hint char"),
	["nxo|<leader>js"] = map_callback(function()
			require("flash").treesitter()
		end)
		:with_noremap()
		:with_desc("Flash Treesitter Select"),
}

bind.nvim_load_mapping(plug_map)
