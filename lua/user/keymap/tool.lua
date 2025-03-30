require("user.keymap.helpers")
local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
local vim_path = require("core.global").vim_path

local mappings = {
	plugins = {
		-- Plugin: edgy
		--[[ ["n|<D-S-t>"] = map_callback(function()
				require("edgy").toggle("left")
			end)
			:with_noremap()
			:with_silent()
			:with_desc("filetree: Toggle"), ]]

		-- Plugin neotree
		["n|<D-b>"] = map_cr("Neotree reveal=true toggle"):with_noremap():with_silent():with_desc("filetree: Toggle"),
		["i|<D-b>"] = map_cmd("<esc>:Neotree reveal=true toggle<CR>"):with_noremap():with_desc("filetree: Toggle"),
		["n|<D-g>"] = map_cr("Neotree git_status"):with_noremap():with_silent():with_desc("filetree: git_status"),
		["n|<Leader>nt"] = map_cr("Neotree reveal=true toggle")
			:with_noremap()
			:with_silent()
			:with_desc("filetree: Toggle"),
		["n|<Leader>nf"] = map_cr("Neotree reveal=true float toggle")
			:with_noremap()
			:with_silent()
			:with_desc("filetree: float"),
		["n|<Leader>nb"] = map_cr("Neotree buffers float toggle")
			:with_noremap()
			:with_silent()
			:with_desc("filetree: Buffers"),
		["n|<Leader>ng"] = map_cr("Neotree git_status"):with_noremap():with_silent():with_desc("filetree: git_status"),
		["n|<Leader>jg"] = map_cr("Neotree git_status"):with_noremap():with_silent():with_desc("filetree: git_status"),
		["n|<Leader>jb"] = map_cr("Neotree buffers float toggle")
			:with_noremap()
			:with_silent()
			:with_desc("filetree: Buffers"),
		["n|<Leader>jf"] = map_cr("Neotree reveal=true float toggle")
			:with_noremap()
			:with_silent()
			:with_desc("filetree: float"),

		-- Plugin SnipRun
		["n|<Leader>rr"] = map_cr("SnipRun"):with_noremap():with_silent():with_desc("tool: Run code by inline"),
		["v|<Leader>rr"] = map_cr("SnipRun"):with_noremap():with_silent():with_desc("tool: Run code by range"),
		["n|<Leader>rf"] = map_cu([[%SnipRun]]):with_noremap():with_silent():with_desc("tool: Run code by file"),

		-- Plugin toggleterm
		["t|<ESC><ESC>"] = map_cmd("<C-\\><C-n>"):with_noremap():with_silent(), -- switch to normal mode in terminal.
		["t|jk"] = map_cmd("<C-\\><C-n>"):with_noremap():with_silent(), -- switch to normal mode in terminal.
		["nti|<D-C-\\>"] = map_cmd("<Cmd>ToggleTerm<CR>")
			:with_noremap()
			:with_silent()
			:with_desc("terminal: Toggle horizontal"),
		["n|<Leader>jt"] = map_cmd("<Cmd>ToggleTerm<CR>")
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
				-- Toggle_lazygit()
				_toggle_lazygit()
			end)
			:with_noremap()
			:with_silent()
			:with_desc("git: Toggle lazygit"),
		["t|<D-g>"] = map_callback(function()
				-- Toggle_lazygit()
				_toggle_lazygit()
			end)
			:with_noremap()
			:with_silent()
			:with_desc("git: Toggle lazygit"),

		["n|gt"] = map_cr("Trouble diagnostics toggle")
			:with_noremap()
			:with_silent()
			:with_desc("lsp: Toggle trouble list"),
		["n|<leader>lw"] = map_cr("Trouble diagnostics toggle")
			:with_noremap()
			:with_silent()
			:with_desc("lsp: Show workspace diagnostics"),
		["n|<leader>lp"] = map_cr("Trouble project_diagnostics toggle")
			:with_noremap()
			:with_silent()
			:with_desc("lsp: Show project diagnostics"),
		["n|<leader>ld"] = map_cr("Trouble diagnostics toggle filter.buf=0")
			:with_noremap()
			:with_silent()
			:with_desc("lsp: Show document diagnostics"),

		-- Plugin Telescope
		["i|<D-o>"] = map_cmd("<esc>:Telescope frecency<CR>"):with_noremap():with_silent():with_desc("find freq file"),
		["i|<D-p>"] = map_cmd("<esc>:Telescope find_files<CR>"):with_noremap():with_desc("find file"),
		["i|<D-M-b>"] = map_cmd("<esc>:Telescope buffers<CR>"):with_noremap():with_desc("find buffer"),
		["n|<D-o>"] = map_cu("Telescope frecency"):with_noremap():with_silent():with_desc("find freq file"),
		["n|<D-p>"] = map_cu("Telescope find_files"):with_noremap():with_desc("find file"),
		["n|<D-M-b>"] = map_cu("Telescope buffers"):with_noremap():with_desc("find buffer"),
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
		["n|<Leader>f/"] = map_cu("Telescope current_buffer_fuzzy_find")
			:with_noremap()
			:with_silent()
			:with_desc("grep: word in buffer"),
		["n|<Leader>fc"] = map_cmd(":Telescope cmdline<CR>"):with_noremap():with_silent():with_desc("tool: Cmdline"),
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
		["n|<Leader>fp"] = map_cu("Telescope diagnostics")
			:with_noremap()
			:with_silent()
			:with_desc("diagnostics in project"),
		["n|<Leader>fs"] = map_cu("Telescope lsp_document_symbols")
			:with_noremap()
			:with_silent()
			:with_desc("symbols in document"),
		-- search neovim config file and edit it
		["n|<Leader>fu"] = map_callback(Telescope_find_neovim_config)
			:with_noremap()
			:with_silent()
			:with_desc("search Neovim config"),
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
		["n|<Leader>ff"] = map_callback(function()
				require("search").open({ collection = "file" })
			end)
			:with_noremap()
			:with_silent()
			:with_desc("tool: Find files"),
		["v|<Leader>fs"] = map_callback(function()
				local opts = vim.fn.getcwd() == vim_path and { additional_args = { "--no-ignore" } } or {}
				require("telescope-live-grep-args.shortcuts").grep_visual_selection(opts)
			end)
			:with_noremap()
			:with_silent()
			:with_desc("tool: Find word under cursor"),
		["n|<Leader>fg"] = map_callback(function()
				require("search").open({ collection = "git" })
			end)
			:with_noremap()
			:with_silent()
			:with_desc("tool: Locate Git objects"),
		["n|<Leader>fd"] = map_callback(function()
				require("search").open({ collection = "dossier" })
			end)
			:with_noremap()
			:with_silent()
			:with_desc("tool: Retrieve dossiers"),

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
		["n|<Leader>sg"] = map_cu("ScratchOpenFzf")
			:with_noremap()
			:with_silent()
			:with_desc("Scratch Open via grep string"),

		-- Plugin fedepujol/move.nvim (move text)
		-- Normal-mode commands
		["n|<A-j>"] = map_cmd(":MoveLine(1)<CR>"):with_noremap():with_silent():with_desc("Line: move down"),
		["n|<A-k>"] = map_cmd(":MoveLine(-1)<CR>"):with_noremap():with_silent():with_desc("Line: move up"),
		["n|<A-S-h>"] = map_cmd(":MoveWord(1)<CR>"):with_noremap():with_silent():with_desc("Word: move left"),
		["n|<A-S-l>"] = map_cmd(":MoveWord(-1)<CR>"):with_noremap():with_silent():with_desc("Word: move right"),
		-- Visual-mode commands
		["v|<A-j>"] = map_cmd(":MoveBlock(1)<CR>"):with_noremap():with_silent():with_desc("Block: move down"),
		["v|<A-k>"] = map_cmd(":MoveBlock(-1)<CR>"):with_noremap():with_silent():with_desc("Block: move up"),
		["v|<A-S-h>"] = map_cmd(":MoveHBlock(-1)<CR>"):with_noremap():with_silent():with_desc("Block: move left"),
		["v|<A-S-l>"] = map_cmd(":MoveHBlock(1)<CR>"):with_noremap():with_silent():with_desc("Block: move right"),

		-- Plugin refactoring
		-- ["v|<Leader>re"] = map_cmd([[<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]])
		-- 	:with_noremap()
		-- 	:with_silent()
		-- 	:with_desc("[R]efactor: [E]xtract function"),
		-- ["v|<Leader>rf"] = map_cmd([[<Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]])
		-- 	:with_noremap()
		-- 	:with_silent()
		-- 	:with_desc("[R]efactor: Extract function to [F]ile"),
		-- ["v|<Leader>rv"] = map_cmd([[<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]])
		-- 	:with_noremap()
		-- 	:with_silent()
		-- 	:with_desc("[R]efactor: Extract [V]ariable"),
		-- ["v|<Leader>ri"] = map_cmd([[<Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]])
		-- 	:with_noremap()
		-- 	:with_silent()
		-- 	:with_desc("[R]efactor: [I]nline variable"),
		-- -- Extract block doesn't need visual mode
		-- ["n|<Leader>rb"] = map_cmd([[<Cmd>lua require('refactoring').refactor('Extract Block')<CR>]])
		-- 	:with_noremap()
		-- 	:with_silent()
		-- 	:with_desc("[R]efactor: Extract [B]lock"),
		-- ["n|<Leader>rB"] = map_cmd([[<Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]])
		-- 	:with_noremap()
		-- 	:with_silent()
		-- 	:with_desc("[R]efactor: Extract [B]lock to [F]ile"),
		-- -- Inline variable can also pick up the identifier currently under the cursor without visual mode
		-- ["n|<Leader>ri"] = map_cmd([[<Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]])
		-- 	:with_noremap()
		-- 	:with_silent()
		-- 	:with_desc("[R]efactor: [I]nline variable"),
	},
}

bind.nvim_load_mapping(mappings.plugins)
