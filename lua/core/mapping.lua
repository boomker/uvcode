local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
-- local map_callback = bind.map_callback

local core_map = {

	-- fold
	["n|<leader>zz"] = map_cmd(":set foldmethod=indent<CR>@=((foldclosed(line('.')) < 0) ? 'zc' : 'zv')<CR>")
		:with_noremap()
		:with_silent(),
	["n|<leader>zo"] = map_cmd(":set foldmethod=indent<CR>@=((foldclosed(line('.')) < 0) ? 'zc' : 'zO')<CR>")
		:with_noremap()
		:with_silent(),
	["n|<leader>zm"] = map_cmd(":set fdm=indent<CR>@=((foldclosed(line('.')) < 0) ? 'zMzz' : 'zMzOzz')<CR>")
		:with_noremap()
		:with_silent(),

	-- insert blankline to up/down without leave cursor
	["n|[<Space>"] = map_cmd(":<C-u> put! =repeat(nr2char(10), 1) <Bar> ']+1<CR>"):with_noremap():with_silent(),
	["n|]<Space>"] = map_cmd([[:<C-u> put =repeat(nr2char(10), 1) <Bar> '[-1<CR>]]):with_noremap():with_silent(),

	-- highlight word under the cursor without moved
	["n|<leader>hw"] = map_cmd([[:let @/ = expand('<cword>')|set hlsearch<C-M>]]):with_noremap():with_silent(),
	["n|<leader>hW"] = map_cmd([[:let @/ = '\<'.expand('<cword>').'\>'|set hlsearch<C-M>]])
		:with_noremap()
		:with_silent(),
	["n|<leader>nl"] = map_cmd([[:nohl<cr>]]):with_noremap():with_silent(),

	-- replace with magic by default
	["n|<C-s>"] = map_cmd([[:%s/\v]]):with_noremap(),
	["c|<C-s>"] = map_cmd([[%s/\v]]):with_noremap(),
	["x|<C-s>"] = map_cmd([[:s/\v]]):with_noremap(),

	-- Substitute current search result to null
	["n|<leader>sn"] = map_cmd(":%s//<CR>"):with_noremap():with_silent(),
	["n|<leader>sN"] = map_cmd(":%s///g<CR>"):with_noremap():with_silent(),
	-- ["n|<leader>sl"] = map_cr("setlocal spell! spelllang=en_us"),
	["n|<leader>sb"] = map_cmd(":source %:p<CR>"):with_noremap():with_silent(),
	["n|<leader>se"] = map_cmd(":e $MYVIMRC<CR>"):with_noremap():with_silent(),
	-- select the last pasted region, useful
	["n|<leader>sv"] = map_cmd('"`[" . strpart(getregtype(), 0, 1) . "`]"'):with_noremap():with_expr(),

	["n|Y"] = map_cmd("y$"),
	["n|y"] = map_cmd([[<Plug>(YankyYank)]]):with_noremap():with_silent(),
	["x|y"] = map_cmd([[<Plug>(YankyYank)]]):with_noremap():with_silent(),
	["n|p"] = map_cmd([[<Plug>(YankyPutAfter)]]):with_noremap():with_silent(),
	["x|p"] = map_cmd([[<Plug>(YankyPutAfter)]]):with_noremap():with_silent(),
	["n|P"] = map_cmd([[<Plug>(YankyPutBefore)]]):with_noremap():with_silent(),
	["x|P"] = map_cmd([[<Plug>(YankyPutBefore)]]):with_noremap():with_silent(),
	["n|gp"] = map_cmd([[<Plug>(YankyGPutAfter)]]):with_noremap():with_silent(),
	["x|gp"] = map_cmd([[<Plug>(YankyGPutAfter)]]):with_noremap():with_silent(),
	["n|gP"] = map_cmd([[<Plug>(YankyGPutBefore)]]):with_noremap():with_silent(),
	["x|gP"] = map_cmd([[<Plug>(YankyGPutBefore)]]):with_noremap():with_silent(),

	["n|]p"] = map_cmd([[<Plug>(YankyPutIndentAfterLinewise)]]):with_noremap():with_silent(),
	["n|[p"] = map_cmd([[<Plug>(YankyPutIndentBeforeLinewise)]]):with_noremap():with_silent(),
	["n|]P"] = map_cmd([[<Plug>(YankyPutIndentAfterLinewise)]]):with_noremap():with_silent(),
	["n|[P"] = map_cmd([[<Plug>(YankyPutIndentBeforeLinewise)]]):with_noremap():with_silent(),

	["n|>p"] = map_cmd([[<Plug>(YankyPutIndentAfterShiftRight)]]):with_noremap():with_silent(),
	["n|<p"] = map_cmd([[<Plug>(YankyPutIndentAfterShiftLeft)]]):with_noremap():with_silent(),
	["n|>P"] = map_cmd([[<Plug>(YankyPutIndentBeforeShiftRight)]]):with_noremap():with_silent(),
	["n|<P"] = map_cmd([[<Plug>(YankyPutIndentBeforeShiftLeft)]]):with_noremap():with_silent(),

	-- useful, for keep indent
	["n|=p"] = map_cmd([[<Plug>(YankyPutAfterFilter)]]):with_noremap():with_silent(),
	["n|=P"] = map_cmd([[<Plug>(YankyPutBeforeFilter)]]):with_noremap():with_silent(),

	-- TODO: Yank multi lines not adjacent
	["n|cvj"] = map_cmd([[<Plug>(YankyCycleForward)]]):with_noremap():with_silent(),
	["n|cvk"] = map_cmd([[<Plug>(YankyCycleBackward)]]):with_noremap():with_silent(),
	["n|gcy"] = map_cmd("m'yyp<Plug>(comment_toggle_linewise_current)`'"):with_noremap():with_silent(),

	-- Replacing up to next underscore `_`
	["n|cu"] = map_cmd("ct_"):with_noremap():with_silent(),
	["n|cU"] = map_cmd("vT_c"):with_noremap():with_silent(),
	["n|du"] = map_cmd("dt_"):with_noremap():with_silent(),
	["n|dU"] = map_cmd("vT_d"):with_noremap():with_silent(),
	["n|x"] = map_cmd('"_x'):with_noremap():with_silent(),
	-- ["x|x"] = map_cmd('"_x'):with_noremap():with_silent(),

	["n|H"] = map_cmd("^"),
	["v|H"] = map_cmd("^"),
	["o|H"] = map_cmd("^"),
	["n|L"] = map_cmd("g_"),
	["v|L"] = map_cmd("g_"),
	["o|L"] = map_cmd("g_"),
	["n|D"] = map_cmd("d$"),
	["n|n"] = map_cmd("nzzzv"):with_noremap(),
	["n|N"] = map_cmd("Nzzzv"):with_noremap(),
	["n|*"] = map_cmd("*zz"):with_noremap(),
	["n|#"] = map_cmd("#zz"):with_noremap(),
	["n|J"] = map_cmd("m'J`'"):with_noremap():with_silent(),
	["n|Q"] = map_cmd("<Nop>"):with_noremap(),
	["n|W"] = map_cmd("i<CR><esc>`["):with_silent(),

	-- buffer file save or quit
	["n|<leader>q"] = map_cmd(":quit!<CR>"):with_noremap():with_silent(),
	["n|<leader>S"] = map_cmd(":wall!<CR>"):with_noremap():with_silent(),

	-- quicklist
	["n|<leader>lq"] = map_cmd(":lopen<CR>"):with_noremap():with_silent():with_desc("close quicklist"),
	["n|<leader>lc"] = map_cmd(":lclose<CR>"):with_noremap():with_silent():with_desc("close locallist"),
	["n|<leader>cc"] = map_cmd(":cclose<CR>"):with_noremap():with_silent():with_desc("close quicklist"),
	["n|<leader>cq"] = map_cmd(":copen<CR>"):with_noremap():with_silent():with_desc("Open quicklist"),
	["n|<leader>cg"] = map_cmd([[:grep '' % |copen<C-Left><C-Left><C-Left><Right>]]):with_noremap(),

	-- more like MacVim
	-- ["n|gf"] = map_cmd([[:tabedit <cfile><CR>]]):with_noremap():with_silent(),
	["n|<D-s>"] = map_cu("write"):with_noremap(),
	["n|<D-f>"] = map_cmd("/"):with_noremap():with_silent(),
	["n|<D-v>"] = map_cmd([[<Plug>(YankyPutAfterFilter)]]):with_noremap():with_silent(),
	["v|<D-v>"] = map_cmd("<C-R>+"):with_noremap():with_silent(),
	["c|<D-v>"] = map_cmd("<C-R>+"):with_noremap(),

	-- Insert
	["i|<C-u>"] = map_cmd("<C-G>u<C-U>"):with_noremap(),
	["i|<C-h>"] = map_cmd("<esc>^i"):with_noremap(),
	["i|<C-l>"] = map_cmd("<esc>$a"):with_noremap(),
	["i|<C-x>m"] = map_cmd("<esc><C-w>_<C-w>|"):with_noremap(),
	["i|<C-x>e"] = map_cmd("<esc><C-w>=a"):with_noremap(),
	["i|<C-x>o"] = map_cmd("<esc><C-w>o"):with_noremap(),
	["i|<C-x>x"] = map_cmd("<esc><C-w>r"):with_noremap(),
	["i|<C-x>w"] = map_cmd("<esc><C-w>w"):with_noremap(),
	["i|<C-x>i"] = map_cmd("<esc><C-i>i"):with_noremap(),
	["i|<C-x>d"] = map_cmd("<esc>ddi"):with_noremap(),
	["i|<C-x>r"] = map_cmd("<esc>m':SnipRun<CR>`'a"):with_noremap():with_silent(),
	["i|<C-x>u"] = map_cmd("<esc>m'guiw`'a"):with_noremap(),
	["i|<C-x>h"] = map_cmd("<esc>m'*`'"):with_noremap(),
	["i|<C-x>l"] = map_cmd("<esc>m'O<esc>`'a"):with_noremap(),
	["i|<C-x>n"] = map_cmd("<esc>m'o<esc>`'a"):with_noremap(),
	["i|<C-x>j"] = map_cmd("<esc>Ja"):with_noremap(),
	["i|<C-x>k"] = map_cmd("<cr><esc>`[a"):with_noremap():with_silent(),
	["i|<C-x>c"] = map_cmd("<esc>lC"):with_noremap(),
	["i|<C-x>z"] = map_cmd("<esc>zza"):with_noremap(),
	["i|<C-x>v"] = map_cmd("<esc><Plug>(YankyPutBeforeFilter)`]A"):with_noremap():with_silent(),
	["i|<C-x>b"] = map_cmd("<esc>:BufferLinePick<CR>"):with_noremap():with_silent(),
	["i|<C-x>f"] = map_cmd("<esc>:Telescope current_buffer_fuzzy_find<CR>"):with_noremap():with_silent(),
	["i|<C-x>g"] = map_cmd("<esc>:Telescope grep_string<CR>"):with_noremap():with_silent(),
	["i|<C-x>a"] = map_cmd("<esc>:ToggleAlternate<CR>a"):with_noremap():with_silent(),
	["i|<C-x>t"] = map_cmd("<esc>:execute v:count . 'ToggleTerm direction=float'<CR>"):with_noremap(),

	["i|<D-/>"] = map_cmd("<esc>/"):with_silent(),
	["i|<D-p>"] = map_cmd("<esc>:Telescope buffers<CR>"):with_noremap():with_silent(),
	["i|<D-v>"] = map_cmd("<C-R>+"):with_noremap():with_silent(),
	["i|<D-s>"] = map_cmd("<C-O>:w<CR>"):with_noremap(),
	["i|<D-b>"] = map_cmd("<C-O>b"):with_noremap():with_silent(),
	["i|<D-f>"] = map_cmd("<C-O>w"):with_noremap():with_silent(),
	["i|<D-d>"] = map_cmd("<C-O>diw"):with_noremap():with_silent(),
	["i|<D-z>"] = map_cmd("<C-O>u"):with_noremap():with_silent(),

	-- window
	["n|<D-C-w>"] = map_cmd("<C-w>w"):with_noremap():with_desc("window: Focus least"),
	-- ["n|<D-C-h>"] = map_cmd("<C-w>h"):with_noremap():with_desc("window: Focus left"),
	-- ["n|<D-C-l>"] = map_cmd("<C-w>l"):with_noremap():with_desc("window: Focus right"),
	-- ["n|<D-C-j>"] = map_cmd("<C-w>j"):with_noremap():with_desc("window: Focus down"),
	-- ["n|<D-C-k>"] = map_cmd("<C-w>k"):with_noremap():with_desc("window: Focus up"),
	["n|<leader>wj"] = map_cr("<C-w>J"):with_noremap():with_silent(),
	["n|<leader>wk"] = map_cr("<C-w>K"):with_noremap():with_silent(),
	["n|<leader>wh"] = map_cr("<C-w>H"):with_noremap():with_silent(),
	["n|<leader>wl"] = map_cr("<C-w>L"):with_noremap():with_silent(),
	["n|<leader>wv"] = map_cmd("<C-w>v<C-^>"):with_noremap():with_silent(),
	["n|<leader>ws"] = map_cmd("<C-w>s<C-^>"):with_noremap():with_silent(),
	-- ["n|<leader>wr"] = map_cr("<C-w>r"):with_noremap():with_silent(),
	-- ["n|<leader>wS"] = map_cmd(":split<CR>"):with_noremap():with_silent(),
	-- ["n|<leader>wV"] = map_cmd(":vsplit<CR>"):with_noremap():with_silent(),

	-- window resize
	["n|<leader>rj"] = map_cr("resize +2"):with_silent(),
	["n|<leader>rk"] = map_cr("resize -2"):with_silent(),
	["n|<leader>rh"] = map_cr("vertical resize +5"):with_silent(),
	["n|<leader>rl"] = map_cr("vertical resize -5"):with_silent(),
	["n|<leader>re"] = map_cmd("<C-w>="):with_silent(),
	["n|<leader>rm"] = map_cmd("<C-w>_<C-w>|"):with_silent(),
	["n|<C-w>M"] = map_cmd("<C-w>_<C-w>|"):with_silent(),
	-- ["n|<leader>rM"] = map_cmd("<C-w>|"):with_silent(),

	["n|<D-Up>"] = map_cr("resize -2"):with_silent(),
	-- <cmd-opt-↑>
	["n|<D-˚>"] = map_cr("resize -2"):with_silent(),
	["n|<D-Down>"] = map_cr("resize +2"):with_silent(),
	["n|<D-∆>"] = map_cr("resize +2"):with_silent(),
	["n|<D-Right>"] = map_cr("vertical resize +5"):with_silent(),
	["n|<D-¬>"] = map_cr("vertical resize +5"):with_silent(),
	["n|<D-Left>"] = map_cr("vertical resize -5"):with_silent(),
	["n|<D-˙>"] = map_cr("vertical resize -5"):with_silent(),

	-- ToggleTerm
	["t|<D-Right>"] = map_cmd("<Esc><Cmd>vertical resize +5<CR>"):with_silent(),
	["t|<D-¬>"] = map_cmd("<Esc><Cmd>vertical resize +5<CR>"):with_silent(),
	["t|<D-Left>"] = map_cmd("<Esc><Cmd>vertical resize -5<CR>"):with_silent(),
	["t|<D-˙>"] = map_cmd("<Esc><Cmd>vertical resize -5<CR>"):with_silent(),
	["t|<D-Down>"] = map_cmd("<Esc><Cmd>resize -2<CR>"):with_silent(),
	["t|<D-∆>"] = map_cmd("<Esc><Cmd>resize -2<CR>"):with_silent(),
	["t|<D-Up>"] = map_cmd("<Esc><Cmd>resize +2<CR>"):with_silent(),
	["t|<D-˚>"] = map_cmd("<Esc><Cmd>resize +2<CR>"):with_silent(),

	["t|<D-b>"] = map_cmd("<C-Left>"):with_noremap():with_silent(),
	["t|<D-f>"] = map_cmd("<C-Right>"):with_noremap():with_silent(),
	["t|<D-v>"] = map_cmd([[<C-\><C-n>pi<Right>]]):with_noremap():with_silent(),
	["t|<D-C-w>"] = map_cmd([[<C-\><C-n><C-w>w]]):with_noremap():with_silent(),
	["t|<D-C-j>"] = map_cmd([[<C-\><C-n><C-w>j]]):with_noremap():with_silent(),
	["t|<D-C-k>"] = map_cmd([[<C-\><C-n><C-w>k]]):with_noremap():with_silent(),
	["t|<D-C-h>"] = map_cmd([[<C-\><C-n><C-w>h]]):with_noremap():with_silent(),
	["t|<D-C-l>"] = map_cmd([[<C-\><C-n><C-w>l]]):with_noremap():with_silent(),
	["t|<D-C-t>"] = map_cmd([[<C-\><C-n><C-w>t]]):with_noremap():with_silent(),
	["t|<D-C-b>"] = map_cmd([[<C-\><C-n><C-w>b]]):with_noremap():with_silent(),
	["t|<D-C-m>"] = map_cmd([[<C-\><C-n><C-w>_<C-w>|]]):with_noremap():with_silent(),
	["t|<D-C-n>"] = map_cmd([[<C-\><C-n><C-w>t<C-w>_<C-w>|]]):with_noremap():with_silent(),
	["t|<D-C-c>"] = map_cmd([[<C-\><C-n><C-w>t:]]):with_noremap(),
	-- ["t|<D-C-o>"] = map_cmd([[<C-\><C-n><C-w>=]]):with_noremap():with_silent(),

	-- command line
	["c|<D-b>"] = map_cmd("<C-Left>"):with_noremap(),
	["c|<D-f>"] = map_cmd("<C-Right>"):with_noremap(),
	["c|<C-b>"] = map_cmd("<Left>"):with_noremap(),
	["c|<C-f>"] = map_cmd("<Right>"):with_noremap(),
	["c|<C-a>"] = map_cmd("<Home>"):with_noremap(),
	["c|<C-e>"] = map_cmd("<End>"):with_noremap(),
	["c|<C-d>"] = map_cmd("<Del>"):with_noremap(),
	["c|<C-h>"] = map_cmd("<BS>"):with_noremap(),
	["c|<C-t>"] = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]]):with_noremap(),
	["c|Sw!!"] = map_cmd("execute 'silent! write !sudo tee % >/dev/null' <bar> edit!"),

	-- Visual
	-- ["v|J"] = map_cmd(":m '>+1<cr>gv=gv"),
	-- ["v|K"] = map_cmd(":m '<-2<cr>gv=gv"),
	["v|<"] = map_cmd("<gv"),
	["v|>"] = map_cmd(">gv"),

	--x operate
	-- Run macro over selected rows using @
	-- ["x|@"] = map_cmd(":<C-u>call Macros#ExecuteMacroOverVisualRange()<CR>"),
}
bind.nvim_load_mapping(core_map)
