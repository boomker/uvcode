return vim.tbl_extend(
	"force",
	require("user.keymap.core"),
	require("user.keymap.completion"),
	require("user.keymap.editor"),
	require("user.keymap.lang"),
	require("user.keymap.tool"),
	require("user.keymap.ui")
)
