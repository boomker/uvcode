return function()
	vim.g.persisted_exists = false
	local persisted = require("persisted")
	persisted.branch = function()
		local branch = vim.fn.systemlist("git branch --show-current")[1]
		return vim.v.shell_error == 0 and branch or nil
	end
	require("modules.utils").load_plugin("persisted", {
		save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
		autostart = true,
		-- Set `lazy = false` in `plugins/editor.lua` to enable this
		autoload = false,
		follow_cwd = true,
		use_git_branch = true,
		ignored_dirs = { { "/", exact = true }, "~/.local/nvim", "~/.local/share/nvim" },
		should_save = function()
			return vim.bo.filetype == "alpha" and false or true
		end,
	})
end
