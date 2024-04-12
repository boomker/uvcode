local editor = {}

editor["danymat/neogen"] = {
	lazy = true,
	cmd = { "Neogen" },
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = require("configs.editor.neogen"),
}

editor["kevinhwang91/nvim-hlslens"] = {
	lazy = true,
	event = "SearchWrapped",
	config = require("configs.editor.nvim-hlslens"),
}

editor["gbprod/yanky.nvim"] = {
	lazy = true,
	event = "VimEnter",
	config = require("configs.editor.yanky"),
	dependencies = { "kkharji/sqlite.lua" },
}

editor["chentoast/marks.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = require("configs.editor.marks"),
}

editor["gbprod/substitute.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = require("configs.editor.substitute"),
}

editor["booperlv/nvim-gomove"] = {
	lazy = true,
	event = "BufRead",
}

editor["rmagatti/alternate-toggler"] = {
	lazy = true,
	event = "BufReadPost",
	config = function()
		require("alternate-toggler").setup({
			alternates = {
				["yes"] = "no",
				["<="] = ">=",
				["=="] = "!=",
				-- ["~="] = "=="
			},
		})
	end,
}

editor["m-demare/hlargs.nvim"] = {
	lazy = true,
	event = "BufRead",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = function()
		require("hlargs").setup({})
	end,
}

editor["stevearc/dressing.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = function()
		require("dressing").setup({})
	end,
}

editor["echasnovski/mini.surround"] = {
    lazy = true,
    version = false,
    event = { "VeryLazy" },
    config = function ()
        require("mini.surround").setup({
            mappings = {
                add = "sm", -- Add surrounding `mark` in Normal and Visual modes
                delete = "sd", -- Delete surrounding
                replace = "sc", -- Replace/change surrounding
                find = "sf", -- Find surrounding (to the right)
                find_left = "sF", -- Find surrounding (to the left)
                highlight = "sh", -- Highlight surrounding
                update_n_lines = "sn", -- Update `n_lines`
            },
        })
    end,
}

editor["echasnovski/mini.bracketed"] = {
    version = false,
    config = function ()
        require("mini.bracketed").setup({
            comment = { suffix = "a", options = {} },
            diagnostic = { suffix = "e" },
            file = { suffix = "v", options = {} },
        })
    end,
}

editor["echasnovski/mini.bufremove"] = {
    lazy = true,
    version = false,
    event = { "VeryLazy" },
    config = function ()
        require("mini.bufremove").setup()
    end,
}

-- editor["Inazuma110/disarrow.vim"] = {
-- 	lazy = true,
-- 	event = "InsertEnter",
-- }

return editor
