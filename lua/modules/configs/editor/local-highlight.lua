return function()
	require("modules.utils").load_plugin("local-highlight", {
		hlgroup = "LocalHighlight",
		insert_mode = false,
		animate = {
			enabled = false,
			char_by_char = true,
			easing = "linear",
			duration = {
				step = 10, -- ms per step
				total = 100, -- maximum duration
			},
		},
	})
end
