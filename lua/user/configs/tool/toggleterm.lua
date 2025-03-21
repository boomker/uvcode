return function()
	vim.cmd([[
      autocmd TermEnter term://*toggleterm#* set signcolumn=no
      autocmd TermEnter term://*toggleterm#* set winfixbuf
    ]])
	require("modules.utils").load_plugin("toggleterm", {
		-- size can be a number or function which is passed the current terminal
		size = function(term)
			if term.direction == "horizontal" then
				return vim.o.lines * 0.30
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
			Normal = {
				link = "Normal",
			},
			NormalFloat = {
				link = "NormalFloat",
			},
			FloatBorder = {
				link = "FloatBorder",
			},
		},
		hide_numbers = true, -- hide the number column in toggleterm buffers
		open_mapping = false, -- [[<c-\>]],
		persist_mode = false,
		persist_size = true,
		close_on_exit = true, -- close the terminal window when the process exits
		start_in_insert = true,
		insert_mappings = true, -- whether or not the open mapping applies in insert mode
		shade_terminals = false,
		shade_filetypes = {},
		shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
		direction = "horizontal",
		float_opts = { border = "rounded", winblend = 5 },
		shell = vim.o.shell, -- change the default shell
	})
end
