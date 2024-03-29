return function()
	require("marks").setup({
		default_mappings = false,
		bookmark_1 = {
			sign = "⚑",
		},
		bookmark_2 = {
			sign = "⚑",
		},
		bookmark_3 = {
			sign = "⚑",
		},
		mappings = {
			set_next = "m,",
			next = "m;",
			-- preview = "m;",
			delete_line = "m<space>",
			delete_bookmark = "mx",
			set_bookmark1 = "m0",
			set_bookmark2 = "m2",
			set_bookmark3 = "m3",
			prev = false,
		},
	})
end
