return function ()
    vim.cmd([[
        hi BqfPreviewBorder guifg=#50a14f ctermfg=71
                hi link BqfPreviewRange Search
    ]])

	require("modules.utils").load_plugin("bqf", {
        auto_enable = true,
        auto_resize_height = true, -- highly recommended enable
        preview = {
            win_height = 12,
            win_vheight = 12,
            winblend = 0,
            delay_syntax = 80,
            border = "single",
            wrap = true,
            -- border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
            show_title = false,
            should_preview_cb = function (bufnr, qwinid)
                local ret = true
                local bufname = vim.api.nvim_buf_get_name(bufnr)
                local fsize = vim.fn.getfsize(bufname)
                if fsize > 100 * 1024 then
                    -- skip file size greater than 100k
                    ret = false
                elseif bufname:match("^fugitive://") then
                    -- skip fugitive buffer
                    ret = false
                end
                return ret
            end,
        },
        -- make `drop` and `tab drop` to become preferred
        func_map = {
            drop = "o",
            openc = "O",
            split = "<C-s>",
            tabdrop = "<C-t>",
            tabc = "",
            ptogglemode = "zm",
        },
        filter = {
            -- NOTE: `zf` in quickfix window will enter fzf mode.
            fzf = {
                action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
                extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
            },
        },
    })
end
