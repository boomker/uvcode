require("user.keymap.helpers")
local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback

local plug_map = {

	["n|<Leader>sc"] = map_cu("Telescope colorscheme"):with_noremap():with_silent():with_desc("ui: Change colorscheme"),

	-- Bufferline
	["n|<Leader>k"] = map_cr("BufferLinePick"):with_noremap():with_silent():with_desc("Pick buffer"),
	-- ["n|<Leader>bw"] = map_cr("BufferLineMovePrev"):with_noremap():with_silent():with_desc("Buffer: Move to prev"),
	-- ["n|<Leader>be"] = map_cr("BufferLineMoveNext"):with_noremap():with_silent():with_desc("Buffer: Move to next"),
	-- ["n|<Leader>bn"] = map_cr("BufferLineCycleNext"):with_noremap():with_silent():with_desc("Buffer: Switch to next"),
	-- ["n|<Leader>bu"] = map_cr("BufferLineCyclePrev"):with_noremap():with_silent():with_desc("Buffer: Switch to prev"),
    -- ["n|<Leader>bo"] = map_cr("BufferLineCloseOthers"):with_noremap():with_silent():with_desc("Buffer: Close others"),
    ["n|<Leader>bo"] = map_callback(Buffer_close_others):with_noremap():with_silent():with_desc("Buffer: Close others"),
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
}

local mappings = {}
mappings["gitsigns"] = function(buf)
    local actions = require("gitsigns.actions")
	return {
		["n|]g"] = bind.map_callback(function()
			if vim.wo.diff then
				return "]g"
			end
			vim.schedule(function()
				actions.next_hunk()
			end)
			return "<Ignore>"
		end)
			:with_buffer(buf)
			:with_expr()
			:with_desc("git: Goto next hunk"),
		["n|[g"] = bind.map_callback(function()
			if vim.wo.diff then
				return "[g"
			end
			vim.schedule(function()
				actions.prev_hunk()
			end)
			return "<Ignore>"
		end)
			:with_buffer(buf)
			:with_expr()
			:with_desc("git: Goto prev hunk"),
		["n|<leader>hs"] = bind.map_callback(function()
			actions.stage_hunk()
		end)
			:with_buffer(buf)
			:with_desc("git: Stage hunk"),
		["v|<leader>hs"] = bind.map_callback(function()
			actions.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)
			:with_buffer(buf)
			:with_desc("git: Stage hunk"),
		["n|<leader>hx"] = bind.map_callback(function()
			actions.undo_stage_hunk()
		end)
			:with_buffer(buf)
			:with_desc("git: Undo stage hunk"),
		["n|<leader>hr"] = bind.map_callback(function()
			actions.reset_hunk()
		end)
			:with_buffer(buf)
			:with_desc("git: Reset hunk"),
		["v|<leader>hr"] = bind.map_callback(function()
			actions.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)
			:with_buffer(buf)
			:with_desc("git: Reset hunk"),
		["n|<leader>hR"] = bind.map_callback(function()
			actions.reset_buffer()
		end)
			:with_buffer(buf)
			:with_desc("git: Reset buffer"),
		["n|<leader>hv"] = bind.map_callback(function()
			actions.preview_hunk()
		end)
			:with_buffer(buf)
			:with_desc("git: Preview hunk"),
		["n|<leader>hb"] = bind.map_callback(function()
			actions.blame_line({ full = true })
		end)
			:with_buffer(buf)
			:with_desc("git: Blame line"),
	}
end

bind.nvim_load_mapping(plug_map)

return mappings
