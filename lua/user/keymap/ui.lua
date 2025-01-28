require("user.keymap.helpers")
local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback

local mappings = {
	builtins = {
		-- Builtins: Terminal
		["t|<C-w>h"] = map_cmd("<Cmd>wincmd h<CR>"):with_silent():with_noremap():with_desc("window: Focus left"),
		["t|<C-w>l"] = map_cmd("<Cmd>wincmd l<CR>"):with_silent():with_noremap():with_desc("window: Focus right"),
		["t|<C-w>j"] = map_cmd("<Cmd>wincmd j<CR>"):with_silent():with_noremap():with_desc("window: Focus down"),
		["t|<C-w>k"] = map_cmd("<Cmd>wincmd k<CR>"):with_silent():with_noremap():with_desc("window: Focus up"),

		-- Builtins: Tabpage
		["n|<Leader>tN"] = map_cr("tabnew"):with_noremap():with_silent():with_desc("tab: Create a new tab"),
		["n|<Leader>te"] = map_cr("tabnext"):with_noremap():with_silent():with_desc("tab: Move to next tab"),
		["n|<Leader>tw"] = map_cr("tabprevious"):with_noremap():with_silent():with_desc("tab: Move to previous tab"),
		["n|<Leader>to"] = map_cr("tabonly"):with_noremap():with_silent():with_desc("tab: Only keep current tab"),
	},

	plugins = {
		["n|<Leader>sc"] = map_cu("Telescope colorscheme")
			:with_noremap()
			:with_silent()
			:with_desc("ui: Change colorscheme"),

		-- Bufferline
		["n|<Leader>k"] = map_cr("BufferLinePick"):with_noremap():with_silent():with_desc("Pick buffer"),
		-- ["n|<Leader>bw"] = map_cr("BufferLineMovePrev"):with_noremap():with_silent():with_desc("Buffer: Move to prev"),
		-- ["n|<Leader>be"] = map_cr("BufferLineMoveNext"):with_noremap():with_silent():with_desc("Buffer: Move to next"),
		-- ["n|<Leader>bn"] = map_cr("BufferLineCycleNext"):with_noremap():with_silent():with_desc("Buffer: Switch to next"),
		-- ["n|<Leader>bu"] = map_cr("BufferLineCyclePrev"):with_noremap():with_silent():with_desc("Buffer: Switch to prev"),
		-- ["n|<Leader>bo"] = map_cr("BufferLineCloseOthers"):with_noremap():with_silent():with_desc("Buffer: Close others"),
		["n|<Leader>bo"] = map_callback(Buffer_close_others)
			:with_noremap()
			:with_silent()
			:with_desc("Buffer: Close others"),
		["n|<Leader>bn"] = map_cu(":enew"):with_noremap():with_silent():with_desc("Buffer: New"),
		["n|<Leader>nn"] = map_cu(":enew"):with_noremap():with_silent():with_desc("Buffer: New"),
		["n|<Leader>jl"] = map_cmd("<C-6>"):with_noremap():with_silent():with_desc("Buffer: Goto latest"),
		["n|<D-n>"] = map_cu(":enew"):with_noremap():with_silent():with_desc("Buffer: New"),
		["n|<D-1>"] = map_cr("BufferLineGoToBuffer 1"):with_noremap():with_silent():with_desc("buffer: Goto first"),
		["n|<D-9>"] = map_cr("BufferLineGoToBuffer last"):with_noremap():with_silent():with_desc("buffer: Goto last"),
		["n|<D-j>"] = map_cr("BufferLineCycleNext"):with_noremap():with_silent():with_desc("Buffer: Switch to next"),
		["n|<D-k>"] = map_cr("BufferLineCyclePrev"):with_noremap():with_silent():with_desc("Buffer: Switch to prev"),
		["n|<D-l>"] = map_cr("BufferLineMoveNext"):with_noremap():with_silent():with_desc("Buffer: Move to next"),
		["n|<D-u>"] = map_cr("BufferLineMovePrev"):with_noremap():with_silent():with_desc("Buffer: Move to prev"),

		-- window resize
		["n|<leader>re"] = map_cmd("<C-w>="):with_noremap():with_silent():with_desc("window size reset"),
		["n|<leader>rm"] = map_cmd("<C-w>_<C-w>|"):with_noremap():with_silent():with_desc("window size max"),
		-- window focus
		["n|<leader>wh"] = map_cmd("<C-w>h"):with_noremap():with_desc("window: Focus left"),
		["n|<leader>wl"] = map_cmd("<C-w>l"):with_noremap():with_desc("window: Focus right"),
		["n|<leader>wj"] = map_cmd("<C-w>j"):with_noremap():with_desc("window: Focus down"),
		["n|<leader>wk"] = map_cmd("<C-w>k"):with_noremap():with_desc("window: Focus up"),
		["n|<leader>ww"] = map_cmd("<C-w>w"):with_noremap():with_desc("window: Focus least"),
		-- Plugin: smart-splits.nvim
		["n|<leader>wv"] = map_cmd("<C-w>v<C-^>"):with_noremap():with_silent():with_desc("window horizon"),
		["n|<leader>ws"] = map_cmd("<C-w>s<C-^>"):with_noremap():with_silent():with_desc("window split"),
		["n|<leader>wJ"] = map_cu("SmartSwapDown")
			:with_silent()
			:with_noremap()
			:with_desc("window: Move window downward"),
		["n|<leader>wK"] = map_cu("SmartSwapUp"):with_silent():with_noremap():with_desc("window: Move window upward"),
		["n|<leader>wH"] = map_cu("SmartSwapLeft")
			:with_silent()
			:with_noremap()
			:with_desc("window: Move window leftward"),
		["n|<leader>wL"] = map_cu("SmartSwapRight")
			:with_silent()
			:with_noremap()
			:with_desc("window: Move window rightward"),
		-- ["n|<leader>wS"] = map_cmd(":split<CR>"):with_noremap():with_silent(),
		-- ["n|<leader>wV"] = map_cmd(":vsplit<CR>"):with_noremap():with_silent(),

		-- Plugin: MiniBufremove
		["n|<C-q>"] = map_cu("lua require('mini.bufremove').delete()")
			:with_noremap()
			:with_silent()
			:with_desc("buffer: Close current"),
		["n|<D-w>"] = map_cu("lua require('mini.bufremove').delete()")
			:with_noremap()
			:with_silent()
			:with_desc("buffer: Close current"),

		-- plugin todo-comments
		["n|<Leader>tl"] = map_cu("TodoTelescope"):with_noremap():with_silent():with_desc("TodoTelescope"),
		["n|<Leader>tn"] = map_cr("lua require('todo-comments').jump_next()")
			:with_noremap()
			:with_silent()
			:with_desc("jump next todo-comments"),
		["n|<Leader>tu"] = map_cr("lua require('todo-comments').jump_prev()")
			:with_noremap()
			:with_silent()
			:with_desc("jump prev todo-comments"),
		["n|[n"] = map_cr("lua require('todo-comments').jump_prev()")
			:with_noremap()
			:with_silent()
			:with_desc("jump prev todo-comments"),
		["n|]n"] = map_cr("lua require('todo-comments').jump_next()")
			:with_noremap()
			:with_silent()
			:with_desc("jump next todo-comments"),

		-- Plugin marks
		["n|<Leader>ml"] = map_cu("MarksListAll"):with_noremap():with_silent():with_desc("Marks: List all "),
		["n|<Leader>bl"] = map_cu("BookmarksListAll"):with_noremap():with_silent():with_desc("Search All Bookmarks"),
	},
}

bind.nvim_load_mapping(mappings.builtins)
bind.nvim_load_mapping(mappings.plugins)

mappings["gitsigns"] = function(bufnr)
	local actions = require("gitsigns.actions")
	return {
		["n|]g"] = map_callback(function()
			if vim.wo.diff then
				return "]g"
			end
			vim.schedule(function()
				actions.next_hunk()
			end)
			return "<Ignore>"
		end)
			:with_buffer(bufnr)
			:with_noremap()
			:with_expr()
			:with_desc("git: Goto next hunk"),
		["n|[g"] = map_callback(function()
			if vim.wo.diff then
				return "[g"
			end
			vim.schedule(function()
				actions.prev_hunk()
			end)
			return "<Ignore>"
		end)
			:with_buffer(bufnr)
			:with_noremap()
			:with_expr()
			:with_desc("git: Goto prev hunk"),
		["n|<leader>hs"] = map_callback(function()
			actions.stage_hunk()
		end)
			:with_buffer(bufnr)
			:with_noremap()
			:with_desc("git: Toggle staging/unstaging of hunk"),
		["v|<leader>hs"] = map_callback(function()
			actions.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)
			:with_buffer(bufnr)
			:with_noremap()
			:with_desc("git: Toggle staging/unstaging of selected hunk"),
		["n|<leader>hx"] = map_callback(function()
			actions.undo_stage_hunk()
		end)
			:with_buffer(bufnr)
			:with_desc("git: Undo stage hunk"),
		["n|<leader>hr"] = map_callback(function()
			actions.reset_hunk()
		end)
			:with_buffer(bufnr)
			:with_noremap()
			:with_desc("git: Reset hunk"),
		["v|<leader>hr"] = map_callback(function()
			actions.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)
			:with_buffer(bufnr)
			:with_noremap()
			:with_desc("git: Reset hunk"),
		["n|<leader>hR"] = map_callback(function()
			actions.reset_buffer()
		end)
			:with_buffer(bufnr)
			:with_noremap()
			:with_desc("git: Reset buffer"),
		["n|<leader>hv"] = map_callback(function()
			actions.preview_hunk()
		end)
			:with_buffer(bufnr)
			:with_noremap()
			:with_desc("git: Preview hunk"),
		["n|<leader>hb"] = map_callback(function()
			actions.blame_line({ full = true })
		end)
			:with_buffer(bufnr)
			:with_noremap()
			:with_desc("git: Blame line"),
		["ox|ih"] = map_callback(function()
			actions.select_hunk()
		end)
		:with_buffer(bufnr)
		:with_noremap(),
	}

end

return mappings
