require("user.keymap.helpers")
local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback

local plug_map = {

	-- Plugin neotree
	["n|<Leader>nt"] = map_cr("Neotree reveal=true toggle"):with_noremap():with_silent():with_desc("filetree: Toggle"),
	["n|<Leader>nf"] = map_cr("Neotree reveal=true float toggle"):with_noremap():with_silent():with_desc("filetree: Toggle"),
	["n|<Leader>nb"] = map_cr("Neotree buffers"):with_noremap():with_silent():with_desc("filetree: Buffers"),
	["n|<Leader>ng"] = map_cr("Neotree git_status"):with_noremap():with_silent():with_desc("filetree: Buffers"),

	-- Plugin SnipRun
	["n|<Leader>rr"] = map_cr("SnipRun"):with_noremap():with_silent():with_desc("tool: Run code by inline"),
	["v|<Leader>rr"] = map_cr("SnipRun"):with_noremap():with_silent():with_desc("tool: Run code by range"),
	["n|<Leader>rf"] = map_cu([[%SnipRun]]):with_noremap():with_silent():with_desc("tool: Run code by file"),

	-- Plugin toggleterm
	["t|<ESC><ESC>"] = map_cmd("<C-\\><C-n>"):with_noremap():with_silent(), -- switch to normal mode in terminal.
	["t|jk"] = map_cmd("<C-\\><C-n>"):with_noremap():with_silent(), -- switch to normal mode in terminal.
	["nt|<D-C-\\>"] = map_cmd("<Cmd>ToggleTerm<CR>")
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle horizontal"),
	["n|<Leader>tt"] = map_cr("ToggleTerm direction=horizontal")
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle horizontal"),
	["n|<Leader>tv"] = map_cr("ToggleTerm direction=vertical")
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle vertical"),
	["n|<Leader>tf"] = map_cr("ToggleTerm direction=float")
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle float"),
	["nv|<Leader>tc"] = map_cmd("<Cmd>ToggleTermSendCurrentLine<CR>")
		:with_noremap()
		:with_silent()
		:with_desc("send current code to term"),
	["v|<Leader>tv"] = map_cmd("<Cmd>ToggleTermSendVisualLines<CR>")
		:with_noremap()
		:with_silent()
		:with_desc("send selected code to term"),
	["n|<Leader>tp"] = map_callback(function()
			Toggle_ipython()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("python: Toggle ipython"),
	["n|<Leader>tg"] = map_callback(function()
			Toggle_lazygit()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("git: Toggle lazygit"),
	["t|<D-g>"] = map_callback(function()
			Toggle_lazygit()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("git: Toggle lazygit"),

	-- Plugin Telescope
	["n|<Leader>fa"] = map_cu("Telescope"):with_noremap():with_silent():with_desc("telescope all commands"),
	["n|<Leader>fC"] = map_callback(function()
			_telescope_collections(require("telescope.themes").get_dropdown())
		end)
		:with_noremap()
		:with_silent()
		:with_desc("tool: Open Telescope collections"),
	["n|<Leader>fw"] = map_callback(function()
			Telescope_find_file({ scope = "cwd" })
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: file in cwd"),
	["n|<Leader>fk"] = map_callback(function()
			require("search").open({ collection = "pattern" })
		end)
		:with_noremap()
		:with_silent()
		:with_desc("tool: Find patterns"),
	["n|<Leader>fh"] = map_callback(function()
			require("search").open({ collection = "history" })
		end)
		:with_noremap()
		:with_silent()
		:with_desc("tool: Find history"),
	["n|<Leader>f/"] = map_cu("Telescope current_buffer_fuzzy_find")
		:with_noremap()
		:with_silent()
		:with_desc("grep: word in buffer"),
	["n|<Leader>fc"] = map_cmd(":Telescope cmdline<CR>"):with_noremap():with_silent():with_desc("tool: Cmdline"),
	["n|:"] = map_cmd(":Telescope cmdline<CR>"):with_noremap():with_silent():with_desc("tool: Cmdline"),
	["n|<Leader>fM"] = map_callback(_command_panel)
		:with_silent()
		:with_noremap()
		:with_desc("tool: Toggle keymapping panel"),
	["n|<Leader>fn"] = map_cu("Telescope notify"):with_noremap():with_silent():with_desc("notify"),
	["n|<Leader>fj"] = map_cu("Telescope jumplist"):with_noremap():with_silent():with_desc("jumplist"),
	["n|<Leader>fb"] = map_cu("Telescope buffers"):with_noremap():with_silent():with_desc("find: Buffer opened"),
	["n|<Leader>fr"] = map_cu("Telescope registers"):with_noremap():with_silent():with_desc("registers"),
	["n|<Leader>fz"] = map_cu("Telescope help_tags"):with_noremap():with_silent():with_desc("help_tags"),
	-- NOTE: do diagnostic for all buffers
	["n|<Leader>fp"] = map_cu("Telescope diagnostics"):with_noremap():with_silent():with_desc("diagnostics in project"),
	["n|<Leader>fo"] = map_cu("Telescope aerial"):with_noremap():with_silent():with_desc("aerial outline"),
	["n|<Leader>fs"] = map_cu("Telescope lsp_document_symbols")
		:with_noremap()
		:with_silent()
		:with_desc("symbols in workspace"),
	-- search neovim config file and edit it
	["n|<Leader>fu"] = map_callback(Telescope_find_neovim_config)
		:with_noremap()
		:with_silent()
		:with_desc("search Neovim config"),

	-- Plugin dap
	["n|<Leader>dc"] = map_callback(function()
			require("dap").continue()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Run/Continue"),
	["n|<Leader>dd"] = map_callback(function()
			require("dap").terminate()
			require("dapui").close()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Stop"),
	["n|<Leader>db"] = map_callback(function()
			require("dap").toggle_breakpoint()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Toggle breakpoint"),
	["n|<Leader>di"] = map_callback(function()
			require("dap").step_into()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Step into"),
	["n|<Leader>do"] = map_callback(function()
			require("dap").step_out()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Step out"),
	["n|<Leader>dv"] = map_callback(function()
			require("dap").step_over()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Step over"),
	["n|<Leader>dB"] = map_callback(function()
			require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Set breakpoint with condition"),
	["n|<Leader>dC"] = map_callback(function()
			require("dap").run_to_cursor()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Run to cursor"),
	["n|<Leader>dl"] = map_callback(function()
			require("dap").run_last()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Run last"),
	["n|<Leader>dr"] = map_callback(function()
			require("dap").repl.open()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Open REPL"),

	-- Plugin Scratch
	["n|<Leader>sn"] = map_cu("Scratch"):with_noremap():with_silent():with_desc("Scratch new"),
	["n|<Leader>so"] = map_cu("ScratchOpen"):with_noremap():with_silent():with_desc("Scratch Open"),
	["n|<Leader>sg"] = map_cu("ScratchOpenFzf"):with_noremap():with_silent():with_desc("Scratch Open via grep string"),

	-- Plugin nvim-gomove(move/copy text)
	["i|<M-j>"] = map_cmd("<esc><Plug>GoNSMDown"):with_noremap():with_silent(),
	["i|<M-k>"] = map_cmd("<esc><Plug>GoNSMUp"):with_noremap():with_silent(),
	-- normal mode move text
	["n|<M-j>"] = map_cmd([[<Plug>GoNSMDown]]):with_noremap():with_silent(),
	["n|<M-k>"] = map_cmd([[<Plug>GoNSMUp]]):with_noremap():with_silent(),
	["n|<M-S-h>"] = map_cmd([[<Plug>GoNSMLeft]]):with_noremap():with_silent(),
	["n|<M-S-l>"] = map_cmd([[<Plug>GoNSMRight]]):with_noremap():with_silent(),
	-- x mode move text
	["x|<M-j>"] = map_cmd([[<Plug>GoVSMDown]]):with_noremap():with_silent(),
	["x|<M-k>"] = map_cmd([[<Plug>GoVSMUp]]):with_noremap():with_silent(),
	["x|<M-S-h>"] = map_cmd([[<Plug>GoVSMLeft]]):with_noremap():with_silent(),
	["x|<M-S-l>"] = map_cmd([[<Plug>GoVSMRight]]):with_noremap():with_silent(),

	-- Plugin refactoring
	["v|<Leader>re"] = map_cmd([[<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]])
		:with_noremap()
		:with_silent()
		:with_desc("[R]efactor: [E]xtract function"),
	["v|<Leader>rf"] = map_cmd([[<Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]])
		:with_noremap()
		:with_silent()
		:with_desc("[R]efactor: Extract function to [F]ile"),
	["v|<Leader>rv"] = map_cmd([[<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]])
		:with_noremap()
		:with_silent()
		:with_desc("[R]efactor: Extract [V]ariable"),
	["v|<Leader>ri"] = map_cmd([[<Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]])
		:with_noremap()
		:with_silent()
		:with_desc("[R]efactor: [I]nline variable"),
	-- Extract block doesn't need visual mode
	["n|<Leader>rb"] = map_cmd([[<Cmd>lua require('refactoring').refactor('Extract Block')<CR>]])
		:with_noremap()
		:with_silent()
		:with_desc("[R]efactor: Extract [B]lock"),
	["n|<Leader>rB"] = map_cmd([[<Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]])
		:with_noremap()
		:with_silent()
		:with_desc("[R]efactor: Extract [B]lock to [F]ile"),
	-- Inline variable can also pick up the identifier currently under the cursor without visual mode
	["n|<Leader>ri"] = map_cmd([[<Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]])
		:with_noremap()
		:with_silent()
		:with_desc("[R]efactor: [I]nline variable"),
}
bind.nvim_load_mapping(plug_map)
