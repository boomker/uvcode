return function()
    local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
    }
    local hooks = require "ibl.hooks"
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)
    -- vim.g.rainbow_delimiters = { highlight = highlight }
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

	require("modules.utils").load_plugin("ibl", {
        -- viewport_buffer = { min = 200, max = 1000, },
		enabled = true,
		debounce = 200,
		indent = {
			char = "│",
			tab_char = "│",
			smart_indent_cap = true,
			priority = 2,
		},
		whitespace = { remove_blankline_trail = true },
		-- Note: The `scope` field requires treesitter to be set up
		scope = {
            highlight = highlight,
			enabled = true,
			char = "┃",
			show_start = true,
			show_end = false,
			injected_languages = true,
			priority = 1000,
			include = {
				node_type = {
					["*"] = {
						"argument_list",
						"arguments",
						"assignment_statement",
						"Block",
						"class",
						"ContainerDecl",
						"dictionary",
						"do_block",
						"do_statement",
						"element",
						"except",
						"FnCallArguments",
						"for",
						"for_statement",
						"function",
						"function_declaration",
						"function_definition",
						"if_statement",
						"IfExpr",
						"IfStatement",
						"import",
						"InitList",
						"list_literal",
						"method",
						"object",
						"ParamDeclList",
						"repeat_statement",
						"selector",
						"SwitchExpr",
						"table",
						"table_constructor",
						"try",
						"tuple",
						"type",
						"var",
						"while",
						"while_statement",
						"with",
					},
				},
			},
		},
		exclude = {
			filetypes = {
				"", -- for all buffers without a file type
				"alpha",
				"big_file_disabled_ft",
				"dashboard",
				"dotooagenda",
				"flutterToolsOutline",
				"fugitive",
				"git",
				"gitcommit",
				"help",
				"json",
				"log",
				"markdown",
				"NvimTree",
				"Outline",
				"peekaboo",
				"startify",
				"TelescopePrompt",
				"todoist",
				"txt",
				"undotree",
				"vimwiki",
				"vista",
			},
			buftypes = { "terminal", "nofile", "quickfix", "prompt" },
		},
	})
end
