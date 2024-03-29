return function()
	vim.keymap.set("n", "ss", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
	vim.keymap.set("x", "ss", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
	vim.keymap.set("n", "sl", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
	vim.keymap.set("n", "sk", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
	vim.keymap.set("n", "sr", "<cmd>lua require('substitute.range').operator()<cr>", { noremap = true })
	vim.keymap.set("x", "sr", "<cmd>lua require('substitute.range').visual()<cr>", { noremap = true })
	vim.keymap.set("n", "sw", "<cmd>lua require('substitute.range').word()<cr>", { noremap = true })
	vim.keymap.set("n", "se", "<cmd>lua require('substitute.exchange').operator()<cr>", { noremap = true })
	vim.keymap.set("n", "sL", "<cmd>lua require('substitute.exchange').line()<cr>", { noremap = true })
	vim.keymap.set("n", "sx", "<cmd>lua require('substitute.exchange').cancel()<cr>", { noremap = true })
	vim.keymap.set("x", "X", "<cmd>lua require('substitute.exchange').visual()<cr>", { noremap = true })
	require("substitute").setup({

		require("substitute").setup({
			--[[ on_substitute = function(event)
                require("yanky").init_ring("p", event.register, event.count, event.vmode:match("[vV]"))
            end, ]]
			on_substitute = require("yanky.integration").substitute(),
		}),
	})
end
