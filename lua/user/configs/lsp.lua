return function()
	local nvim_lsp = require("lspconfig")

	local opts = {
		capabilities = require('blink.cmp').get_lsp_capabilities()
	}
	-- Setup lsps that are not supported by `mason.nvim` but supported by `nvim-lspconfig` here.

	if vim.fn.executable("ruff-lsp") == 1 then
		local ok, _opts = pcall(require, "user.configs.lsp-servers.ruff_lsp")
		local final_opts = ok and vim.tbl_deep_extend("keep", _opts, opts) or {}
		nvim_lsp.ruff_lsp.setup(final_opts)
	end

	pcall(vim.cmd.LspStart) -- Start LSPs
end
