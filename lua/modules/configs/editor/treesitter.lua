return vim.schedule_wrap(function()
	local use_ssh = require("core.settings").use_ssh

	vim.api.nvim_set_option_value("foldmethod", "expr", {})
	vim.api.nvim_set_option_value("foldexpr", "nvim_treesitter#foldexpr()", {})

	require("modules.utils").load_plugin("nvim-treesitter", {
		ensure_installed = require("core.settings").treesitter_deps,
		highlight = {
			enable = true,
			disable = function(ft)
				return vim.tbl_contains({ "gitcommit" }, ft)
			end,
			additional_vim_regex_highlighting = false,
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",

					["ab"] = "@block.outer",
					["ib"] = "@block.inner",

					["ac"] = "@conditional.outer",
					["ic"] = "@conditional.inner",

					["ao"] = "@loop.outer",
					["io"] = "@loop.inner",

					["af"] = "@function.outer",
					["if"] = "@function.inner",

					["aC"] = "@class.outer",
					["iC"] = "@class.inner",

					-- ["ar"] = "@call.outer",
					-- ["ir"] = "@call.inner",
					["au"] = "@comment.outer",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]f"] = "@function.outer",
					-- ["]c"] = "@class.outer",
				},
				goto_next_end = {
					["]F"] = "@function.outer",
					["]C"] = "@class.outer",
				},
				goto_previous_start = {
					["[f"] = "@function.outer",
					-- ["[c"] = "@class.outer",
				},
				goto_previous_end = {
					["[F"] = "@function.outer",
					["[C"] = "@class.outer",
				},
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>ma"] = "@parameter.inner",
					["<leader>mf"] = "@function.outer",
					-- [">a"] = "@parameter.inner",
				},
				swap_previous = {
					["<leader>mA"] = "@parameter.inner",
					["<leader>mF"] = "@function.outer",
					-- ["<a"] = "@parameter.inner",
				},
			},
		},
		indent = { enable = true },
		matchup = { enable = true },
	}, false, require("nvim-treesitter.configs").setup)
	require("nvim-treesitter.install").prefer_git = true
	require("nvim-treesitter.install").command_extra_args = {
		curl = { "--proxy", "127.0.0.1:1087" },
		-- curl = { "--proxy", "127.0.0.1:7890" },
	}
	if use_ssh then
		local parsers = require("nvim-treesitter.parsers").get_parser_configs()
		for _, parser in pairs(parsers) do
			parser.install_info.url = parser.install_info.url:gsub("https://github.com/", "git@github.com:")
		end
	end
end)
