local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback

-- Place global keymaps here.
local mappings = {
	-- format
	fmt = {
		["n|<Leader>ft"] = map_cmd("<Cmd>FormatToggle<CR>"):with_noremap():with_desc("Formater: Toggle format on save"),
		["n|<Leader>fm"] = map_cmd("<Cmd>Format<CR>"):with_noremap():with_desc("formatter: Format buffer manually"),
		-- ["nx|<Leader>fm"] = map_cr("lua vim.lsp.buf.format()"):with_noremap():with_silent():with_desc("Formater: buffer"),
	},
	-- mason
	mason = {
		["n|<Leader>ms"] = map_cr("Mason"):with_silent():with_noremap():with_nowait():with_desc("mason: Show"),
		["n|<Leader>mu"] = map_cr("MasonUpdate"):with_silent():with_noremap():with_nowait():with_desc("mason: Update"),
	},
}

bind.nvim_load_mapping(mappings.fmt)
bind.nvim_load_mapping(mappings.mason)

--- The following code allows this file to be exported ---
---    for use with LSP lazy-loaded keymap bindings    ---

---@param buf integer
mappings["lsp"] = function(buf)
	return {
		-- LSP-related keymaps, ONLY effective in buffers with LSP(s) attached
		["n|<leader>li"] = map_cr("LspInfo"):with_silent():with_buffer(buf):with_desc("lsp: Info"),
		["n|<leader>lr"] = map_cr("LspRestart"):with_silent():with_buffer(buf):with_nowait():with_desc("lsp: Restart"),
		["n|<leader>ll"] = map_cr("Lspsaga show_line_diagnostics ++unfocus")
			:with_silent()
			:with_buffer(buf)
			:with_desc("lsp: Line diagnostic"),
		["n|[e"] = map_cr("Lspsaga diagnostic_jump_prev"):with_buffer(buf):with_desc("lsp: Prev diagnostic"),
		["n|]e"] = map_cr("Lspsaga diagnostic_jump_next"):with_buffer(buf):with_desc("lsp: Next diagnostic"),

		["n|go"] = map_cr("Trouble symbols toggle win.position=right")
			:with_silent()
			:with_buffer(buf)
			:with_desc("lsp: Toggle outline"),
		["n|gh"] = map_callback(function()
			vim.lsp.buf.signature_help()
		end):with_desc("lsp: Signature help"),
		["n|gR"] = map_cr("Glance references"):with_silent():with_buffer(buf):with_desc("lsp: Show reference"),
		["n|<Leader>ru"] = map_cr("Glance references"):with_silent():with_buffer(buf):with_desc("lsp: Show reference"),
		-- ["n|<Leader>rn"] = map_cr("lua vim.lsp.buf.rename()"):with_buffer(buf):with_desc("lsp: Rename in file range"),
		["n|<Leader>rn"] = map_cr("Lspsaga rename")
			:with_silent()
			:with_nowait()
			:with_buffer(buf)
			:with_desc("lsp: Rename in file range"),
		["n|<Leader>rp"] = map_cr("Lspsaga rename ++project")
			:with_silent()
			:with_buffer(buf)
			:with_desc("lsp: Rename in project range"),
		["nv|<Leader>ca"] = map_cr("Lspsaga code_action"):with_buffer(buf):with_desc("lsp: Code action for cursor"),
		["n|<Leader>cd"] = map_cr("Lspsaga show_cursor_diagnostics")
			:with_buffer(buf)
			:with_desc("lsp: Cursor diagnostic"),
		["n|K"] = map_cr("Lspsaga hover_doc"):with_silent():with_buffer(buf):with_desc("lsp: Show doc"),
		["nv|ga"] = map_cr("Lspsaga code_action")
			:with_silent()
			:with_buffer(buf)
			:with_desc("lsp: Code action for cursor"),
		["n|gd"] = map_cr("Glance definitions"):with_silent():with_buffer(buf):with_desc("lsp: Preview definition"),
		["n|gD"] = map_cr("Lspsaga goto_definition"):with_silent():with_buffer(buf):with_desc("lsp: Goto definition"),
		["n|gm"] = map_cr("Glance implementations")
			:with_silent()
			:with_buffer(buf)
			:with_desc("lsp: Show implementation"),
		["n|gci"] = map_cr("Lspsaga incoming_calls")
			:with_silent()
			:with_buffer(buf)
			:with_desc("lsp: Show incoming calls"),
		["n|gco"] = map_cr("Lspsaga outgoing_calls")
			:with_silent()
			:with_buffer(buf)
			:with_desc("lsp: Show outgoing calls"),
		["n|<leader>tb"] = map_callback(function()
				_toggle_virtualtext()
			end)
			:with_noremap()
			:with_silent()
			:with_desc("edit: Toggle virtual text display of current buffer"),
		["n|<leader>th"] = map_callback(function()
				_toggle_inlayhint()
			end)
			:with_noremap()
			:with_silent()
			:with_desc("edit: Toggle inlay hints display of current buffer"),
	}
end

return mappings
