return function()
    require("yanky").setup({
        ring = {
            history_length = 100,
            storage = "sqlite",
            storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db", -- Only for sqlite storage
            sync_with_numbered_registers = true,
            cancel_event = "update",
            ignore_registers = { "_" },
            update_register_on_cycle = false,
        },
        picker = {
            select = {
            action = nil, -- nil to use default put action
            },
            telescope = {
            use_default_mappings = true, -- if default mappings should be used
            mappings = nil, -- nil to use default mappings or no mappings (see `use_default_mappings`)
            },
        },
        system_clipboard = {
            sync_with_ring = true,
        },
        highlight = {
            on_put = true,
            on_yank = true,
            timer = 500,
        },
        preserve_cursor_position = {
            enabled = true,
        },
        textobj = {
        enabled = true,
        },
    })

    if vim.env.TMUX and not vim.g.neovide then
        -- `yanky` reads the default register on VimEnter to seed its history.
        -- In tmux TUI sessions that ends up touching the system clipboard and
        -- can fail before the editor is usable. Skip the startup seed there;
        -- subsequent yanks still populate history through TextYankPost.
        vim.api.nvim_clear_autocmds({
            group = "Yanky",
            event = "VimEnter",
        })
    end
end
