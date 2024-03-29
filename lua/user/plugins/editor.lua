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

editor["folke/todo-comments.nvim"] = {
	lazy = true,
	event = "VimEnter",
	dependencies = "nvim-lua/plenary.nvim",
	config = require("configs.editor.todo-comments"),
}

-- editor["kylechui/nvim-surround"] = {
-- 	version = "*", -- Use for stability; omit to use `main` branch for the latest features
-- 	event = "InsertEnter",
-- 	config = require("configs.editor.nvim-surround"),
-- }

-- editor["Inazuma110/disarrow.vim"] = {
-- 	lazy = true,
-- 	event = "InsertEnter",
-- }

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
	-- config = require("configs.editor.dressing"),
	config = function()
		require("dressing").setup({})
	end,
}

return editor
