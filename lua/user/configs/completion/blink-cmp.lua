return function()
	require("modules.utils").load_plugin("blink.cmp", {
		keymap = {
			preset = "super-tab", --default, enter
			["<C-s>"] = {
				function(cmp)
					cmp.show({ providers = { "snippets" } })
				end,
			},
		},
		signature = { enabled = true },
		completion = {
			keyword = { range = "full" },
			ghost_text = { enabled = true },
			accept = { auto_brackets = { enabled = true } },
			trigger = { show_on_insert_on_trigger_character = true },
			documentation = { auto_show = true, auto_show_delay_ms = 500 },
			list = { selection = { preselect = false, auto_insert = true } },
			menu = {
				border = "single",
			},
		},
		appearance = {
			-- use_nvim_cmp_as_default = true,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			nerd_font_variant = "mono",
		},
		snippets = { preset = "luasnip" },
		sources = {
			default = { "codeium", "lsp", "snippets", "buffer", "path" },
			providers = {
				codeium = {
					name = "codeium",
					module = "blink.compat.source",
					async = true,
					enabled = true,
					max_items = 3,
					score_offset = 5,
				},
				snippets = {
					max_items = 3,
					score_offset = 9,
				},
			},
		},
	})
end
