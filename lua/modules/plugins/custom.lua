local custom = {}
local conf = require("modules.configs.custom.exten_plugins_config")
-- local overseer_conf = require("modules.configs.custom.overseer")

custom["folke/todo-comments.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = conf.todo,
}

custom["ThePrimeagen/refactoring.nvim"] = {
    lazy = true,
    envet = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("refactoring").setup()
    end,
}

custom["ziontee113/SelectEase"] = {
    lazy = true,
    event = "VeryLazy",
    config = conf.nvim_select_ease,
}

custom["chentoast/marks.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = conf.nvim_marks,
}

custom["mg979/vim-visual-multi"] = {
	lazy = true,
	event = "BufRead",
	config = conf.nvim_visual_multi,
}

custom["LintaoAmons/scratch.nvim"] = {
	lazy = true,
	event = "BufRead",
	-- config = function()
	-- 	require("scratch").setup({})
	-- end,
}

custom["gbprod/yanky.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = conf.nvim_yanky,
}

custom["gbprod/substitute.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = conf.nvim_substitute,
}

custom["kevinhwang91/nvim-ufo"] = {
	lazy = true,
	event = "BufRead",
	config = conf.nvim_ufo,
	dependencies = { { "kevinhwang91/promise-async", lazy = true } },
}

custom["kevinhwang91/nvim-bqf"] = {
	lazy = true,
	event = "BufRead",
	config = conf.nvim_bqf,
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
		{
			"junegunn/fzf",
			build = function()
				vim.fn["fzf#install"]()
			end,
		},
	},
}

custom["stevearc/dressing.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = conf.nvim_dressing,
}

--[[ custom["ishan9299/nvim-solarized-lua"] = {
	lazy = true,
	event = "BufRead",
} ]]

custom["ethanholz/nvim-lastplace"] = {
	lazy = true,
	event = "BufRead",
	config = conf.nvim_lastplace,
}

custom["MunifTanjim/nui.nvim"] = {
	lazy = true,
	event = "BufRead",
}

custom["booperlv/nvim-gomove"] = {
    lazy = true,
	event = "BufRead",
}

custom["rmagatti/alternate-toggler"] = {
	lazy = true,
	event = "BufReadPost",
	config = function()
		require("alternate-toggler").setup({
            alternates = {
                ["yes"] = "no",
                ["<="] = ">=",
                ["=="] = "!=",
                -- ["~="] = "=="
            }
        })
    end
}

custom["danymat/neogen"] = {
	lazy = true,
	event = "BufRead",
	config = conf.nvim_neogen,
	dependencies = "nvim-treesitter/nvim-treesitter",
}

custom["Maan2003/lsp_lines.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = conf.nvim_lsp_lines,
}

custom["m-demare/hlargs.nvim"] = {
	lazy = true,
	event = "BufRead",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = function()
		require("hlargs").setup({

        })
        --[[ build_position_cb = function(plist, _, _, _)
            require("scrollbar.handlers.search").handler.show(plist.start_pos)
        end,
    })

    vim.cmd([[
        augroup scrollbar_search_hide
            autocmd!
            autocmd CmdlineLeave : lua require('scrollbar.handlers.search').handler.hide()
        augroup END
        )]]
	end,
}

custom["nvim-treesitter/nvim-treesitter-context"] = {
	lazy = true,
	event = "BufRead",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = conf.nvim_treesitter_context,
}

custom["someone-stole-my-name/yaml-companion.nvim"] = {
  dependencies = {
      -- { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
  },
  config = function()
      require("telescope").load_extension("yaml_schema")
      --[[ require("yaml-companion").setup({
          schemas = {
            {
                name = "rime",
                uri = "file://./rime-yaml-schema.json",
            },
          },
      }) ]]
  end,
}

-- custom["stevearc/overseer.nvim"] = {
-- 	lazy = true,
-- 	event = "BufRead",
-- 	-- dependencies = "nvim-treesitter/nvim-treesitter",
--     config = overseer_conf
-- }

--[[ custom['lewis6991/satellite.nvim'] = {
	lazy = true,
	event = "BufRead",
	-- config = function()
 --        require('satellite').setup()
	-- end
} ]]

--[[ custom["jackMort/ChatGPT.nvim"] = {
	lazy = true,
    config = function()
        require("chatgpt").setup({
            -- optional configuration
        })
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim"
    }
} ]]


--[[    custom["VonHeikemen/fine-cmdline.nvim"] = {
    custom["VonHeikemen/fine-cmdline.nvim"] = {
        lazy = true,
        event = "BufRead",
        dependencies = {
            { "MunifTanjim/nui.nvim" },
        },
        config = conf.nvim_fine_cmdline,
    }
--]]

--[[   custom["VonHeikemen/searchbox.nvim"] = {
    custom["VonHeikemen/searchbox.nvim"] = {
        lazy = true,
        event = "BufRead",
        dependencies = {
            { "MunifTanjim/nui.nvim" },
        },
        config = conf.nvim_searchbox,
    }
--]]

--[[    custom["toppair/reach.nvim"] = {
    custom["toppair/reach.nvim"] = {
        lazy = true,
        event = "BufRead",
        config = conf.nvim_reach,
    }
--]]

-- 'kkoomen/vim-doge' # (Do)cumentation (Ge)nerator
-- "gbprod/stay-in-place.nvim"
-- 'ThePrimeagen/harpoon' # goto file, term, tmux, mark
-- "s1n7ax/nvim-window-picker"
-- "anuvyklack/windows.nvim"
-- "RRethy/nvim-treesitter-textsubjects"
-- https://github.com/folke/neoconf.nvim
-- https://github.com/akinsho/git-conflict.nvim
-- https://github.com/epwalsh/obsidian.nvim

return custom
