return function()
	local icons = {
		ui = require("modules.utils.icons").get("ui"),
		misc = require("modules.utils.icons").get("misc"),
		git = require("modules.utils.icons").get("git", true),
		cmp = require("modules.utils.icons").get("cmp", true),
	}

	require("which-key").register({
		["<leader>"] = {
			b = {
				group = icons.ui.Buffer .. " Buffer | BookMark",
			},
			d = {
				group = icons.ui.Bug .. " Debug | Diff",
			},
			f = {
				group = icons.ui.Telescope .. " Fuzzy Find",
			},
			g = {
				group = icons.git.Git .. "Git",
			},
			h = {
				group = icons.git.Git .. "GitHunk",
			},
			l = {
				group = icons.misc.LspAvailable .. " Lsp",
			},
			n = {
				group = icons.ui.FolderOpen .. " Neo-Tree",
			},
			p = {
				group = icons.ui.Package .. " Package",
			},
			s = {
				group = icons.cmp.tmux .. "Session",
			},
			S = {
				group = icons.ui.Search .. " Search",
			},
			w = {
				group = icons.ui.Window .. " Window",
			},
		},
	})

	require("modules.utils").load_plugin("which-key", {
		plugins = {
			presets = {
				operators = false,
				motions = false,
				text_objects = false,
				windows = false,
				nav = false,
				z = true,
				g = true,
			},
		},

		icons = {
			breadcrumb = icons.ui.Separator,
			separator = icons.misc.Vbar,
			group = "",
		},

		window = {
			border = "none",
			position = "bottom",
			margin = { 1, 0, 1, 0 },
			padding = { 1, 1, 1, 1 },
			winblend = 0,
		},
	})
end
