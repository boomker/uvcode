return function()
	local colors = require("modules.utils").get_palette()
	local floatborder_hl = require("modules.utils").hl_to_rgb("FloatBorder", false, colors.blue)
    function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        -- vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        -- vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        -- vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        -- vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

	require("toggleterm").setup({
		-- size can be a number or function which is passed the current terminal
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.40
			end
		end,
		on_open = function()
			-- Prevent infinite calls from freezing neovim.
			-- Only set these options specific to this terminal buffer.
			vim.api.nvim_set_option_value("foldmethod", "manual", { scope = "local" })
			vim.api.nvim_set_option_value("foldexpr", "0", { scope = "local" })
		end,
		highlights = {
			FloatBorder = {
				guifg = floatborder_hl,
			},
		},
		open_mapping = false, -- [[<c-\>]],
		hide_numbers = true, -- hide the number column in toggleterm buffers
		shade_filetypes = {},
		shade_terminals = false,
		shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
		start_in_insert = true,
		insert_mappings = true, -- whether or not the open mapping applies in insert mode
		persist_size = true,
		direction = "horizontal",
		close_on_exit = true, -- close the terminal window when the process exits
		shell = vim.o.shell, -- change the default shell
	})
end
