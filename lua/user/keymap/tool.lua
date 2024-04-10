local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
require("keymap.helpers")

local plug_map = {

	-- git
	-- ["n|gps"] = map_cr("G push"):with_noremap():with_silent():with_desc("git: Push"),
	-- ["n|gpl"] = map_cr("G pull"):with_noremap():with_silent():with_desc("git: Pull"),

	-- Plugin neo-tree
	["n|<leader>nt"] = map_cmd("<Cmd>Neotree float reveal_file=%:p reveal_force_cwd<CR>")
		:with_noremap()
		:with_silent()
		:with_desc("filetree: Toggle"),
	["n|<leader>nb"] = map_cr("Neotree buffers"):with_noremap():with_silent():with_desc("filetree: Buffers"),
	["n|<leader>ng"] = map_cr("Neotree git_status"):with_noremap():with_silent():with_desc("filetree: Buffers"),

	-- Plugin SnipRun
	["n|<leader>rr"] = map_cr("SnipRun"):with_noremap():with_silent():with_desc("tool: Run code by inline"),
	["v|<leader>rr"] = map_cr("SnipRun"):with_noremap():with_silent():with_desc("tool: Run code by range"),
	["n|<leader>rf"] = map_cu([[%SnipRun]]):with_noremap():with_silent():with_desc("tool: Run code by file"),
	["c|Sr!!"] = map_cu([[%SnipRun]]):with_noremap(),

	-- toggleterm
	["t|<ESC><ESC>"] = map_cmd("<C-\\><C-n>"):with_noremap():with_silent(), -- switch to normal mode in terminal.
	["t|jk"] = map_cmd("<C-\\><C-n>"):with_noremap():with_silent(), -- switch to normal mode in terminal.
	["nt|<D-C-\\>"] = map_cmd("<Cmd>ToggleTerm<CR>")
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle horizontal"),
	["n|<leader>tt"] = map_cr("ToggleTerm direction=horizontal")
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle horizontal"),
	["n|<leader>tv"] = map_cr("ToggleTerm direction=vertical")
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle vertical"),
	["n|<leader>tf"] = map_cr("ToggleTerm direction=float")
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle float"),
	["n|<leader>tp"] = map_callback(function()
			toggle_ipython()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("python: Toggle ipython"),

	-- sent code of current line to term
	["nv|<leader>tc"] = map_cmd(":ToggleTermSendCurrentLine<CR>")
		:with_noremap()
		:with_silent()
		:with_desc("sent current code to term"),
	-- ["v|<leader>tV"] = map_cmd(":ToggleTermSendVisualLines<CR>"):with_noremap():with_silent(),
	["n|<leader>tg"] = map_callback(function()
			toggle_lazygit()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("git: Toggle lazygit"),
	["t|<D-g>"] = map_callback(function()
			toggle_lazygit()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("git: Toggle lazygit"),

	-- Plugin Telescope
	["n|<Leader>fa"] = map_cu("Telescope"):with_noremap():with_silent():with_desc("telescope all commands"),
	["n|<Leader>fc"] = map_cu("Telescope commands"):with_noremap():with_silent():with_desc("telescope commands"),
	["n|<leader>fu"] = map_callback(function()
			require("telescope").extensions.undo.undo()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("editn: Show undo history"),
	["n|<leader>fp"] = map_callback(function()
			require("telescope").extensions.projects.projects({})
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: Project"),
	["n|<leader>ff"] = map_callback(function()
			require("telescope").extensions.frecency.frecency()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: File by frecency"),
	["n|<leader>fg"] = map_cu("Telescope git_files"):with_noremap():with_silent():with_desc("Search GitRepo Files"),
	["n|<leader>fo"] = map_cu("Telescope oldfiles"):with_noremap():with_silent():with_desc("find: File by history"),
	["n|<leader>fO"] = map_cu("Telescope aerial"):with_noremap():with_silent():with_desc("aerial outline"),

	["n|<leader>fe"] = map_callback(function()
			Telescope_project_files({ scope = "cwd" })
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: file in git CWD"),
	["n|<leader>fj"] = map_callback(function()
			Telescope_project_files({ scope = "auto" })
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: file in git project"),
	["n|<leader>fz"] = map_cu("Telescope zoxide list")
		:with_noremap()
		:with_silent()
		:with_desc("edit: Change direrctory zoxide"),
	["n|<Leader>fw"] = map_cu("Telescope current_buffer_fuzzy_find")
		:with_noremap()
		:with_silent()
		:with_desc("grep: word in buffer"),
	["n|<Leader>fB"] = map_callback(function()
			Telescope_rg_live_grep({ scope = "buffers" })
		end)
		:with_noremap()
		:with_silent()
		:with_desc("rg: word in buffers opened"),
	-- ["n|<Leader>fl"] = map_callback(function()
	-- 		Telescope_rg_live_grep({ scope = "project" })
	-- 	end)
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("rg live: word in project"),
	["n|<leader>fl"] = map_callback(function()
			require("telescope").extensions.live_grep_args.live_grep_args()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("grep: Word in project"),
	["n|<leader>fk"] = map_cu("Telescope grep_string"):with_noremap():with_silent():with_desc("grep: Current word"),
	["n|<Leader>fK"] = map_callback(function()
			Telescope_rg_kw({ word_match = true })
		end)
		:with_noremap()
		:with_silent()
		:with_desc("grep: word in project"),
	["n|<Leader>fJ"] = map_cu("Telescope jumplist"):with_noremap():with_silent():with_desc("jumplist"),
	["n|<Leader>fM"] = map_callback(keymaps_panel)
		:with_silent()
		:with_noremap()
		:with_desc("tool: Toggle keymapping panel"),
	["n|<Leader>fm"] = map_cu("Telescope marks"):with_noremap():with_silent():with_desc("marks"),
	["n|<Leader>fn"] = map_cu("Telescope notify"):with_noremap():with_silent():with_desc("notify"),
	["n|<Leader>fr"] = map_cu("Telescope resume"):with_noremap():with_silent():with_desc("resume"),
	["n|<Leader>fR"] = map_cu("Telescope registers"):with_noremap():with_silent():with_desc("registers"),
	["n|<Leader>fs"] = map_cu("Telescope lsp_document_symbols")
		:with_noremap()
		:with_silent()
		:with_desc("symbols in workspace"),
	["n|<leader>fS"] = map_cu("Telescope persisted"):with_noremap():with_silent():with_desc("find: Session"),
	-- NOTE: do diagnostic for all buffers
	["n|<Leader>fd"] = map_cu("Telescope diagnostics"):with_noremap():with_silent():with_desc("diagnostics in project"),
	["n|<Leader>fC"] = map_cu("Telescope command_history"):with_noremap():with_silent():with_desc("command_history"),
	["n|<Leader>fy"] = map_cu("Telescope yank_history"):with_noremap():with_silent():with_desc("yank_history"),
	["n|<Leader>fh"] = map_cu("Telescope help_tags"):with_noremap():with_silent():with_desc("help_tags"),
	-- ["n|<leader>fH"] = map_cu("Telescope smart_history"):with_noremap():with_silent():with_desc(""),
	["n|<Leader>ft"] = map_cu("TodoTelescope"):with_noremap():with_silent():with_desc("TodoTelescope"),
	["n|<Leader>fY"] = map_callback(Telescope_yaml_symbols):with_noremap():with_silent():with_desc("yaml_symbols"),
	["n|<Leader>gs"] = map_callback(Telescope_git_status):with_noremap():with_silent():with_desc("git_status"),
	["n|<Leader>gc"] = map_callback(Telescope_git_bcommits):with_noremap():with_silent():with_desc("git_bcommits"),
	["n|<Leader>gC"] = map_callback(Telescope_git_commits):with_noremap():with_silent():with_desc("git_commits"),
	["n|<leader>sc"] = map_cu("Telescope colorscheme"):with_noremap():with_silent():with_desc("ui: Change colorscheme"),
	["n|<leader>fb"] = map_cu("Telescope buffers"):with_noremap():with_silent():with_desc("find: Buffer opened"),

	-- Plugin swenv
	["n|<leader>ce"] = map_cr("lua require('swenv.api').pick_venv()")
		:with_noremap()
		:with_silent()
		:with_desc("choose venv"),

	-- Plugin dap
	["n|<leader>dc"] = map_callback(function()
			require("dap").continue()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Run/Continue"),
	["n|<leader>dd"] = map_callback(function()
			require("dap").terminate()
			require("dapui").close()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Stop"),
	["n|<leader>db"] = map_callback(function()
			require("dap").toggle_breakpoint()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Toggle breakpoint"),
	["n|<leader>di"] = map_callback(function()
			require("dap").step_into()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Step into"),
	["n|<leader>do"] = map_callback(function()
			require("dap").step_out()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Step out"),
	["n|<leader>dv"] = map_callback(function()
			require("dap").step_over()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Step over"),
	["n|<leader>dB"] = map_callback(function()
			require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Set breakpoint with condition"),
	["n|<leader>dC"] = map_callback(function()
			require("dap").run_to_cursor()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Run to cursor"),
	["n|<leader>dl"] = map_callback(function()
			require("dap").run_last()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Run last"),
	["n|<leader>dr"] = map_callback(function()
			require("dap").repl.open()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Open REPL"),

	-- Plugin spectre
	-- search cursor word
	["n|<leader>sw"] = map_cr("lua require('spectre').open_visual({select_word=true})"):with_noremap():with_silent():with_desc("spectre: Search cursor word"),
	["v|<leader>sV"] = map_cr("lua require('spectre').open_visual()"):with_noremap():with_silent():with_desc("spectre: open_visual"),
	["n|<leader>sO"] = map_cr("lua require('spectre').open()"):with_noremap():with_silent():with_desc("spectre: open"),
	-- search in current file
	["n|<leader>sf"] = map_cr("lua require('spectre').open_file_search()"):with_noremap():with_silent():with_desc("spectre: Search current file"),

	-- Plugin Scratch
	["n|<leader>sn"] = map_cu("Scratch"):with_noremap():with_silent():with_desc("Scratch new"),
	["n|<leader>so"] = map_cu("ScratchOpen"):with_noremap():with_silent():with_desc("Scratch Open"),

	-- plugin nvim-gomove(move/copy text)
	-- insert mode move text
	-- ["i|<D-j>"] = map_cmd("<esc>:m .+1<CR>==a"):with_noremap():with_silent(),
	-- ["i|<D-k>"] = map_cmd("<esc>:m .-2<CR>==a"):with_noremap():with_silent(),
	["i|<D-j>"] = map_cmd("<esc><Plug>GoNSMDown<esc>a"):with_noremap():with_silent(),
	["i|<D-k>"] = map_cmd("<esc><Plug>GoNSMUp<esc>a"):with_noremap():with_silent(),
	-- insert mode copy text of line to up/down
	["i|<D-S-j>"] = map_cmd("<esc><Plug>GoNSDDown<esc>a"):with_noremap():with_silent(),
	["i|<D-S-k>"] = map_cmd("<esc><Plug>GoNSDUp<esc>a"):with_noremap():with_silent(),
	-- normal mode move text
	["n|<D-j>"] = map_cmd([[<Plug>GoNSMDown]]):with_noremap():with_silent(),
	["n|<D-k>"] = map_cmd([[<Plug>GoNSMUp]]):with_noremap():with_silent(),
	["n|<D-S-h>"] = map_cmd([[<Plug>GoNSMLeft]]):with_noremap():with_silent(),
	["n|<D-S-l>"] = map_cmd([[<Plug>GoNSMRight]]):with_noremap():with_silent(),
	-- x mode move text
	["x|<D-j>"] = map_cmd([[<Plug>GoVSMDown]]):with_noremap():with_silent(),
	["x|<D-k>"] = map_cmd([[<Plug>GoVSMUp]]):with_noremap():with_silent(),
	["x|<D-S-h>"] = map_cmd([[<Plug>GoVSMLeft]]):with_noremap():with_silent(),
	["x|<D-S-l>"] = map_cmd([[<Plug>GoVSMRight]]):with_noremap():with_silent(),
	-- copy text of line to up/down
	["n|<D-S-j>"] = map_cmd([[<Plug>GoNSDDown]]):with_noremap():with_silent(),
	["n|<D-S-k>"] = map_cmd([[<Plug>GoNSDUp]]):with_noremap():with_silent(),
	["x|<D-S-j>"] = map_cmd([[<Plug>GoVSDDown]]):with_noremap():with_silent(),
	["x|<D-S-k>"] = map_cmd([[<Plug>GoVSDUp]]):with_noremap():with_silent(),

	-- refactoring
	["v|<leader>re"] = map_cmd([[<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]])
		:with_noremap()
		:with_silent()
		:with_desc("[R]efactor: [E]xtract function"),
	["v|<leader>rf"] = map_cmd([[<Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]])
		:with_noremap()
		:with_silent()
		:with_desc("[R]efactor: Extract function to [F]ile"),
	["v|<leader>rv"] = map_cmd([[<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]])
		:with_noremap()
		:with_silent()
		:with_desc("[R]efactor: Extract [V]ariable"),
	["v|<leader>ri"] = map_cmd([[<Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]])
		:with_noremap()
		:with_silent()
		:with_desc("[R]efactor: [I]nline variable"),
	-- Extract block doesn't need visual mode
	["n|<leader>rb"] = map_cmd([[<Cmd>lua require('refactoring').refactor('Extract Block')<CR>]])
		:with_noremap()
		:with_silent()
		:with_desc("[R]efactor: Extract [B]lock"),
	["n|<leader>rB"] = map_cmd([[<Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]])
		:with_noremap()
		:with_silent()
		:with_desc("[R]efactor: Extract [B]lock to [F]ile"),
	-- Inline variable can also pick up the identifier currently under the cursor without visual mode
	["n|<leader>ri"] = map_cmd([[<Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]])
		:with_noremap()
		:with_silent()
		:with_desc("[R]efactor: [I]nline variable"),
}
bind.nvim_load_mapping(plug_map)
