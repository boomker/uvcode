return function()
	require("modules.utils").load_plugin("codeium", {
		detect_proxy = true,
		enable_chat = false,
		enable_index_service = true,
		enable_local_search = true,
	})
end
