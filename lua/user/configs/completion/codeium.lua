return function()
	require("modules.utils").load_plugin("codeium", {
		detect_proxy = true,
		enable_chat = true,
		enable_index_service = true,
		enable_local_search = false,
	})
end
