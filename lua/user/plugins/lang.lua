local lang = {}

lang["barrett-ruth/live-server.nvim"] = {
	lazy = true,
	ft = { "html", "markdown" },
	build = "pnpm add -g live-server",
	cmd = { "LiveServerStart", "LiveServerStop" },
	config = true,
}

lang["AckslD/swenv.nvim"] = {
	lazy = true,
	ft = "python",
	event = { "BufRead", "BufNew" },
	config = require("user.configs.lang.swenv"),
	dependencies = { "nvim-lua/plenary.nvim", "ahmedkhalf/project.nvim" },
}

lang["bezhermoso/tree-sitter-ghostty"] = {
	build = "make nvim_install",
	ft = "ghostty",
}
-- === overwrite plugins config -- ===

lang["MeanderingProgrammer/render-markdown.nvim"] = {
	lazy = true,
	ft = { "markdown", "Avante" },
	config = require("lang.render-markdown"),
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-treesitter/nvim-treesitter",
	},
}

--[[
{
  'linux-cultist/venv-selector.nvim',
  dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
  opts = {
    -- Your options go here
    -- name = "venv",
    -- auto_refresh = false
  },
  event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  keys = {
    -- Keymap to open VenvSelector to pick a venv.
    { '<leader>vs', '<cmd>VenvSelect<cr>' },
    -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
    { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
  },
}
--]]

return lang
