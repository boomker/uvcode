local default_table = {
	["1"] = "0",
	["k"] = "v",
	["x"] = "y",
	["on"] = "off",
	["On"] = "Off",
	["ON"] = "OFF",
	["up"] = "down",
	["Up"] = "Down",
	["max"] = "min",
	["Max"] = "Min",
	["MAX"] = "MIN",
	["key"] = "value",
	["and"] = "or",
	["AND"] = "OR",
	["yes"] = "no",
	["Yes"] = "No",
	["YES"] = "NO",
	["set"] = "get",
	["Set"] = "Get",
	["let"] = "const",
	["true"] = "false",
	["True"] = "False",
	["TRUE"] = "FALSE",
	["dark"] = "light",
	["Dark"] = "Light",
	["left"] = "right",
	["Left"] = "Right",
	["open"] = "close",
	["Open"] = "Close",
	["inner"] = "outer",
	["Inner"] = "Outer",
	["break"] = "continue",
	["goto"] = { "break", "lua" },
	["local"] = "global",
	["public"] = "private",
	["enable"] = "disable",
	["Enable"] = "Disable",
	["else"] = "elseif",
	["elif"] = { "else", "python" },
	["<"] = ">",
	["("] = ")",
	["["] = "]",
	["{"] = "}",
	["+"] = "-",
	["=="] = "!=",
	["==="] = "!==",
	["<="] = ">=",
	["+="] = "-=",
	["&="] = "|=",
	["&&"] = "||",
	['"'] = "'",
	['""'] = "''",
	['"""'] = "'''",
	["~="] = { "==", "lua" },
	["="] = { ":=", "python" },
}

local AlternateToggler = {}
local user_register = nil
local user_clipboard = nil
local user_register_mode = nil
local cursor_pos = { 0, 0 }

local function errorHandler(err)
    if err then
        vim.notify("Error toggling to alternate value. Err: " .. err, vim.log.levels.ERROR)
    end
end

local function snapshot_and_clean()
    user_clipboard = vim.o.clipboard
    user_register = vim.fn.getreg('"')
    user_register_mode = vim.fn.getregtype('"')
    cursor_pos = vim.api.nvim_win_get_cursor(0)

    vim.o.clipboard = nil
end

local function restore_snapshot()
    vim.fn.setreg('"', user_register, user_register_mode)
    vim.o.clipboard = user_clipboard
    vim.api.nvim_win_set_cursor(0, cursor_pos)
end

local function merged_table(ut)
    local user_pairs = {}
    local filetype = vim.o.filetype
    for k, v in pairs(ut) do
        if type(ut[k]) ~= "table" then
            user_pairs[k] = v
            user_pairs[v] = k
        else
            if #ut[k] < 2 then
                vim.notify("[AlternateToggler] filetype missing.", vim.log.levels.ERROR)
            elseif filetype == ut[k][2] then
                local val = ut[k][1]
                user_pairs[k] = val
                user_pairs[val] = k
            end
        end
    end

    return user_pairs
end

function AlternateToggler.toggle()

    snapshot_and_clean()

    vim.cmd("normal! yiw")
    local yanked_word = vim.fn.getreg('"')
    local user_pair_table = merged_table(default_table)
    local word = user_pair_table[yanked_word]

    if not word then
        vim.notify("Unsupported alternate value.", vim.log.levels.INFO)
        restore_snapshot()
        return
    end

    xpcall(function()
        vim.cmd("normal! ciw" .. word)
    end, errorHandler)

    restore_snapshot()
end

return AlternateToggler
