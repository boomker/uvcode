local completion = {}

-- completion["zeioth/garbage-day.nvim"] = {
--     lazy = true,
--     event = "LspAttach",
-- }

-- completion["iurimateus/luasnip-latex-snippets.nvim"] = {
--     lazy = true,
--     ft = { "tex", "bib", "markdown" },
--     config = require("configs.completion.luasnip-latex-snippets"),
-- }

-- { "hrsh7th/cmp-cmdline" },

completion["Exafunction/codeium.nvim"] = {
    lazy = true,
    event = { "InsertEnter" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = require("configs.completion.codeium"),
}
return completion
