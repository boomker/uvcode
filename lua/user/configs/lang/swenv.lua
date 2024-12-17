return function()
	require("swenv").setup({
		venvs_path = vim.fn.expand("~/.pyvenvs/"),
		get_venvs = function(venvs_path)
			return require("swenv.api").get_venvs(venvs_path)
		end,
		-- post_set_venv = function()
		-- 	vim.cmd("LspRestart")
		-- end,
	})
    vim.api.nvim_create_autocmd("FileType", {
        pattern = {"python"},
        callback = function()
            require('swenv.api').auto_venv()
        end
    })
end
