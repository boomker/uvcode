local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
require("keymap.helpers")

local plug_map = {

	-- Plugin nvim-tree
	["n|<leader>nt"] = map_cr("NvimTreeToggle"):with_noremap():with_silent():with_desc("filetree: Toggle"),
	["n|<leader>nf"] = map_cr("NvimTreeFindFile"):with_noremap():with_silent():with_desc("filetree: Find file"),
	["n|<leader>nr"] = map_cr("NvimTreeRefresh"):with_noremap():with_silent():with_desc("filetree: Refresh"),
	-- ["n|<leader>nt"] = map_cr("Neotree float"):with_noremap():with_silent():with_desc("filetree: Toggle"),
	-- ["n|<leader>nb"] = map_cr("Neotree buffers"):with_noremap():with_silent():with_desc("filetree: Buffers"),
	-- ["n|<leader>ng"] = map_cr("Neotree git_status"):with_noremap():with_silent():with_desc("filetree: Buffers"),

	-- Plugin SnipRun
	["n|<leader>rr"] = map_cr("SnipRun"):with_noremap():with_silent():with_desc("tool: Run code by inline"),
	["v|<leader>rr"] = map_cr("SnipRun"):with_noremap():with_silent():with_desc("tool: Run code by range"),
	["n|<leader>rf"] = map_cu([[%SnipRun]]):with_noremap():with_silent():with_desc("tool: Run code by file"),

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

	["nv|<leader>tc"] = map_cmd("<Cmd>ToggleTermSendCurrentLine<CR>")
		:with_noremap()
		:with_silent()
		:with_desc("sent current code to term"),
	["v|<leader>tv"] = map_cmd("<Cmd>ToggleTermSendVisualLines<CR>")
        :with_noremap()
        :with_silent()
		:with_desc("sent selected code to term"),

	["n|<leader>tp"] = map_callback(function()
			toggle_ipython()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("python: Toggle ipython"),
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
	["n|<leader>fP"] = map_callback(function()
			require("telescope").extensions.projects.projects({})
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: Project"),
	["n|<leader>fz"] = map_cu("Telescope zoxide list")
		:with_noremap()
		:with_silent()
		:with_desc("zoxide: Change direrctory"),
	["n|<leader>ff"] = map_callback(function()
			require("telescope").extensions.frecency.frecency()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: File by frecency"),
	["n|<leader>fg"] = map_cu("Telescope git_files"):with_noremap():with_silent():with_desc("Search GitRepo Files"),
	["n|<leader>fr"] = map_cu("Telescope oldfiles"):with_noremap():with_silent():with_desc("find: File by history"),
	["n|<leader>fo"] = map_cu("Telescope aerial"):with_noremap():with_silent():with_desc("aerial outline"),

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
	["n|<Leader>fw"] = map_cu("Telescope current_buffer_fuzzy_find")
		:with_noremap()
		:with_silent()
		:with_desc("grep: word in buffer"),
	["n|<leader>fk"] = map_callback(function()
            require("search").open({ collection = "pattern" })
		end)
		:with_noremap()
		:with_silent()
		:with_desc("tool: Find patterns"),
	--[[ ["n|<leader>fk"] = map_cu("Telescope grep_string")
        :with_noremap()
        :with_silent()
        :with_desc("grep: word under cursor in project"),
	["n|<Leader>fK"] = map_callback(function()
			Telescope_rg_kw({ word_match = true })
		end)
		:with_noremap()
		:with_silent()
		:with_desc("grep: word in project"), ]]
	["n|<Leader>fB"] = map_callback(function()
			Telescope_rg_live_grep({ scope = "buffers" })
		end)
		:with_noremap()
		:with_silent()
		:with_desc("rg: word in buffers opened"),
	["n|<Leader>fJ"] = map_cu("Telescope jumplist"):with_noremap():with_silent():with_desc("jumplist"),
	["n|<Leader>fM"] = map_callback(keymaps_panel)
		:with_silent()
		:with_noremap()
		:with_desc("tool: Toggle keymapping panel"),
	["n|<Leader>fn"] = map_cu("Telescope notify"):with_noremap():with_silent():with_desc("notify"),
	["n|<Leader>fh"] = map_cu("Telescope help_tags"):with_noremap():with_silent():with_desc("help_tags"),
	["n|<leader>fb"] = map_cu("Telescope buffers"):with_noremap():with_silent():with_desc("find: Buffer opened"),
	-- NOTE: do diagnostic for all buffers
	["n|<Leader>fd"] = map_cu("Telescope diagnostics"):with_noremap():with_silent():with_desc("diagnostics in project"),
	["n|<leader>fp"] = map_cu("Telescope persisted"):with_noremap():with_silent():with_desc("find: Session"),
	["n|<Leader>fR"] = map_cu("Telescope registers"):with_noremap():with_silent():with_desc("registers"),
	["n|<Leader>fs"] = map_cu("Telescope lsp_document_symbols")
		:with_noremap()
		:with_silent()
		:with_desc("symbols in workspace"),

	["n|<Leader>hc"] = map_cu("Telescope command_history"):with_noremap():with_silent():with_desc("command_history"),
	["n|<Leader>hy"] = map_cu("Telescope yank_history"):with_noremap():with_silent():with_desc("yank_history"),
	["n|<leader>hU"] = map_callback(function() require("telescope").extensions.undo.undo() end)
		:with_noremap()
		:with_silent()
		:with_desc("Telescope undo history"),

    -- git
	["n|<Leader>gs"] = map_callback(Telescope_git_status):with_noremap():with_silent():with_desc("git_status"),
	["n|<Leader>gc"] = map_callback(Telescope_git_bcommits):with_noremap():with_silent():with_desc("git_bcommits"),
	["n|<Leader>gC"] = map_callback(Telescope_git_commits):with_noremap():with_silent():with_desc("git_commits"),

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
	["n|<leader>sw"] = map_cr("lua require('spectre').open_visual({select_word=true})")
		:with_noremap()
		:with_silent()
		:with_desc("spectre: Search cursor word"),
	-- search in current file
	["n|<leader>sf"] = map_cr("lua require('spectre').open_file_search()")
		:with_noremap()
		:with_silent()
		:with_desc("spectre: Search current file"),
	["v|<leader>sV"] = map_cr("lua require('spectre').open_visual()")
		:with_noremap()
		:with_silent()
		:with_desc("spectre: open_visual"),
	["n|<leader>sO"] = map_cr("lua require('spectre').open()")
        :with_noremap()
        :with_silent()
        :with_desc("spectre: open"),

	-- Plugin Scratch
	["n|<leader>sn"] = map_cu("Scratch")
        :with_noremap()
        :with_silent()
        :with_desc("Scratch new"),
	["n|<leader>so"] = map_cu("ScratchOpen")
        :with_noremap()
        :with_silent()
        :with_desc("Scratch Open"),
	["n|<leader>sg"] = map_cu("ScratchOpenFzf")
        :with_noremap()
        :with_silent()
        :with_desc("Scratch Open via grep string"),

	-- plugin nvim-gomove(move/copy text)
	["i|<M-j>"] = map_cmd("<esc><Plug>GoNSMDown<esc>a"):with_noremap():with_silent(),
	["i|<M-k>"] = map_cmd("<esc><Plug>GoNSMUp<esc>a"):with_noremap():with_silent(),
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
