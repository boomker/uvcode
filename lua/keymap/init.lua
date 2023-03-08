local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
require "keymap.helpers"

local function t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end


local plug_map = {
	-- Bufferline
	["n|<leader>k"] = map_cr("BufferLinePick"):with_noremap():with_silent(),
    -- ["n|<leader>js"] = map_cmd("<C-6>"):with_noremap():with_silent(),
    ["n|<leader>jl"] = map_cmd("<C-6>"):with_noremap():with_silent(),
	["n|<leader>jn"] = map_cr("BufferLineCycleNext"):with_noremap():with_silent():with_desc("buffer: Switch to next"),
	["n|<leader>jp"] = map_cr("BufferLineCyclePrev"):with_noremap():with_silent():with_desc("buffer: Switch to prev"),
    -- ["n|<leader>bn"] = map_cr("BufferLineCycleNext"):with_noremap():with_silent(),
	-- ["n|<leader>bb"] = map_cr("BufferLineCyclePrev"):with_noremap():with_silent(),
	["n|<leader>be"] = map_cr("BufferLineSortByExtension"):with_noremap():with_desc("buffer: Sort by extension"),
	["n|<leader>bd"] = map_cr("BufferLineSortByDirectory"):with_noremap():with_desc("buffer: Sort by direrctory"),

	["n|<A-S-j>"] = map_cr("BufferLineMoveNext"):with_noremap():with_silent():with_desc("buffer: Move current to next"),
	["n|<A-S-k>"] = map_cr("BufferLineMovePrev"):with_noremap():with_silent():with_desc("buffer: Move current to prev"),
	["n|<A-1>"] = map_cr("BufferLineGoToBuffer 1"):with_noremap():with_silent():with_desc("buffer: Goto buffer 1"),
	["n|<A-2>"] = map_cr("BufferLineGoToBuffer 2"):with_noremap():with_silent():with_desc("buffer: Goto buffer 2"),
	["n|<A-3>"] = map_cr("BufferLineGoToBuffer 3"):with_noremap():with_silent():with_desc("buffer: Goto buffer 3"),
	["n|<A-4>"] = map_cr("BufferLineGoToBuffer 4"):with_noremap():with_silent():with_desc("buffer: Goto buffer 4"),
	["n|<A-5>"] = map_cr("BufferLineGoToBuffer 5"):with_noremap():with_silent():with_desc("buffer: Goto buffer 5"),
	["n|<A-6>"] = map_cr("BufferLineGoToBuffer 6"):with_noremap():with_silent():with_desc("buffer: Goto buffer 6"),
	["n|<A-7>"] = map_cr("BufferLineGoToBuffer 7"):with_noremap():with_silent():with_desc("buffer: Goto buffer 7"),
	["n|<A-8>"] = map_cr("BufferLineGoToBuffer 8"):with_noremap():with_silent():with_desc("buffer: Goto buffer 8"),
	["n|<A-9>"] = map_cr("BufferLineGoToBuffer 9"):with_noremap():with_silent():with_desc("buffer: Goto buffer 9"),

	-- Lazy.nvim
	["n|<leader>ph"] = map_cr("Lazy"):with_silent():with_noremap():with_nowait():with_desc("package: Show"),
	["n|<leader>ps"] = map_cr("Lazy sync"):with_silent():with_noremap():with_nowait():with_desc("package: Sync"),
	["n|<leader>pu"] = map_cr("Lazy update"):with_silent():with_noremap():with_nowait():with_desc("package: Update"),
	["n|<leader>pi"] = map_cr("Lazy install"):with_silent():with_noremap():with_nowait():with_desc("package: Install"),
	["n|<leader>pl"] = map_cr("Lazy log"):with_silent():with_noremap():with_nowait():with_desc("package: Log"),
	["n|<leader>pc"] = map_cr("Lazy check"):with_silent():with_noremap():with_nowait():with_desc("package: Check"),
	["n|<leader>pd"] = map_cr("Lazy debug"):with_silent():with_noremap():with_nowait():with_desc("package: Debug"),
	["n|<leader>pp"] = map_cr("Lazy profile"):with_silent():with_noremap():with_nowait():with_desc("package: Profile"),
	["n|<leader>pr"] = map_cr("Lazy restore"):with_silent():with_noremap():with_nowait():with_desc("package: Restore"),
	["n|<leader>px"] = map_cr("Lazy clean"):with_silent():with_noremap():with_nowait():with_desc("package: Clean"),

	-- Lsp mapp work when insertenter and lsp start
	["n|<leader>li"] = map_cr("LspInfo"):with_noremap():with_silent():with_nowait():with_desc("lsp: Info"),
	["n|<leader>lr"] = map_cr("LspRestart"):with_noremap():with_silent():with_nowait():with_desc("lsp: Restart"),
	["n|<leader>ol"] = map_cr("Lspsaga outline"):with_noremap():with_silent():with_desc("lsp: Toggle outline"),
	["n|go"] = map_cr("Lspsaga outline"):with_noremap():with_silent():with_desc("lsp: Toggle outline"),
	["n|[d"] = map_cr("Lspsaga diagnostic_jump_prev"):with_noremap():with_silent():with_desc("lsp: Prev diagnostic"),
	["n|]d"] = map_cr("Lspsaga diagnostic_jump_next"):with_noremap():with_silent():with_desc("lsp: Next diagnostic"),
	["n|<leader>sl"] = map_cr("Lspsaga show_line_diagnostics")
		:with_noremap()
		:with_silent()
		:with_desc("lsp: Line diagnostic"),
	["n|<leader>st"] = map_cr("Lspsaga show_cursor_diagnostics")
		:with_noremap()
		:with_silent()
		:with_desc("lsp: Cursor diagnostic"),
	["n|gh"] = map_callback(function()
			vim.lsp.buf.signature_help()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("lsp: Signature help"),
	["n|<leader>rn"] = map_cr("Lspsaga rename"):with_noremap():with_silent():with_desc("lsp: Rename in file range"),
	["n|<leader>rN"] = map_cr("Lspsaga rename ++project")
		:with_noremap()
		:with_silent()
		:with_desc("lsp: Rename in project range"),
	["n|K"] = map_cr("Lspsaga hover_doc"):with_noremap():with_silent():with_desc("lsp: Show doc"),
	["n|<leader>ca"] = map_cr("Lspsaga code_action")
		:with_noremap()
		:with_silent()
		:with_desc("lsp: Code action for cursor"),
	["v|<leader>ca"] = map_cu("Lspsaga code_action")
		:with_noremap()
		:with_silent()
		:with_desc("lsp: Code action for range"),
	["n|gd"] = map_cr("Lspsaga peek_definition"):with_noremap():with_silent():with_desc("lsp: Preview definition"),
	["n|gD"] = map_cr("Lspsaga goto_definition"):with_noremap():with_silent():with_desc("lsp: Goto definition"),
	["n|gr"] = map_cr("Lspsaga lsp_finder"):with_noremap():with_silent():with_desc("lsp: Show reference"),
	["n|<leader>ci"] = map_cr("Lspsaga incoming_calls")
		:with_noremap()
		:with_silent()
		:with_desc("lsp: Show incoming calls"),
	["n|<leader>co"] = map_cr("Lspsaga outgoing_calls")
		:with_noremap()
		:with_silent()
		:with_desc("lsp: Show outgoing calls"),
	["n|<leader>cf"] = map_cr("lua vim.lsp.buf.format()"):with_noremap():with_silent(),
	["x|<leader>cf"] = map_cr("lua vim.lsp.buf.format()"):with_noremap():with_silent(),
	-- ["n|gps"] = map_cr("G push"):with_noremap():with_silent():with_desc("git: Push"),
	-- ["n|gpl"] = map_cr("G pull"):with_noremap():with_silent():with_desc("git: Pull"),

	-- toggleterm
    -- ["t|jk"] = map_cmd("<C-\\><C-n>"):with_silent(), -- switch to normal mode in terminal.
	["n|<D-C-\\>"] = map_cmd("<Esc><Cmd>ToggleTerm<CR>")
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle horizontal"),
	["t|<D-C-\\>"] = map_cmd("<Esc><Cmd>ToggleTerm<CR>")
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle horizontal"),
    ["n|<leader>tt"] = map_cr([[execute v:count . "ToggleTerm direction=horizontal"]])
        :with_noremap()
        :with_silent()
        :with_desc("terminal: Toggle horizontal"),
	["n|<leader>tv"] = map_cr([[execute v:count . "ToggleTerm direction=vertical"]])
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle vertical"),
	["n|<leader>tf"] = map_cr([[execute v:count . "ToggleTerm direction=float"]])
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
	["n|<leader>tL"] = map_cmd(":ToggleTermSendCurrentLine<CR>"):with_noremap():with_silent(),
	["v|<leader>tV"] = map_cmd(":ToggleTermSendVisualLines<CR>"):with_noremap():with_silent(),
	["n|<leader>lg"] = map_callback(function()
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
	-- ["n|<leader>G"] = map_cu("Git"):with_noremap():with_silent():with_desc("git: Open git-fugitive"),

	-- plugin todo-comments
	["n|<leader>tj"] = map_cr("lua require('todo-comments').jump_next()"):with_noremap():with_silent(),
	["n|<leader>tk"] = map_cr("lua require('todo-comments').jump_prev()"):with_noremap():with_silent(),
	["n|[t"] = map_cr("lua require('todo-comments').jump_next()"):with_noremap():with_silent(),
	["n|]t"] = map_cr("lua require('todo-comments').jump_prev()"):with_noremap():with_silent(),

	-- Plugin trouble
	["n|gt"] = map_cr("TroubleToggle"):with_noremap():with_silent():with_desc("lsp: Toggle trouble list"),
	["n|<leader>tr"] = map_cr("TroubleToggle lsp_references")
		:with_noremap()
		:with_silent()
		:with_desc("lsp: Show lsp references"),
	["n|<leader>td"] = map_cr("TroubleToggle document_diagnostics")
		:with_noremap()
		:with_silent()
		:with_desc("lsp: Show document diagnostics"),
	["n|<leader>tw"] = map_cr("TroubleToggle workspace_diagnostics")
		:with_noremap()
		:with_silent()
		:with_desc("lsp: Show workspace diagnostics"),
	["n|<leader>tq"] = map_cr("TroubleToggle quickfix")
		:with_noremap()
		:with_silent()
		:with_desc("lsp: Show quickfix list"),
	["n|<leader>tl"] = map_cr("TroubleToggle loclist"):with_noremap():with_silent():with_desc("lsp: Show loclist"),

	-- Plugin nvim-tree
	["n|<leader>nt"] = map_cr("NvimTreeToggle"):with_noremap():with_silent():with_desc("filetree: Toggle"),
	["n|<leader>nf"] = map_cr("NvimTreeFindFile"):with_noremap():with_silent():with_desc("filetree: Find file"),
	["n|<leader>nr"] = map_cr("NvimTreeRefresh"):with_noremap():with_silent():with_desc("filetree: Refresh"),
	["n|<leader>nb"] = map_cu(":enew"):with_noremap():with_silent():with_desc("buffer: New"),

	-- Plugin Telescope
	["n|<leader>sc"] = map_cu("Telescope colorscheme")
		:with_noremap()
		:with_silent()
		:with_desc("ui: Change colorscheme for current session"),
    ["n|<Leader>fa"] = map_cu("Telescope"):with_noremap():with_silent(),
    ["n|<Leader>fc"] = map_cu("Telescope commands"):with_noremap():with_silent(),
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
	["n|<leader>fo"] = map_cu("Telescope oldfiles"):with_noremap():with_silent():with_desc("find: File by history"),
	-- ["n|<leader>fe"] = map_cu("Telescope find_files"):with_noremap():with_silent():with_desc("find: File in CWD"),
	["n|<leader>fj"] = map_callback(function()
			Telescope_project_files()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: file in git project"),
	["n|<leader>fz"] = map_cu("Telescope zoxide list")
		:with_noremap()
		:with_silent()
		:with_desc("editn: Change current direrctory by zoxide"),
    ["n|<Leader>fw"] = map_cu("Telescope current_buffer_fuzzy_find"):with_noremap():with_silent(),
	["n|<Leader>fb"] = map_callback(function()
			Telescope_rg_live_grep({ scope = "buffers" })
		end)
		:with_noremap()
		:with_silent()
		:with_desc("rg live: word in buffers opened"),
    ["n|<Leader>fl"] = map_callback(function()
            Telescope_rg_live_grep({ scope = "project" })
        end)
        :with_noremap()
        :with_silent()
        :with_desc("rg live: word in project"),
	["n|<leader>fL"] = map_callback(function()
			require("telescope").extensions.live_grep_args.live_grep_args()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: Word in project"),
	["n|<leader>fk"] = map_cu("Telescope grep_string"):with_noremap():with_silent():with_desc("find: Current word"),
	["n|<Leader>fK"] = map_callback(function()
			Telescope_rg_kw({ word_match = true })
		end)
		:with_noremap()
		:with_silent(),
	["n|<Leader>fJ"] = map_cu("Telescope jumplist"):with_noremap():with_silent(),
	["n|<Leader>fM"] = map_callback(command_panel):with_silent():with_noremap():with_desc("tool: Toggle command panel"),
	["n|<Leader>fm"] = map_cu("Telescope marks"):with_noremap():with_silent(),
	["n|<Leader>fn"] = map_cu("Telescope notify"):with_noremap():with_silent(),
	["n|<Leader>fr"] = map_cu("Telescope lsp_references"):with_noremap():with_silent(),
	["n|<Leader>fs"] = map_cu("Telescope lsp_document_symbols"):with_noremap():with_silent(),
	["n|<Leader>fg"] = map_cu("Telescope git_status"):with_noremap():with_silent(),
	-- ["n|<Leader>fC"] = map_cu("Telescope command_history"):with_noremap():with_silent(),
	-- NOTE: do diagnostic for all buffers
	["n|<Leader>fd"] = map_cu("Telescope diagnostics"):with_noremap():with_silent(),
	["n|<Leader>fy"] = map_cu("Telescope yank_history"):with_noremap():with_silent(),
	["n|<Leader>fh"] = map_cu("Telescope help_tags"):with_noremap():with_silent(),
	["n|<Leader>ft"] = map_cu("TodoTelescope"):with_noremap():with_silent(),
	["n|<D-p>"] = map_cu("Telescope buffers"):with_noremap():with_silent():with_desc("find: Buffer opened"),

	-- Plugin accelerate-jk
	["n|j"] = map_callback(function()
		return t("<Plug>(accelerated_jk_gj)")
	end):with_expr(),
	["n|k"] = map_callback(function()
		return t("<Plug>(accelerated_jk_gk)")
	end):with_expr(),

	--Plugin spectre
	-- "search cursor word
	["n|<leader>sw"] = map_cr("lua require('spectre').open_visual({select_word=true})"):with_noremap():with_silent(),
	["v|<leader>ss"] = map_cr("lua require('spectre').open_visual()"):with_noremap():with_silent(),
	["n|<leader>ss"] = map_cr("lua require('spectre').open()"):with_noremap():with_silent(),
	-- "  search in current file
	["n|<leader>sf"] = map_cr("lua require('spectre').open_file_search()"):with_noremap():with_silent(),

	-- Plugin rmagatti/alternate-toggler
	["n|<leader>a"] = map_cu("ToggleAlternate"):with_noremap():with_silent(),

	-- Plugin Hop
	["|<leader>jd"] = map_cu("HopWordAC"):with_noremap():with_silent(),
    ["|<leader>ju"] = map_cu("HopWordBC"):with_noremap():with_silent(),
	-- ["|<leader>jf"] = map_cu("HopChar1"):with_noremap():with_silent(),
	-- ["|<leader>jz"] = map_cu("HopChar2"):with_noremap():with_silent(),
	-- ["|<leader>jl"] = map_cu("HopChar1CurrentLine"):with_noremap():with_silent(),

	-- Plugin vim-visual-multi
	-- NOTE: `Tab`:switch mode; `q, Q`: skip, remove region; n, N: goto next/prev
	["n|<leader>ms"] = map_cmd([[<Plug>(VM-Select-All)]]):with_noremap():with_silent(),
	["x|<leader>ms"] = map_cmd([[<Plug>(VM-Select-All)]]):with_silent(),
	["n|<leader>md"] = map_cmd([[<Plug>(VM-Find-Under)]]):with_noremap():with_silent(),
	["x|<leader>md"] = map_cmd([[<Plug>(VM-Find-Subword-Under)]]):with_silent(),

	-- Plugin EasyAlign
	["n|ga"] = map_callback(function()
			return t("<Plug>(EasyAlign)")
		end)
		:with_expr()
		:with_desc("editn: Align with delimiter"),
	["x|ga"] = map_callback(function()
			return t("<Plug>(EasyAlign)")
		end)
		:with_expr()
		:with_desc("editx: Align with delimiter"),

	-- Plugin MarkdownPreview
	-- ["n|<F12>"] = map_cr("MarkdownPreviewToggle"):with_noremap():with_silent():with_desc("tool: Preview markdown"),

	-- Plugin SnipRun
	["n|<leader>rr"] = map_cr("SnipRun"):with_noremap():with_silent(),
	["v|<leader>rr"] = map_cr("SnipRun"):with_noremap():with_silent():with_desc("tool: Run code by range"),
	["n|<leader>rf"] = map_cu([[%SnipRun]]):with_noremap():with_silent():with_desc("tool: Run code by file"),
	["c|%R"] = map_cu([[%SnipRun]]):with_noremap(),

	-- Plugin Scratch
	["n|<leader>sn"] = map_cu("Scratch"):with_noremap():with_silent(),
	["n|<leader>so"] = map_cu("ScratchOpen"):with_noremap():with_silent(),

	-- Plugin auto_session
	["n|<leader>sa"] = map_cu("SaveSession"):with_noremap():with_silent():with_desc("session: Save"),
	["n|<leader>sr"] = map_cu("RestoreSession"):with_noremap():with_silent():with_desc("session: Restore"),
	["n|<leader>sd"] = map_cu("DeleteSession"):with_noremap():with_silent():with_desc("session: Delete"),

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

    -- Plugin: treehopper
    ["o|m"] = map_cr("lua require('tsht').nodes()"):with_silent():with_desc("jump: Operate across syntax tree"),
    ["x|m"] = map_cr("lua require('tsht').nodes()"):with_silent():with_desc("jump: Operate across syntax tree"),

	-- Plugin Diffview
	["n|<leader>df"] = map_cr("DiffviewOpen"):with_silent():with_noremap():with_desc("git: Show diff"),
	["n|<leader>dx"] = map_cr("DiffviewClose"):with_silent():with_noremap():with_desc("git: Close diff"),
	["n|<leader>dh"] = map_cr("DiffviewFileHistory"):with_silent():with_noremap(),

	-- Plugin Tabout
	["i|<C-S-l>"] = map_cmd("<Plug>(TaboutMulti)"):with_silent():with_noremap():with_desc("editi: Goto end of pair"),
	["i|<C-S-h>"] = map_cmd("<Plug>(TaboutBackMulti)")
		:with_silent()
		:with_noremap()
		:with_desc("editi: Goto begin of pair"),

	-- Plugin Comment.nvim
	["n|gcc"] = map_callback(function()
			return vim.v.count == 0 and t("<Plug>(comment_toggle_linewise_current)")
				or t("<Plug>(comment_toggle_linewise_count)")
		end)
		:with_silent()
		:with_noremap()
		:with_expr()
		:with_desc("editn: Toggle comment for line"),
	["n|gcb"] = map_callback(function()
			return vim.v.count == 0 and t("<Plug>(comment_toggle_blockwise_current)")
				or t("<Plug>(comment_toggle_blockwise_count)")
		end)
		:with_silent()
		:with_noremap()
		:with_expr()
		:with_desc("editn: Toggle comment for block"),
	--[[ ["n|gc"] = map_cmd("<Plug>(comment_toggle_linewise)")
		:with_silent()
		:with_noremap()
		:with_desc("editn: Toggle comment for line with operator"),
	["n|gb"] = map_cmd("<Plug>(comment_toggle_blockwise)")
		:with_silent()
		:with_noremap()
		:with_desc("editn: Toggle comment for block with operator"), ]]
	["x|gc"] = map_cmd("<Plug>(comment_toggle_linewise_visual)")
		:with_silent()
		:with_noremap()
		:with_desc("editx: Toggle comment for line with selection"),
	["x|gb"] = map_cmd("<Plug>(comment_toggle_blockwise_visual)")
		:with_silent()
		:with_noremap()
		:with_desc("editx: Toggle comment for block with selection"),

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
}

bind.nvim_load_mapping(plug_map)
