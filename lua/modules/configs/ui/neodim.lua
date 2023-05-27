return function()
	local blend_color = require("modules.utils").gen_neodim_blend_attr()

	require("neodim").setup({
		alpha = 0.45,
		blend_color = blend_color,
		update_in_insert = {
			enable = true,
			delay = 100,
		},
		hide = {
			virtual_text = true,
			signs = false,
			underline = false,
		},
	})
end
