local bind = require("keymap.bind")
local settings = require("user.settings")
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
-- local map_cr = bind.map_cr
-- local map_cu = bind.map_cu

-- [[ Neovide font_size scale Keymaps
if vim.g.neovide then
	vim.g.gui_font_size = 16
	vim.g.neovide_scale_factor = 1.0

	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end
	vim.keymap.set("n", "<D-C-=>", function()
		change_scale_factor(1.25)
	end)
	vim.keymap.set("n", "<D-C-->", function()
		change_scale_factor(1 / 1.25)
	end)

	-- Put anything you want to happen only in Neovide here
	RefreshGuiFont = function()
		vim.opt.guifont = string.format("%s:h%s", settings.gui_config.gui_font_face, vim.g.gui_font_size)
	end

	ResizeGuiFont = function(delta)
		vim.g.gui_font_size = vim.g.gui_font_size + delta
		RefreshGuiFont()
	end

	local kopts = { noremap = true, silent = true }

	vim.keymap.set({ "n", "i" }, "<D-0>", function()
		vim.g.gui_font_size = settings.gui_config.font_size
		RefreshGuiFont()
	end, kopts)

	vim.keymap.set({ "n", "i" }, "<D-=>", function()
		ResizeGuiFont(1)
	end, kopts)

	vim.keymap.set({ "n", "i" }, "<D-->", function()
		ResizeGuiFont(-1)
	end, kopts)
end
-- Neovide font_size scale Keymaps ]]

local core_map = {

	-- insert blankline to up/down without leave cursor
	["n|[<Space>"] = map_cmd(":<C-u> put! =repeat(nr2char(10), 1) <Bar> ']+1<CR>")
		:with_noremap()
		:with_silent()
		:with_desc("add blankline to before"),
	["n|]<Space>"] = map_cmd([[:<C-u> put =repeat(nr2char(10), 1) <Bar> '[-1<CR>]])
		:with_noremap()
		:with_silent()
		:with_desc("add blankline to after"),

	-- highlight word under the cursor without moved
	["n|<leader>hw"] = map_cmd([[:let @/ = expand('<cword>')|set hlsearch<C-M>]])
		:with_noremap()
		:with_silent()
		:with_desc("highlight cursor word"),
	["n|<leader>hW"] = map_cmd([[:let @/ = '\<'.expand('<cword>').'\>'|set hlsearch<C-M>]])
		:with_noremap()
		:with_silent()
		:with_desc("highlight cursor word"),
	["n|<leader>nl"] = map_cmd([[:nohl<cr>]]):with_noremap():with_silent():with_desc("nohlsearch"),

	-- Substitute current search kw to null
	["n|<leader>sN"] = map_cmd(":%s///g<CR>"):with_noremap():with_silent():with_desc("Substitute all kw"),

	["n|<leader>sb"] = map_cmd(":source %:p<CR>"):with_noremap():with_silent():with_desc("source buffer config"),
	-- like `gv`, select the last pasted region, useful
	["n|<leader>sv"] = map_cmd('"`[" . strpart(getregtype(), 0, 1) . "`]"')
		:with_noremap()
		:with_expr()
		:with_desc("select last pasted region"),

	["nx|p"] = map_cmd([[<Plug>(YankyPutAfter)]]):with_noremap():with_silent(),
	["nx|P"] = map_cmd([[<Plug>(YankyPutBefore)]]):with_noremap():with_silent(),
	["nx|gp"] = map_cmd([[<Plug>(YankyGPutAfter)]]):with_noremap():with_silent():with_desc("yanky put after"),
	["nx|gP"] = map_cmd([[<Plug>(YankyGPutBefore)]]):with_noremap():with_silent():with_desc("yanky put before"),

	-- useful, for keep indent
	["n|=p"] = map_cmd([[<Plug>(YankyPutAfterFilter)]]):with_noremap():with_silent(),
	["n|=P"] = map_cmd([[<Plug>(YankyPutBeforeFilter)]]):with_noremap():with_silent(),

	["n|cvj"] = map_cmd([[<Plug>(YankyCycleForward)]]):with_noremap():with_silent(),
	["n|cvk"] = map_cmd([[<Plug>(YankyCycleBackward)]]):with_noremap():with_silent(),

	-- Replacing up to next underscore `_`
	["n|cu"] = map_cmd("ct_"):with_noremap():with_silent(),
	["n|ch"] = map_cmd("cT_"):with_noremap():with_silent(),
	["n|du"] = map_cmd("dt_"):with_noremap():with_silent(),
	["n|dh"] = map_cmd("dT_"):with_noremap():with_silent(),
	["n|x"] = map_cmd('"_x'):with_noremap():with_silent(),

	["nvo|H"] = map_cmd("^"),
	["nvo|L"] = map_cmd("g_"),
	["n|Q"] = map_cmd("<Nop>"):with_noremap():with_desc("Noq Q"),
	["n|Y"] = map_cmd("y$"):with_desc("edit: Yank text to EOL"),
	["n|D"] = map_cmd("d$"):with_desc("edit: Delete text to EOL"),
	["n|J"] = map_cmd("m'J`'"):with_noremap():with_desc("Join line"),
	["n|W"] = map_cmd("i<CR><esc>`["):with_noremap():with_desc("Wrap line"),
	["n|n"] = map_cmd("nzzzv"):with_noremap():with_desc("edit: Next search result"),
	["n|N"] = map_cmd("Nzzzv"):with_noremap():with_desc("edit: Prev search result"),
	-- ["n|<S-Tab>"] = map_cr("normal za"):with_noremap():with_silent():with_desc("edit: Toggle code fold"),
	["n|<Esc>"] = map_callback(function()
			Flash_esc_or_noh()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("edit: Clear search highlight"),

	-- buffer file save or quit
	["n|<leader>x"] = map_cmd(":x<CR>"):with_noremap():with_silent():with_desc("Quit buffers"),
	["n|<leader>q"] = map_cmd(":q<CR>"):with_noremap():with_silent():with_desc("Quit window"),
	["n|<leader>wa"] = map_cmd(":wall!<CR>"):with_noremap():with_silent():with_desc("Save buffers"),

	-- locallist & quicklist
	["n|<leader>lo"] = map_cmd(":lopen<CR>"):with_noremap():with_silent():with_desc("open locallist"),
	["n|<leader>lc"] = map_cmd(":lclose<CR>"):with_noremap():with_silent():with_desc("close locallist"),
	["n|<leader>cl"] = map_cmd(":lclose<CR>"):with_noremap():with_silent():with_desc("close locallist"),
	["n|<leader>cc"] = map_cmd(":cclose<CR>"):with_noremap():with_silent():with_desc("close quicklist"),
	["n|<leader>cq"] = map_cmd(":copen<CR>"):with_noremap():with_silent():with_desc("open quicklist"),
	["n|<leader>cg"] = map_cmd([[:grep '' % |copen<C-Left><C-Left><C-Left><Right>]])
		:with_noremap()
		:with_desc("grep kw into copen"),

	-- like MacVim
	["n|<D-f>"] = map_cmd("/"):with_noremap(),
	["n|<D-s>"] = map_cmd("<Cmd>w<CR>"):with_noremap(),
	["n|<D-v>"] = map_cmd([[<Plug>(YankyPutAfterFilter)]]):with_noremap():with_silent(),
	["t|<D-v>"] = map_cmd([[<C-\><C-n>"+pa]]):with_noremap():with_silent(),
	["v|<D-v>"] = map_cmd("<C-R>+"):with_noremap():with_silent(),
	["c|<D-v>"] = map_cmd("<C-R>+"):with_noremap(),
	["i|<D-v>"] = map_cmd("<C-R>+"):with_desc("pasted text"),
	["i|<D-f>"] = map_cmd("<C-O>/"):with_desc("search word"),
	["i|<D-z>"] = map_cmd("<C-O>u"):with_desc("revert last change"),
	["i|<D-d>"] = map_cmd("<C-O>dw"):with_desc("delete cursor word"),
	["i|<D-s>"] = map_cmd("<Esc>:w<CR>"):with_desc("edit: Save file"),

	-- Insert mode
	-- ["i|<C-s>"] = map_cmd("<Esc>:w<CR>"):with_desc("edit: Save file"),
	["i|<C-a>"] = map_cmd("<Esc>^i"):with_noremap():with_desc("edit: Move cursor to line start"),
	["i|<C-l>"] = map_cmd("<Esc>$a"):with_noremap():with_desc("edit: Move cursor to line end"),
	["i|<C-x>o"] = map_cmd("<Esc><C-w>o"):with_noremap(),
	["i|<C-x>x"] = map_cmd("<Esc><C-w>o"):with_noremap(),
	["i|<C-x>s"] = map_cmd("<Esc><C-w>r"):with_noremap(),
	["i|<C-x>j"] = map_cmd("<Esc><C-w>j"):with_noremap(),
	["i|<C-x>w"] = map_cmd("<Esc><C-w>w"):with_noremap(),
	["i|<C-x>e"] = map_cmd("<Esc><C-w>="):with_noremap(),
	["i|<C-x>m"] = map_cmd("<Esc><C-w>_"):with_noremap(),
	["i|<C-x>k"] = map_cmd("<Esc>lC"):with_noremap(),
	["i|<C-x>d"] = map_cmd("<Esc>dda"):with_noremap(),
	["i|<C-x>z"] = map_cmd("<Esc>zza"):with_noremap(),
	["i|<C-x>h"] = map_cmd("<Esc>m'*`'a"):with_noremap(),
	["i|<C-x>u"] = map_cmd("<Esc>m'gUiw`'a"):with_noremap(),
	["i|<C-x>l"] = map_cmd("<Esc>m'guiw`'a"):with_noremap(),
	["i|<C-x>r"] = map_cmd("<Esc>:SnipRun<CR>"):with_noremap(),
	["i|<C-x>t"] = map_cmd("<Esc>:ToggleTerm<CR>"):with_noremap(),
	["i|<C-x>b"] = map_cmd("<Esc>:BufferLinePick<CR>"):with_noremap(),
	["i|<C-x>a"] = map_cmd("<Esc>:ToggleAlternate<CR>"):with_noremap(),
	["i|<C-x>f"] = map_cmd("<Esc>:Telescope current_buffer_fuzzy_find<CR>"):with_noremap(),

	["t|<D-b>"] = map_cmd("<C-Left>"):with_noremap():with_silent(),
	["t|<D-f>"] = map_cmd("<C-Right>"):with_noremap():with_silent(),
	["t|<D-C-h>"] = map_cmd("<Cmd>wincmd h<CR>"):with_silent():with_noremap():with_desc("window: Focus left"),
	["t|<D-C-l>"] = map_cmd("<Cmd>wincmd l<CR>"):with_silent():with_noremap():with_desc("window: Focus right"),
	["t|<D-C-j>"] = map_cmd("<Cmd>wincmd j<CR>"):with_silent():with_noremap():with_desc("window: Focus down"),
	["t|<D-C-k>"] = map_cmd("<Cmd>wincmd k<CR>"):with_silent():with_noremap():with_desc("window: Focus up"),
	["t|<D-C-w>"] = map_cmd([[<C-\><C-n><C-w>w]]):with_noremap():with_silent(),
	["t|<D-C-t>"] = map_cmd([[<C-\><C-n><C-w>t]]):with_noremap():with_silent(),
	["t|<D-C-b>"] = map_cmd([[<C-\><C-n><C-w>b]]):with_noremap():with_silent(),
	["t|<D-C-m>"] = map_cmd([[<C-\><C-n><C-w>_]]):with_noremap():with_silent(),
	["t|<D-C-c>"] = map_cmd([[<C-\><C-n><C-w>t:]]):with_noremap(),

	-- Command mode
	["c|<D-b>"] = map_cmd("<C-Left>"):with_noremap(),
	["c|<D-f>"] = map_cmd("<C-Right>"):with_noremap(),
	["c|<C-b>"] = map_cmd("<Left>"):with_noremap():with_desc("edit: Left"),
	["c|<C-f>"] = map_cmd("<Right>"):with_noremap():with_desc("edit: Right"),
	["c|<C-a>"] = map_cmd("<Home>"):with_noremap():with_desc("edit: Home"),
	["c|<C-e>"] = map_cmd("<End>"):with_noremap():with_desc("edit: End"),
	["c|<C-d>"] = map_cmd("<Del>"):with_noremap():with_desc("edit: Delete"),
	["c|<C-h>"] = map_cmd("<BS>"):with_noremap():with_desc("edit: Backspace"),
	["c|<C-t>"] = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]])
		:with_noremap()
		:with_desc("edit: Complete path of current file"),
	["c|SW!"] = map_cmd("execute 'silent! write !sudo tee % >/dev/null' <bar> edit!"),

	-- Visual mode
	["v|<"] = map_cmd("<gv"):with_desc("edit: Decrease indent"),
	["v|>"] = map_cmd(">gv"):with_desc("edit: Increase indent"),
}

bind.nvim_load_mapping(core_map)
