return function()
	vim.keymap.set("n", "gr", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
	vim.keymap.set("x", "gr", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
	vim.keymap.set("n", "grl", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
	vim.keymap.set("n", "grL", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
	vim.keymap.set("n", "gse", "<cmd>lua require('substitute.exchange').operator()<cr>", { noremap = true })
	vim.keymap.set("n", "gsl", "<cmd>lua require('substitute.exchange').line()<cr>", { noremap = true })
	vim.keymap.set("n", "gsx", "<cmd>lua require('substitute.exchange').cancel()<cr>", { noremap = true })
	require("substitute").setup({

		require("substitute").setup({
		--[[ on_substitute = function(event)
                require("yanky").init_ring("p", event.register, event.count, event.vmode:match("[vV]"))
            end, ]]
			on_substitute = require("yanky.integration").substitute(),
		}),
	})
end
