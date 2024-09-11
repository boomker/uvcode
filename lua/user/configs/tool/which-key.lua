return function()
	local icons = {
		ui = require("modules.utils.icons").get("ui"),
		misc = require("modules.utils.icons").get("misc"),
		git = require("modules.utils.icons").get("git", true),
		cmp = require("modules.utils.icons").get("cmp", true),
	}

	require("modules.utils").load_plugin("which-key", {
		preset = "classic",
		delay = vim.o.timeoutlen,
		triggers = {
			{ "<auto>", mode = "nixso" },
		},
		plugins = {
			marks = true,
			registers = true,
			spelling = {
				enabled = true,
				suggestions = 20,
			},
			presets = {
				motions = false,
				operators = false,
				text_objects = true,
				windows = true,
				nav = true,
				z = true,
				g = true,
			},
		},
		win = {
			border = "none",
			padding = { 1, 2 },
			wo = { winblend = 0 },
		},
		expand = 1,
		icons = {
			group = "",
			rules = false,
			colors = false,
			breadcrumb = icons.ui.Separator,
			separator = icons.misc.Vbar,
			keys = {
				C = "C-",
				M = "A-",
				S = "S-",
				BS = "<BS> ",
				CR = "<CR> ",
				NL = "<NL> ",
				Esc = "<Esc> ",
				Tab = "<Tab> ",
				Up = "<Up> ",
				Down = "<Down> ",
				Left = "<Left> ",
				Right = "<Right> ",
				Space = "<Space> ",
				ScrollWheelUp = "<ScrollWheelUp> ",
				ScrollWheelDown = "<ScrollWheelDown> ",
			},
		},
		spec = {
			{ "<leader>b", group = icons.ui.Buffer .. " Buffer" },
			{ "<leader>w", group = icons.ui.Window .. " Window" },
			{ "<leader>p", group = icons.ui.Package .. " Package" },
			{ "<leader>d", group = icons.ui.Bug .. " Debug | Diff" },
			{ "<leader>f", group = icons.ui.Telescope .. " Fuzzy Find" },
			{ "<leader>n", group = icons.ui.FolderOpen .. " Nvim Tree" },
			{ "<leader>t", group = icons.ui.Note .. " Todo | Terminal" },
			{ "<leader>m", group = icons.ui.Package .. " Mason | Marks" },
			{ "<leader>r", group = icons.ui.Play .. " Refactor | SnipRun " },
			{ "<leader>g", group = icons.git.Git .. "Git Hunk" },
			{ "<leader>h", group = icons.git.Git .. "Git Hunk" },
			{ "<leader>s", group = icons.cmp.tmux .. "Session | Spectre" },
			{ "<leader>j", group = icons.misc.Ghost .. " Jump | Focus" },
			{ "<leader>c", group = icons.misc.LspAvailable .. " Lsp | Quicklist" },
			{ "<leader>l", group = icons.misc.LspAvailable .. " Lsp | LiveServer" },
		},
	})
end
