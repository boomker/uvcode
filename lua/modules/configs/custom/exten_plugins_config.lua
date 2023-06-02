---@diagnostic disable: unused-local
local config = {}

function config.todo()
	require("todo-comments").setup({
		signs = true, -- show icons in the signs column
		sign_priority = 8, -- sign priority
		-- keywords recognized as todo comments
		keywords = {
			FIX = {
				icon = " ", -- icon used for the sign, and in search results
				color = "error", -- can be a hex color, or a named color (see below)
				alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
				-- signs = false, -- configure signs for some keywords individually
			},
			TODO = { icon = " ", color = "info" },
			HACK = { icon = " ", color = "warning" },
			WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
			PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
			TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
		},
		gui_style = {
			fg = "NONE", -- The gui style to use for the fg highlight group.
			bg = "BOLD", -- The gui style to use for the bg highlight group.
		},
		merge_keywords = true, -- when true, custom keywords will be merged with the defaults
		-- highlighting of the line containing the todo comment
		-- * before: highlights before the keyword (typically comment characters)
		-- * keyword: highlights of the keyword
		-- * after: highlights after the keyword (todo text)
		highlight = {
			multiline = true, -- enable multine todo comments
			multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
			multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
			before = "", -- "fg" or "bg" or empty
			keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
			after = "fg", -- "fg" or "bg" or empty
			pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
			comments_only = true, -- uses treesitter to match keywords in comments only
			max_line_len = 400, -- ignore lines longer than this
			exclude = {}, -- list of file types to exclude highlighting
		},
		-- list of named colors where we try to extract the guifg from the
		-- list of highlight groups or use the hex color if hl not found as a fallback
		colors = {
			error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
			warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
			info = { "DiagnosticInfo", "#2563EB" },
			hint = { "DiagnosticHint", "#10B981" },
			default = { "Identifier", "#7C3AED" },
			test = { "Identifier", "#FF00FF" },
		},
		search = {
			command = "rg",
			args = {
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
			},
			-- regex that will be used to match keywords.
			-- don't replace the (KEYWORDS) placeholder
			pattern = [[\b(KEYWORDS):]], -- ripgrep regex
			-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
		},
	})
end

function config.nvim_marks()
	require("marks").setup({
		default_mappings = false,
        bookmark_3 = {
            sign = "⚑",
            -- virt_text = "hello world"
        },
		mappings = {
			set_next = "m,",
			next = "m;",
			-- preview = "m;",
			delete_line = "m<space>",
			-- delete_line = "mx",
			delete_bookmark = "mx",
			set_bookmark0 = "m0",
			set_bookmark2 = "m2",
			set_bookmark3 = "m3",
			set_bookmark4 = "m4",
            set_bookmark9 = "m9",
			prev = false,
		},
	})
end

function config.nvim_substitute()
    -- Lua
    vim.keymap.set("n", "ss", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
    vim.keymap.set("x", "ss", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
    vim.keymap.set("n", "sl", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
    vim.keymap.set("n", "sk", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
    vim.keymap.set("n", "sr", "<cmd>lua require('substitute.range').operator()<cr>", { noremap = true })
    vim.keymap.set("x", "sr", "<cmd>lua require('substitute.range').visual()<cr>", { noremap = true })
    vim.keymap.set("n", "sw", "<cmd>lua require('substitute.range').word()<cr>", { noremap = true })
    vim.keymap.set("n", "se", "<cmd>lua require('substitute.exchange').operator()<cr>", { noremap = true })
    vim.keymap.set("n", "sL", "<cmd>lua require('substitute.exchange').line()<cr>", { noremap = true })
    vim.keymap.set("n", "sx", "<cmd>lua require('substitute.exchange').cancel()<cr>", { noremap = true })
    vim.keymap.set("x", "X", "<cmd>lua require('substitute.exchange').visual()<cr>", { noremap = true })

	require("substitute").setup({
		--[[ on_substitute = function(event)
			require("yanky").init_ring("p", event.register, event.count, event.vmode:match("[vV]"))
		end, ]]
        on_substitute = require("yanky.integration").substitute(),
	})
end

function config.nvim_visual_multi()
	vim.api.nvim_command([[let g:VM_theme = 'purplegray']])
	-- vim.api.nvim_command([[let g:VM_custom_remaps = {'<c-s>': 'q'}]])
end

function config.nvim_ufo()
	local handler = function(virtText, lnum, endLnum, width, truncate)
		local newVirtText = {}
		local suffix = ("  %d "):format(endLnum - lnum)
		local sufWidth = vim.fn.strdisplaywidth(suffix)
		local targetWidth = width - sufWidth
		local curWidth = 0
		for _, chunk in ipairs(virtText) do
			local chunkText = chunk[1]
			local chunkWidth = vim.fn.strdisplaywidth(chunkText)
			if targetWidth > curWidth + chunkWidth then
				table.insert(newVirtText, chunk)
			else
				chunkText = truncate(chunkText, targetWidth - curWidth)
				local hlGroup = chunk[2]
				table.insert(newVirtText, { chunkText, hlGroup })
				chunkWidth = vim.fn.strdisplaywidth(chunkText)
				-- str width returned from truncate() may less than 2nd argument, need padding
				if curWidth + chunkWidth < targetWidth then
					suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
				end
				break
			end
			curWidth = curWidth + chunkWidth
		end
		table.insert(newVirtText, { suffix, "MoreMsg" })
		return newVirtText
	end

	-- vim.api.nvim_command([[packadd promise-async]])

	vim.o.foldcolumn = "1"
	vim.o.foldlevel = 99
	vim.o.foldlevelstart = 99
	vim.o.foldenable = true
	vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
	local ftMap = {
		vim = "indent",
		python = { "indent" },
		git = "",
	}
	require("ufo").setup({
		fold_virt_text_handler = handler,
		open_fold_hl_timeout = 150,
		close_fold_kinds = { "imports", "comment" },
		preview = {
			win_config = {
				border = { "", "─", "", "", "", "─", "", "" },
				winhighlight = "Normal:Folded",
				winblend = 0,
			},
			mappings = {
				scrollU = "<C-u>",
				scrollD = "<C-d>",
			},
		},
		provider_selector = function(bufnr, filetype, buftype)
			-- if you prefer treesitter provider rather than lsp,
			-- return ftMap[filetype] or {'treesitter', 'indent'}
			return ftMap[filetype]

			-- refer to ./doc/example.lua for detail
		end,
	})
	vim.keymap.set("n", "zR", require("ufo").openAllFolds)
	vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
	vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
	vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
	vim.keymap.set("n", "<leader>zk", function()
		local winid = require("ufo").peekFoldedLinesUnderCursor()
		if not winid then
			vim.lsp.buf.hover()
		end
	end, { desc = "peekFoldedLinesUnderCursor" })
end

function config.bqf()
	vim.cmd([[
        hi BqfPreviewBorder guifg=#50a14f ctermfg=71
        hi link BqfPreviewRange Search
    ]])

	require("bqf").setup({
		auto_enable = true,
		auto_resize_height = true, -- highly recommended enable
		preview = {
			win_height = 12,
			win_vheight = 12,
			delay_syntax = 80,
			border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
			show_title = false,
			---@diagnostic disable-next-line: unused-local
			should_preview_cb = function(bufnr, qwinid)
				local ret = true
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				local fsize = vim.fn.getfsize(bufname)
				if fsize > 100 * 1024 then
					-- skip file size greater than 100k
					ret = false
				elseif bufname:match("^fugitive://") then
					-- skip fugitive buffer
					ret = false
				end
				return ret
			end,
		},
		-- make `drop` and `tab drop` to become preferred
		func_map = {
			drop = "o",
			openc = "O",
			split = "<C-s>",
			tabdrop = "<C-t>",
			tabc = "",
			ptogglemode = "zm",
		},
		filter = {
			-- NOTE: `zf` in quickfix window will enter fzf mode.
			fzf = {
				action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
				extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
			},
		},
	})
end

function config.nvim_yanky()
	local utils = require("yanky.utils")
	local mapping = require("yanky.telescope.mapping")

	require("yanky").setup({
		picker = {
			telescope = {
				mappings = {
					default = mapping.put("p"),
					i = {
						["<c-j>"] = mapping.put("p"),
						["<c-k>"] = mapping.put("P"),
						["<c-x>"] = mapping.delete(),
						["<c-r>"] = mapping.set_register(utils.get_default_register()),
					},
					n = {
						p = mapping.put("p"),
						P = mapping.put("P"),
						d = mapping.delete(),
						r = mapping.set_register(utils.get_default_register()),
					},
				},
			},
		},
	})
	require("telescope").load_extension("yank_history")
end

function config.nvim_lastplace()
	require("nvim-lastplace").setup({
		lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
		lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
		lastplace_open_folds = true,
	})
end

function config.nvim_navic()
	require("nvim-navic").setup({
		icons = {
			File = " ",
			Module = " ",
			Namespace = " ",
			Package = " ",
			Class = " ",
			Method = " ",
			Property = " ",
			Field = " ",
			Constructor = " ",
			Enum = " ",
			Interface = " ",
			Function = " ",
			Variable = " ",
			Constant = " ",
			String = " ",
			Number = " ",
			Boolean = " ",
			Array = " ",
			Object = " ",
			Key = " ",
			Null = " ",
			EnumMember = " ",
			Struct = " ",
			Event = " ",
			Operator = " ",
			TypeParameter = " ",
		},
		highlight = true,
		-- separator = " > ",
		separator = "  ",
		depth_limit = 0,
		depth_limit_indicator = "..",
		safe_output = true,
	})
	-- vim.g.navic_silence = true
end

function config.nvim_neogen()
	local ok, neogen = pcall(require, "neogen")
	if not ok then
		return
	end

	neogen.setup({
		enabled = true,
		snippet_engine = "luasnip",
	})

	vim.keymap.set("n", "<leader>dg", function()
		vim.ui.select({ "func", "class", "type", "file" }, { prompt = "Select type" }, function(command)
			if not command then
				return
			end
			vim.schedule(function()
				require("neogen").generate({ type = command })
			end)
		end)
	end, { desc = "docstring generate" })
end

function config.nvim_lsp_lines()
	require("lsp_lines").setup()
	vim.diagnostic.config({
		virtual_text = false,
		update_in_insert = true,
		-- virtual_lines = true,
		virtual_lines = { only_current_line = true },
	})
end

function config.nvim_treesitter_context()
	-- vim.api.nvim_command([[packadd nvim-treesitter]])
	-- vim.cmd([[hi TreesitterContextBottom gui=underline guisp=Grey]])
	require("treesitter-context").setup({
		enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
		throttle = true,
	})
end

function config.nvim_select_ease()
    -- require("SelectEase").setup({ })
    local select_ease = require("SelectEase")
    local lua_query = [[
        ;; query
        ((identifier) @cap)
        ("string_content" @cap)
        ((true) @cap)
        ((false) @cap)
    ]]
    local python_query = [[
        ;; query
        ((identifier) @cap)
        ((string) @cap)
    ]]

    local queries = {
        lua = lua_query,
        python = python_query,
    }

    vim.keymap.set({ "n", "s", "i" }, "<C-D-k>", function()
        select_ease.select_node({
            queries = queries,
            direction = "previous",
            vertical_drill_jump = true,
            -- visual_mode = true, -- if you want Visual Mode instead of Select Mode
            fallback = function()
                -- if there's no target, this function will be called
                select_ease.select_node({ queries = queries, direction = "previous" })
            end,
        })
    end, {})
    vim.keymap.set({ "n", "s", "i" }, "<C-D-j>", function()
        select_ease.select_node({
            queries = queries,
            direction = "next",
            vertical_drill_jump = true,
            -- visual_mode = true, -- if you want Visual Mode instead of Select Mode
            fallback = function()
                -- if there's no target, this function will be called
                select_ease.select_node({ queries = queries, direction = "next" })
            end,
        })
    end, {})

    vim.keymap.set({ "n", "s", "i" }, "<C-D-h>", function()
        select_ease.select_node({
            queries = queries,
            direction = "previous",
            current_line_only = true,
            -- visual_mode = true, -- if you want Visual Mode instead of Select Mode
        })
    end, {})
    vim.keymap.set({ "n", "s", "i" }, "<C-D-l>", function()
        select_ease.select_node({
            queries = queries,
            direction = "next",
            current_line_only = true,
            -- visual_mode = true, -- if you want Visual Mode instead of Select Mode
        })
    end, {})

    -- previous / next node that matches query
    vim.keymap.set({ "n", "s", "i" }, "<C-D-p>", function()
        select_ease.select_node({ queries = queries, direction = "previous" })
    end, {})
    vim.keymap.set({ "n", "s", "i" }, "<C-D-n>", function()
        select_ease.select_node({ queries = queries, direction = "next" })
    end, {})
end


--[[ function config.nvim_null_ls()
	require("modules.configs.custom.null-ls")
end

function config.nvim_searchbox()
	require("searchbox").setup({
		defaults = {
			modifier = "plain",
			confirm = "menu",
		},
	})
end

function config.nvim_fine_cmdline()
	-- code
	require("fine-cmdline").setup({
		cmdline = {
			prompt = " ",
		},
	})
end ]]

--[[ function config.nvim_surround()
	require("nvim-surround").setup({})
end

function config.nvim_reach()
	require("reach").setup({})
end ]]

--[[ function config.nvim_scratch()
	require("scratch").setup({})
end ]]

return config
