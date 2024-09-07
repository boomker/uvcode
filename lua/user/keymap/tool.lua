local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
require("keymap.helpers")

local plug_map = {

	-- Plugin nvim-tree
	["n|<Leader>nt"] = map_cr("NvimTreeToggle"):with_noremap():with_silent():with_desc("filetree: Toggle"),
	["n|<Leader>nf"] = map_cr("NvimTreeFindFile"):with_noremap():with_silent():with_desc("filetree: Find file"),
	["n|<Leader>nr"] = map_cr("NvimTreeRefresh"):with_noremap():with_silent():with_desc("filetree: Refresh"),
	-- ["n|<Leader>nt"] = map_cr("Neotree float"):with_noremap():with_silent():with_desc("filetree: Toggle"),
	-- ["n|<Leader>nb"] = map_cr("Neotree buffers"):with_noremap():with_silent():with_desc("filetree: Buffers"),
	-- ["n|<Leader>ng"] = map_cr("Neotree git_status"):with_noremap():with_silent():with_desc("filetree: Buffers"),

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
			toggle_ipython()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("python: Toggle ipython"),
	["n|<Leader>tg"] = map_callback(function()
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
	["n|<Leader>fP"] = map_callback(function()
			require("telescope").extensions.projects.projects({})
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: Project"),
	["n|<Leader>ff"] = map_callback(function()
			require("telescope").extensions.frecency.frecency()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: File by frecency"),
	["n|<Leader>fg"] = map_cu("Telescope git_files"):with_noremap():with_silent():with_desc("Search GitRepo Files"),
	["n|<Leader>fr"] = map_cu("Telescope oldfiles"):with_noremap():with_silent():with_desc("find: File by history"),
	["n|<Leader>fo"] = map_cu("Telescope aerial"):with_noremap():with_silent():with_desc("aerial outline"),

	["n|<Leader>fe"] = map_callback(function()
			Telescope_project_files({ scope = "cwd" })
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: file in git CWD"),
	["n|<Leader>fj"] = map_callback(function()
			Telescope_project_files({ scope = "auto" })
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: file in git project"),
	["n|<Leader>fw"] = map_cu("Telescope current_buffer_fuzzy_find")
		:with_noremap()
		:with_silent()
		:with_desc("grep: word in buffer"),
	["n|<Leader>fk"] = map_callback(function()
            require("search").open({ collection = "pattern" })
		end)
		:with_noremap()
		:with_silent()
		:with_desc("tool: Find patterns"),
	--[[ ["n|<Leader>fk"] = map_cu("Telescope grep_string")
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
	["n|<Leader>fM"] = map_callback(keymaps_panel)
		:with_silent()
		:with_noremap()
		:with_desc("tool: Toggle keymapping panel"),
	["n|<Leader>fn"] = map_cu("Telescope notify"):with_noremap():with_silent():with_desc("notify"),
	["n|<Leader>fh"] = map_cu("Telescope help_tags"):with_noremap():with_silent():with_desc("help_tags"),
	["n|<Leader>fb"] = map_cu("Telescope buffers"):with_noremap():with_silent():with_desc("find: Buffer opened"),
	-- NOTE: do diagnostic for all buffers
	["n|<Leader>fd"] = map_cu("Telescope diagnostics"):with_noremap():with_silent():with_desc("diagnostics in project"),
	["n|<Leader>fp"] = map_cu("Telescope persisted"):with_noremap():with_silent():with_desc("find: Session"),
	["n|<Leader>fR"] = map_cu("Telescope registers"):with_noremap():with_silent():with_desc("registers"),
	["n|<Leader>fs"] = map_cu("Telescope lsp_document_symbols")
		:with_noremap()
		:with_silent()
		:with_desc("symbols in workspace"),
	["n|<Leader>fz"] = map_cu("Telescope zoxide list")
		:with_noremap()
		:with_silent()
		:with_desc("zoxide: Change direrctory"),
    -- History
	["n|<Leader>hj"] = map_cu("Telescope jumplist"):with_noremap():with_silent():with_desc("jumplist"),
	["n|<Leader>hc"] = map_cu("Telescope command_history"):with_noremap():with_silent():with_desc("command_history"),
	["n|<Leader>hy"] = map_cu("Telescope yank_history"):with_noremap():with_silent():with_desc("yank_history"),
	["n|<Leader>hu"] = map_callback(function()
            require("telescope").extensions.undo.undo()
        end):with_noremap():with_silent()
		:with_desc("Telescope undo history"),
    -- Git
	["n|<Leader>gs"] = map_callback(Telescope_git_status):with_noremap():with_silent():with_desc("git_status"),
	["n|<Leader>gc"] = map_callback(Telescope_git_bcommits):with_noremap():with_silent():with_desc("git_bcommits"),
	["n|<Leader>gC"] = map_callback(Telescope_git_commits):with_noremap():with_silent():with_desc("git_commits"),

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

	-- Plugin spectre
	["n|<Leader>sw"] = map_cr("lua require('spectre').open_visual({select_word=true})")
		:with_noremap()
		:with_silent()
		:with_desc("spectre: Search cursor word"),
	-- search in current file
	["n|<Leader>sf"] = map_cr("lua require('spectre').open_file_search()")
		:with_noremap()
		:with_silent()
		:with_desc("spectre: Search current file"),
	["v|<Leader>sV"] = map_cr("lua require('spectre').open_visual()")
		:with_noremap()
		:with_silent()
		:with_desc("spectre: open_visual"),
	["n|<Leader>sO"] = map_cr("lua require('spectre').open()")
        :with_noremap()
        :with_silent()
        :with_desc("spectre: open"),

	-- Plugin Scratch
	["n|<Leader>sn"] = map_cu("Scratch")
        :with_noremap()
        :with_silent()
        :with_desc("Scratch new"),
	["n|<Leader>so"] = map_cu("ScratchOpen")
        :with_noremap()
        :with_silent()
        :with_desc("Scratch Open"),
	["n|<Leader>sg"] = map_cu("ScratchOpenFzf")
        :with_noremap()
        :with_silent()
        :with_desc("Scratch Open via grep string"),

	-- Plugin nvim-gomove(move/copy text)
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
