-- NOTE: This file is where all helper functions exist and can be called in any snippet file
-- Refer to the below link on how to set this up.
-- https://www.ejmastnak.com/tutorials/vim-latex/luasnip/#advanced-nodes

local M = {}

-- NOTE: Be sure to explicitly define these LuaSnip node abbreviations!
local ls = require("luasnip")
local sn = ls.snippet_node
local i = ls.insert_node
local f = ls.function_node

-- NOTE: Mirrors an insert node in another location.
-- Refer to this video on a explanation of how this function exactly works: https://youtu.be/KtQZRAkgLqo?t=436
function M.get_mirror(index)
    return f(function(arg)
        return arg[1]
    end, { index })
end

-- NOTE: Expand the relative path of this current file
function M.get_filename()
    return { vim.fn.expand "%:p" }
end

-- NOTE: Execute any shell command and print its text.
function M.get_bash(_, _, command)
    local file = io.popen(command, "r")
    local res = {}
    for line in file:lines() do
        table.insert(res, line)
    end
    return res
end

-- NOTE: When `SELECT_RAW` is populated with a visual selection, the function
-- returns an insert node whose initial text is set to the visual selection.
-- When `SELECT_RAW` is empty, the function simply returns an empty insert node.
function M.get_visual(args, parent)
    if (#parent.snippet.env.SELECT_RAW > 0) then
        return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
    else
        return sn(nil, i(1, ''))
    end
end

return M
