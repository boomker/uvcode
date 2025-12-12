local lang = {}

lang["barrett-ruth/live-server.nvim"] = {
    lazy = true,
    config = true,
    ft = { "html", "markdown" },
    build = "pnpm add -g live-server",
    cmd = { "LiveServerStart", "LiveServerStop" },
}

lang["bezhermoso/tree-sitter-ghostty"] = {
    build = "make nvim_install",
    ft = "ghostty",
}

lang["linux-cultist/venv-selector.nvim"] = {
    opts = {
        name = ".venv",
        auto_refresh = true,
    },
    ft = "python", -- Load when opening Python files
    keys = {
        { "<leader>se", "<cmd>VenvSelect<cr>", desc = "Select venv" },
        -- { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
    },
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
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

return lang
