local options = {
	autochdir = true,
	expandtab = true,
	winblend = 10,
	scrolloff = 5,
	softtabstop = 4,
	sidescrolloff = 5,
	-- laststatus = 2,
}

vim.g.python_host_prog = "~/.pyvenvs/neovim/.venv/bin/python"
vim.g.python3_host_prog = "~/.pyvenvs/neovim/.venv/bin/python3"
return options
