--- ### AstroNvim Buffer Utilities
--
-- Buffer management related utility functions
--
-- This module can be loaded with `local buffer_utils = require "astronvim.utils.buffer"`
--
-- @module astronvim.utils.buffer
-- @copyright 2022
-- @license GNU General Public License v3.0

local M = {}

-- local utils = require "astronvim.utils"

--- Placeholders for keeping track of most recent and previous buffer
M.current_buf, M.last_buf = nil, nil

-- TODO: Add user configuration table for this once resession is default
--- Configuration table for controlling session options
M.sessions = {
	autosave = {
		last = true, -- auto save last session
		cwd = true, -- auto save session for each working directory
	},
	ignore = {
		dirs = {}, -- working directories to ignore sessions in
		filetypes = { "gitcommit", "gitrebase" }, -- filetypes to ignore sessions
		buftypes = {}, -- buffer types to ignore sessions
	},
}

--- Check if a buffer is valid
---@param bufnr number The buffer to check
---@return boolean Whether the buffer is valid or not
function M.is_valid(bufnr)
	if not bufnr or bufnr < 1 then
		return false
	end
	return vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted
end

--- Check if a buffer can be restored
---@param bufnr number The buffer to check
---@return boolean Whether the buffer is restorable or not
function M.is_restorable(bufnr)
	if not M.is_valid(bufnr) or vim.api.nvim_get_option_value("bufhidden", { buf = bufnr }) ~= "" then
		return false
	end

	local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufnr })
	if buftype == "" then
		-- Normal buffer, check if it listed.
		if not vim.api.nvim_get_option_value("buflisted", { buf = bufnr }) then
			return false
		end
		-- Check if it has a filename.
		if vim.api.nvim_buf_get_name(bufnr) == "" then
			return false
		end
	end

	if
		vim.tbl_contains(M.sessions.ignore.filetypes, vim.api.nvim_get_option_value("filetype", { buf = bufnr }))
		or vim.tbl_contains(M.sessions.ignore.buftypes, vim.api.nvim_get_option_value("buftype", { buf = bufnr }))
	then
		return false
	end
	return true
end

--- Check if the current buffers form a valid session
---@return boolean Whether the current session of buffers is a valid session
function M.is_valid_session()
	local cwd = vim.fn.getcwd()
	for _, dir in ipairs(M.sessions.ignore.dirs) do
		if vim.fn.expand(dir) == cwd then
			return false
		end
	end
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if M.is_restorable(bufnr) then
			return true
		end
	end
	return false
end

--- Move the current buffer tab n places in the bufferline
---@param n number The number of tabs to move the current buffer over by (positive = right, negative = left)
function M.move(n)
	if n == 0 then
		return
	end -- if n = 0 then no shifts are needed
	local bufs = vim.t.bufs -- make temp variable
	for i, bufnr in ipairs(bufs) do -- loop to find current buffer
		if bufnr == vim.api.nvim_get_current_buf() then -- found index of current buffer
			for _ = 0, (n % #bufs) - 1 do -- calculate number of right shifts
				local new_i = i + 1 -- get next i
				if i == #bufs then -- if at end, cycle to beginning
					new_i = 1 -- next i is actually 1 if at the end
					local val = bufs[i] -- save value
					table.remove(bufs, i) -- remove from end
					table.insert(bufs, new_i, val) -- insert at beginning
				else -- if not at the end,then just do an in place swap
					bufs[i], bufs[new_i] = bufs[new_i], bufs[i]
				end
				i = new_i -- iterate i to next value
			end
			break
		end
	end
	vim.t.bufs = bufs -- set buffers
	--   utils.event "BufsUpdated"
	vim.cmd.redrawtabline() -- redraw tabline
end

--- Navigate left and right by n places in the bufferline
-- @param n number The number of tabs to navigate to (positive = right, negative = left)
function M.nav(n)
	local current = vim.api.nvim_get_current_buf()
	for i, v in ipairs(vim.t.bufs) do
		if current == v then
			vim.cmd.b(vim.t.bufs[(i + n - 1) % #vim.t.bufs + 1])
			break
		end
	end
end

--- Navigate to a specific buffer by its position in the bufferline
---@param tabnr number The position of the buffer to navigate to
function M.nav_to(tabnr)
	vim.cmd.b(vim.t.bufs[tabnr])
end

--- Navigate to the previously used buffer
function M.prev()
	if vim.fn.bufnr() == M.current_buf then
		if M.last_buf then
			vim.cmd.b(M.last_buf)
		else
			--   utils.notify "No previous buffer found"
		end
	else
		-- utils.notify "Must be in a main editor window to switch the window buffer"
	end
end

--- Close a given buffer
---@param bufnr? number The buffer to close or the current buffer if not provided
---@param force? boolean Whether or not to foce close the buffers or confirm changes (default: false)
function M.close(bufnr, force)
	if not force and vim.api.nvim_get_option_value("modified", { buf = bufnr }) then
		local bufname = vim.fn.expand("%")
		local empty = bufname == ""
		if empty then
			bufname = "Untitled"
		end
		local confirm = vim.fn.confirm(('Save changes to "%s"?'):format(bufname), "&Yes\n&No\n&Cancel", 1, "Question")
		if confirm == 1 then
			if empty then
				return
			end
			vim.cmd.write()
		elseif confirm == 2 then
			force = true
		else
			return
		end
	end
	require("mini.bufremove").delete(bufnr, force)
	-- vim.cmd((force and "bd!" or "confirm bd") .. (bufnr == nil and "" or bufnr))
end

--- Close all buffers
---@param keep_current? boolean Whether or not to keep the current buffer (default: false)
---@param force? boolean Whether or not to foce close the buffers or confirm changes (default: false)
function M.close_all(keep_current, force)
	if keep_current == nil then
		keep_current = false
	end
	local current = vim.api.nvim_get_current_buf()
	for _, bufnr in ipairs(vim.t.bufs) do
		if not keep_current or bufnr ~= current then
			M.close(bufnr, force)
		end
	end
end

--- Close buffers to the left of the current buffer
---@param force? boolean Whether or not to foce close the buffers or confirm changes (default: false)
function M.close_left(force)
	local current = vim.api.nvim_get_current_buf()
	for _, bufnr in ipairs(vim.t.bufs) do
		if bufnr == current then
			break
		end
		M.close(bufnr, force)
	end
end

--- Close buffers to the right of the current buffer
---@param force? boolean Whether or not to foce close the buffers or confirm changes (default: false)
function M.close_right(force)
	local current = vim.api.nvim_get_current_buf()
	local after_current = false
	for _, bufnr in ipairs(vim.t.bufs) do
		if after_current then
			M.close(bufnr, force)
		end
		if bufnr == current then
			after_current = true
		end
	end
end

--- Sort a the buffers in the current tab based on some comparator
---@param compare_func string|function a string of a comparator defined in
---@param skip_autocmd boolean|nil whether or not to skip triggering AstroBufsUpdated autocmd event
---@return boolean Whether or not the buffers were sorted
---@diagnostic disable-next-line: unused-local
function M.sort(compare_func, skip_autocmd)
	if type(compare_func) == "string" then
		compare_func = M.comparator[compare_func]
	end
	if type(compare_func) == "function" then
		local bufs = vim.t.bufs
		table.sort(bufs, compare_func)
		vim.t.bufs = bufs
		-- if not skip_autocmd then utils.event "BufsUpdated" end
		vim.cmd.redrawtabline()
		return true
	end
	return false
end

--- Close the current tab
function M.close_tab()
	if #vim.api.nvim_list_tabpages() > 1 then
		vim.t.bufs = nil
		-- utils.event "BufsUpdated"
		vim.cmd.tabclose()
	end
end

return M
