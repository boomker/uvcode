local options = {
	autochdir = true,
	expandtab = true,
	scrolloff = 5,
	laststatus = 2,
	softtabstop = 4,
	sidescrolloff = 5,
}

vim.g.python_host_prog = "~/.venv/bin/python"
vim.g.python3_host_prog = "~/.venv/bin/python3"
return options
