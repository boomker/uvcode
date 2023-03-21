return function()
		vim.cmd([[
	        highlight HopNextKey  guifg=#ff007c gui=bold ctermfg=198 cterm=bold
	        highlight HopNextKey1 guifg=#00dfff gui=bold ctermfg=45 cterm=bold
	        highlight HopNextKey2 guifg=#2b8db3 ctermfg=33
	        highlight HopUnmatched guifg=#666666 guibg=bg guisp=#666666 ctermfg=242
	        highlight link HopCursor Cursor

	        augroup HopInitHighlight
	            autocmd!
	            autocmd ColorScheme * lua require'hop.highlight'.insert_highlights()
	        augroup end
	    ]])

	local hop = require("hop")
	local directions = require("hop.hint").HintDirection
    vim.keymap.set("", "ff", function()
		hop.hint_char1({ direction = nil, current_line_only = false })
    end, { remap = true })

    vim.keymap.set("", "fh", function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
	end, { remap = true })

    vim.keymap.set("", "fj", function()
		hop.hint_lines({ direction = directions.AFTER_CURSOR, current_line_only = false })
	end, { remap = true })

	vim.keymap.set("", "fk", function()
		hop.hint_lines({ direction = directions.BEFORE_CURSOR, current_line_only = false })
	end, { remap = true })

    vim.keymap.set("", "fl", function()
        hop.hint_words({ current_line_only = true })
    end, { remap = true })

	vim.keymap.set("", "fu", function()
		hop.hint_words({ direction = directions.BEFORE_CURSOR, current_line_only = false })
	end, { remap = true })

    vim.keymap.set("", "fd", function()
		hop.hint_words({ direction = directions.AFTER_CURSOR, current_line_only = false })
	end, { remap = true })

	-- vim.keymap.set("", "f", function()
	-- 	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
	-- end, { remap = true })
	vim.keymap.set("", "F", function()
		hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
	end, { remap = true })
	vim.keymap.set("", "t", function()
		hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
	end, { remap = true })
	vim.keymap.set("", "T", function()
		hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
	end, { remap = true })

	hop.setup({
		keys = "dsfnmweriouhvcxztybgajkl",
		quit_key = "<esc>",
		char2_fallback_key = "<esc>",
		teasing = false, -- Don't display annoying error message
		multi_windows = false,
	})
end
