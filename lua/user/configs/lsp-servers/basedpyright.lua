local util = require("lspconfig.util")

local root_files = {
	"Pipfile",
	"setup.py",
	"setup.cfg",
	"pyproject.toml",
	"requirements.txt",
	"pyrightconfig.json",
	-- ".git",
}

local function organize_imports()
	local params = {
		command = "basedpyright.organizeimports",
		arguments = { vim.uri_from_bufnr(0) },
	}

	local clients = util.get_lsp_clients({
		bufnr = vim.api.nvim_get_current_buf(),
		name = "basedpyright",
	})
	for _, client in ipairs(clients) do
		client.request("workspace/executeCommand", params, nil, 0)
	end
end

local function get_python_venvPath()
	-- local ws = require("venv-selector").workspace_paths()
	-- return ws and ws[1] .. "/.venv/bin/python"
	return vim.fn.expandcmd("%:p:h") .. "/.venv/bin/python"
end

return {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_dir = function(fname)
		return util.root_pattern(unpack(root_files))(fname)
	end,
	single_file_support = true,
	settings = {
		basedpyright = {
			analysis = {
				autoSearchPaths = true,
				autoImportCompletions = true,
				useLibraryCodeForTypes = true,
				reportMissingTypeStubs = false,
				typeCheckingMode = "basic", -- standard
				diagnosticMode = "openFilesOnly",
				diagnosticSeverityOverrides = {
					reportUnusedImport = "information",
					reportUnusedFunction = "information",
					reportUnusedVariable = "information",
					reportGeneralTypeIssues = "none",
					reportOptionalSubscript = "none",
					reportPrivateImportUsage = "none",
					reportOptionalMemberAccess = "none",
				},
			},
		},
		python = { pythonPath = get_python_venvPath() },
	},
	commands = {
		PyrightOrganizeImports = {
			organize_imports,
			description = "Organize Imports",
		},
	},
}
