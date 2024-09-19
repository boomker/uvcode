return function()
	require("avante_lib").load()
	require("avante").setup({
		-- Your config here!
		---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
		provider = "deepseek", -- Recommend using deepseek
		auto_suggestions_provider = "deepseek", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
		vendors = {

			["deepseek"] = {
				endpoint = "https://api.deepseek.com/chat/completions",
				model = "deepseek-coder",
				-- api_key_name = "cmd:bw get notes DEEPSEEK_API_KEY",
				api_key_name = "DEEPSEEK_API_KEY",
				parse_curl_args = function(opts, code_opts)
					return {
						url = opts.endpoint,
						headers = {
							["Accept"] = "application/json",
							["Content-Type"] = "application/json",
							["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
						},
						body = {
							model = opts.model,
							messages = { -- you can make your own message, but this is very advanced
								{ role = "system", content = code_opts.system_prompt },
								{
									role = "user",
									content = require("avante.providers.openai").get_user_message(code_opts),
								},
							},
							temperature = 0,
							max_tokens = 4096,
							stream = true, -- this will be set by default.
						},
					}
				end,
				parse_response_data = function(data_stream, event_state, opts)
					require("avante.providers").openai.parse_response(data_stream, event_state, opts)
				end,
			},
			["siliconflow"] = {
				endpoint = "https://api.siliconflow.cn/v1/chat/completions",
				model = "deepseek-ai/DeepSeek-Coder-V2-Instruct",
				-- api_key_name = "SILICONFLOW_API_KEY",
				api_key_name = "cmd:echo $SILICONFLOW_API_KEY",
				parse_curl_args = function(opts, code_opts)
					return {
						url = opts.endpoint,
						headers = {
							["Accept"] = "application/json",
							["Content-Type"] = "application/json",
							["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
						},
						body = {
							model = opts.model,
							messages = { -- you can make your own message, but this is very advanced
								{ role = "system", content = code_opts.system_prompt },
								{
									role = "user",
									content = require("avante.providers.openai").get_user_message(code_opts),
								},
							},
							temperature = 0,
							max_tokens = 4096,
							stream = true, -- this will be set by default.
						},
					}
				end,
				parse_response_data = function(data_stream, event_state, opts)
					require("avante.providers").openai.parse_response(data_stream, event_state, opts)
				end,
			},
		},
		behaviour = {
			auto_suggestions = false, -- Experimental stage
			auto_set_keymaps = true,
			auto_set_highlight_group = true,
			support_paste_from_clipboard = false,
			auto_apply_diff_after_generation = false,
		},
		mappings = {
			--- @class AvanteConflictMappings
			diff = {
				ours = "co",
				theirs = "ct",
				all_theirs = "ca",
				both = "cb",
				cursor = "cc",
				next = "]z",
				prev = "[z",
			},
			suggestion = {
				accept = "<M-l>",
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<C-]>",
			},
			jump = {
				next = "]]",
				prev = "[[",
			},
			submit = {
				normal = "<CR>",
				insert = "<C-s>",
			},
			sidebar = {
				switch_windows = "<Tab>",
				reverse_switch_windows = "<S-Tab>",
			},
			ask = "<leader>ia",
			edit = "<leader>ie",
			refresh = "<leader>ir",
			toggle = {
				default = "<leader>it",
				debug = "<leader>id",
				hint = "<leader>ih",
				suggestion = "<leader>is",
			},
			-- switch_provider(target)
		},
		hints = { enabled = true },
		windows = {
			---@type "right" | "left" | "top" | "bottom"
			position = "right", -- the position of the sidebar
			wrap = true, -- similar to vim.o.wrap
			width = 30, -- default % based on available width
			sidebar_header = {
				align = "center", -- left, center, right for title
				rounded = true,
			},
		},
		highlights = {
			diff = {
				current = "DiffText",
				incoming = "DiffAdd",
			},
		},
		--- @class AvanteConflictUserConfig
		diff = {
			autojump = true,
			---@type string | fun(): any
			list_opener = "copen",
		},
	})
end
