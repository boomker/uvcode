local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cmd = bind.map_cmd

local mappings = {}

-- Place global keymaps here.
local plug_map = {
	["n|<leader>tF"] = map_cmd("<Cmd>FormatToggle<CR>"):with_noremap():with_desc("Formater: Toggle format on save"),
	["nx|<leader>cf"] = map_cr("lua vim.lsp.buf.format()"):with_noremap():with_silent():with_desc("format buffer"),
}

-- NOTE: This function is special! Keymaps defined here are ONLY effective in buffers with LSP(s) attached
-- NOTE: Make sure to include `:with_buffer(buf)` to limit the scope of your mappings.
---@param buf number @The effective bufnr
mappings["lsp"] = function(buf)
	return {
		["n|K"] = map_cr("Lspsaga hover_doc"):with_buffer(buf):with_desc("lsp: Show doc"),
		["n|[d"] = map_cr("Lspsaga diagnostic_jump_prev"):with_buffer(buf):with_desc("lsp: Prev diagnostic"),
		["n|]d"] = map_cr("Lspsaga diagnostic_jump_next"):with_buffer(buf):with_desc("lsp: Next diagnostic"),

		["n|<leader>st"] = map_cr("Lspsaga show_cursor_diagnostics")
			:with_buffer(buf)
			:with_desc("lsp: Cursor diagnostic"),
		-- ["n|<leader>rn"] = map_cr("Lspsaga rename"):with_buffer(buf):with_desc("lsp: Rename in file range"),
		["n|<leader>rn"] = map_cr("lua vim.lsp.buf.rename()"):with_buffer(buf):with_desc("lsp: Rename in file range"),
		-- ["n|<leader>rN"] = map_cr("Lspsaga rename ++project")
		-- 	:with_buffer(buf)
		-- 	:with_desc("lsp: Rename in project range"),
		["nv|<leader>ca"] = map_cr("Lspsaga code_action"):with_buffer(buf):with_desc("lsp: Code action for cursor"),
	}
end

bind.nvim_load_mapping(plug_map)
return mappings
