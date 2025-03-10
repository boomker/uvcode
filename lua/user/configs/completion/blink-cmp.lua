return function()
	require("modules.utils").load_plugin("blink.cmp", {
		keymap = {
			preset = "super-tab", --default, enter
		},
		--[[
		cmdline = {
			enabled = true,
			sources = function()
				local type = vim.fn.getcmdtype()
				if type == "/" or type == "?" then
					return { "buffer" }
				end
				if type == ":" or type == "@" then
					return { "cmdline", "path" }
				end
				return {}
			end,
			keymap = {
				preset = "enter",
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<C-c>"] = { "cancel", "hide", "fallback" },
			},
			completion = {
				menu = {
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind", gap = 1 },
							{ "source_name" },
						},
					},
				},
			},
		},
        --]]
		completion = {
			keyword = { range = "full" },
			ghost_text = { enabled = true },
			accept = { auto_brackets = { enabled = true } },
			trigger = { show_on_insert_on_trigger_character = true },
			list = { selection = { preselect = true, auto_insert = true } },
			menu = {
				auto_show = true,
				border = "rounded",
				draw = {
					treesitter = { "lsp" },
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind", gap = 1 },
						{ "source_name" },
					},
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 300,
				treesitter_highlighting = true,
				window = {
					border = "single",
				},
			},
		},
		appearance = {
			use_nvim_cmp_as_default = false,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			nerd_font_variant = "mono",
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				--[[
				codeium = {
					name = "codeium",
					module = "blink.compat.source",
					async = true,
					enabled = true,
					max_items = 3,
					score_offset = 5,
				},
                --]]
				path = {
					fallbacks = { "snippets", "buffer" },
					opts = {
						trailing_slash = false,
						label_trailing_slash = true,
						show_hidden_files_by_default = true,
						get_cwd = function(context)
							return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
						end,
					},
				},
				snippets = {
					max_items = 3,
					score_offset = 6,
				},
			},
		},
		signature = {
			enabled = true,
			trigger = {
				show_on_insert = true,
			},
			window = {
				border = "single",
				treesitter_highlighting = true,
				show_documentation = true,
			},
		},
		snippets = { preset = "luasnip" },
	})
end
