return function()
	local nvim_lsp = require("lspconfig")

	local opts = {
		capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
		servers = {
			ruff = {
				cmd_env = { RUFF_TRACE = "messages" },
				init_options = {
					settings = {
						logLevel = "warn",
					},
				},
				keys = {
					{
						"<leader>co",
						function()
							vim.lsp.buf.code_action({
								apply = true,
								context = {
									only = { "source.organizeImports" },
									diagnostics = {},
								},
							})
						end,
						desc = "Organize Imports",
					},
				},
			},
			ruff_lsp = {
				keys = {
					{
						"<leader>co",
						function()
							vim.lsp.buf.code_action({
								apply = true,
								context = {
									only = { "source.organizeImports" },
									diagnostics = {},
								},
							})
						end,
						desc = "Organize Imports",
					},
				},
			},
		},
	}
	-- Setup lsps that are not supported by `mason.nvim` but supported by `nvim-lspconfig` here.
	--[[ if vim.fn.executable("dart") == 1 then
		local ok, _opts = pcall(require, "user.configs.lsp-servers.dartls")
		if not ok then _opts = require("completion.servers.dartls") end
		local final_opts = vim.tbl_deep_extend("keep", _opts, opts)
		nvim_lsp.dartls.setup(final_opts)
	end ]]

	-- pcall(require, "user.configs.lsp")
	nvim_lsp.setup(opts)

	pcall(vim.cmd.LspStart) -- Start LSPs
end
