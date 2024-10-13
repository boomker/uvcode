local options = {
	autochdir = true,
	expandtab = true,
    winblend = 10,
	scrolloff = 5,
	-- laststatus = 2,
	softtabstop = 4,
	sidescrolloff = 5,
}

vim.g.python_host_prog = "~/.pyvenvs/global/.venv/bin/python"
vim.g.python3_host_prog = "~/.pyvenvs/global/.venv/bin/python3"
return options
