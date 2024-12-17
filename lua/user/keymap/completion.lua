local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback

local mappings = {}

-- Place global keymaps here.
local plug_map = {
	-- format
	["n|<Leader>ft"] = map_cmd("<Cmd>FormatToggle<CR>"):with_noremap():with_desc("Formater: Toggle format on save"),
    ["n|<Leader>fm"] = map_cmd("<Cmd>Format<CR>"):with_noremap():with_desc("formatter: Format buffer manually"),
	-- ["nx|<Leader>fm"] = map_cr("lua vim.lsp.buf.format()"):with_noremap():with_silent():with_desc("Formater: buffer"),

	-- mason
	["n|<Leader>ms"] = map_cr("Mason"):with_silent():with_noremap():with_nowait():with_desc("mason: Show"),
	["n|<Leader>mu"] = map_cr("MasonUpdate"):with_silent():with_noremap():with_nowait():with_desc("mason: Update"),
}

-- NOTE: This function is special! Keymaps defined here are ONLY effective in buffers with LSP(s) attached
-- NOTE: Make sure to include `:with_buffer(buf)` to limit the scope of your mappings.
---@param buf number @The effective bufnr
mappings["lsp"] = function(buf)
	return {
		["n|[e"] = map_cr("Lspsaga diagnostic_jump_prev"):with_buffer(buf):with_desc("lsp: Prev diagnostic"),
		["n|]e"] = map_cr("Lspsaga diagnostic_jump_next"):with_buffer(buf):with_desc("lsp: Next diagnostic"),

		["n|gh"] = map_callback(function()
			vim.lsp.buf.signature_help()
		end):with_desc("lsp: Signature help"),
		["n|gR"] = map_cr("Glance references"):with_silent():with_buffer(buf):with_desc("lsp: Show reference"),
		["n|<Leader>ru"] = map_cr("Glance references"):with_silent():with_buffer(buf):with_desc("lsp: Show reference"),
		["n|<Leader>rn"] = map_cr("lua vim.lsp.buf.rename()"):with_buffer(buf):with_desc("lsp: Rename in file range"),
		-- ["n|<Leader>rn"] = map_cr("Lspsaga rename"):with_buffer(buf):with_desc("lsp: Rename in file range"),
		["n|<Leader>rp"] = map_cr("Lspsaga rename ++project")
			:with_buffer(buf)
			:with_desc("lsp: Rename in project range"),
		["nv|<Leader>ca"] = map_cr("Lspsaga code_action"):with_buffer(buf):with_desc("lsp: Code action for cursor"),
		["n|<Leader>cd"] = map_cr("Lspsaga show_cursor_diagnostics")
			:with_buffer(buf)
			:with_desc("lsp: Cursor diagnostic"),
		["n|<leader>ll"] = map_cr("Lspsaga show_line_diagnostics ++unfocus")
			:with_silent()
			:with_buffer(buf)
			:with_desc("lsp: Line diagnostic"),
		["n|<leader>lx"] = map_cr("Lspsaga show_line_diagnostics ++unfocus")
			:with_silent()
			:with_buffer(buf)
			:with_desc("lsp: Line diagnostic"),
		--[[
        ["n|gr"] = map_cr("Lspsaga rename"):with_buffer(buf):with_desc("lsp: Rename in file range"),
		["n|gR"] = map_cr("Lspsaga rename ++project")
			:with_buffer(buf)
			:with_desc("lsp: Rename in project range"),
        --]]
	}
end

bind.nvim_load_mapping(plug_map)
return mappings
