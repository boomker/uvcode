return vim.schedule_wrap(function()
	local use_ssh = require("core.settings").use_ssh

	vim.api.nvim_set_option_value("foldmethod", "expr", {})
	vim.api.nvim_set_option_value("foldexpr", "nvim_treesitter#foldexpr()", {})

	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"bash",
			"c",
			"cpp",
			"css",
			"go",
			"gomod",
			"html",
			"javascript",
			"json",
			"latex",
			"lua",
			"make",
			"markdown",
			"markdown_inline",
			"python",
			"rust",
			"typescript",
			"vimdoc",
			"vue",
			"yaml",
		},
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gsi",
                node_incremental = "gss",
                node_decremental = "gsd",
                scope_incremental = "gsS",
            },
        },
		highlight = {
			enable = true,
			disable = function(ft, bufnr)
				if vim.tbl_contains({ "vim" }, ft) then
					return true
				end

				local ok, is_large_file = pcall(vim.api.nvim_buf_get_var, bufnr, "bigfile_disable_treesitter")
				return ok and is_large_file
			end,
			additional_vim_regex_highlighting = { "c", "cpp" },
		},
		textobjects = {
			select = {
				enable = true,
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
				-- goto_next_start = {
				-- 	["]["] = "@function.outer",
				-- 	["]m"] = "@class.outer",
				-- },
				-- goto_next_end = {
				-- 	["]]"] = "@function.outer",
				-- 	["]M"] = "@class.outer",
				-- },
				-- goto_previous_start = {
				-- 	["[["] = "@function.outer",
				-- 	["[m"] = "@class.outer",
				-- },
				-- goto_previous_end = {
				-- 	["[]"] = "@function.outer",
				-- 	["[M"] = "@class.outer",
				-- },
                goto_next_start = {
                    ["]f"] = "@function.outer",
                    ["]c"] = "@class.outer",
                },
                goto_next_end = {
                    ["]F"] = "@function.outer",
                    ["]C"] = "@class.outer",
                },
                goto_previous_start = {
                    ["[f"] = "@function.outer",
                    ["[c"] = "@class.outer",
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
		rainbow = {
			enable = true,
			extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
			max_file_lines = 2000, -- Do not enable for files with more than 2000 lines, int
		},
		context_commentstring = { enable = true, enable_autocmd = false },
		matchup = { enable = true },
	})
	require("nvim-treesitter.install").prefer_git = true
    require("nvim-treesitter.install").command_extra_args = {
        curl = { "--proxy", "127.0.0.1:7890" },
    }
	if use_ssh then
		local parsers = require("nvim-treesitter.parsers").get_parser_configs()
		for _, p in pairs(parsers) do
			p.install_info.url = p.install_info.url:gsub("https://github.com/", "git@github.com:")
		end
	end
end)
