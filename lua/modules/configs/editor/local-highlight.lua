return function()
	require("modules.utils").load_plugin("local-highlight", {
		hlgroup = "LocalHighlight",
		insert_mode = false,
		animate = {
			enabled = false,
		},
	})
end
