return function()
    vim.keymap.del('n', 'gO')
    vim.keymap.del('n', 'grn')
    vim.keymap.del('n', 'gra')
    vim.keymap.del('n', 'grr')
    vim.keymap.del('n', 'gri')
    vim.keymap.del('n', 'grt')
	vim.keymap.set("n", "gr", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
	vim.keymap.set("x", "gr", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
	vim.keymap.set("n", "gsl", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
	vim.keymap.set("n", "gsk", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
    -- vim.keymap.set("n", "gsw", "<cmd>lua require('substitute.range').word()<cr>", { noremap = true })
    -- vim.keymap.set("n", "gsl", "<cmd>lua require('substitute.exchange').line()<cr>", { noremap = true })
	vim.keymap.set("n", "gsx", "<cmd>lua require('substitute.exchange').cancel()<cr>", { noremap = true })
    vim.keymap.set("x", "gse", "<cmd>lua require('substitute.exchange').visual()<cr>", { noremap = true })
	vim.keymap.set("n", "gse", "<cmd>lua require('substitute.exchange').operator()<cr>", { noremap = true })

	require("substitute").setup({
		on_substitute = require("yanky.integration").substitute(),
	})
end
