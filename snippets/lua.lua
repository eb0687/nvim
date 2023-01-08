-- LUA Snippets

-- Variables [[[

local ls = require("luasnip")
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

-- ]]]

local snippets, autosnippets = {}, {}

-- Start Refactoring -- [[[

local quick_snip = s("qs", fmt([[
local {} = s("{}", {})
table.insert(snippets, {})
]], {
    i(1, ""),
    i(2, ""),
    i(3, ""),
    i(4, ""),
}))
table.insert(snippets, quick_snip)

local fmt_snip = s("fmt_snip", fmt([[
fmt({}, {})
]], {
    i(1, ""),
    i(2, ""),
}))
table.insert(snippets, fmt_snip)

local hello_world_luasnip = s("hello_world_luasnip", {
    t("-- Hello World"),
    i(1, " placeholder_text"),
})
table.insert(snippets, hello_world_luasnip)

local func = s("func", fmt([[
local {} = function({})
    {}
end
]], {
    i(1, ""),
    i(2, ""),
    i(3, "-- do something here"),
}))
table.insert(snippets, func)

local todo = s("todo", fmt([[
-- TODO: {}
]], {
    i(1, "add a todo item here...")
}))
table.insert(snippets, todo)

-- TODO: create more useful snippets using https://youtu.be/ub0REXjhpmk as a guide.

-- End Refactoring -- ]]]

return snippets, autosnippets
