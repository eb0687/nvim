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

local helper = require("eb.luasnip-helper-funcs")
local get_mirror = helper.get_mirror

-- ]]]

local snippets, autosnippets = {}, {}

-- Start Refactoring (DEFINE SNIPPETS HERE) -- [[[

local quick_snip_1 = s("qs-1", fmt([[
local {} = s("{}", {})
table.insert(snippets, {})
]], {
    i(1, ""),
    i(2, ""),
    c(3, {
        t(''),
        t('fmt([[]],{})'),
    }),
    get_mirror(1),
    -- i(4, ""),
}))
table.insert(snippets, quick_snip_1)

local quick_snip = s("qs", fmt([[
local {} = s({{
    trig="{}",
    dscr="{}",
}},
    {})
table.insert(snippets, {})
]], {
    i(1, ""),
    i(2, ""),
    i(3, ""),
    c(4, {
        t(''),
        t('fmt([[]],{})'),
    }),
    get_mirror(1),
}))
table.insert(snippets, quick_snip)

local fmt_snip = s("fmt_snip", fmt([[
fmt({}, {})
]], {
    i(1, ""),
    i(2, ""),
}))
table.insert(snippets, fmt_snip)

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

local shebang = s("shebang_lua", {
    t { "#!/bin/lua", "" },
    i(0)
})
table.insert(snippets, shebang)

local info = s("info", fmt([[
-- ----------------------------------------------------------------------------
-- Author:           {}
-- Project name:     {}

-- Version:          {}

-- Description:
-- {}

-- Dependencies:
-- {}

-- Date created:     {}
-- Last updated:     {}
-- ----------------------------------------------------------------------------

{}
]], {
    c(1, {
        t('Eb'),
        t(''),
    }),
    i(2, 'enter project name here..'),
    c(3, {
        t('0.1'),
        t(''),
    }),
    i(4, 'enter a description for the project here..'),
    c(5, {
        i(1, 'are there any dependencies?'),
        t('none'),
        t(''),
    }),
    f(function()
        return os.date('%d/%m/%Y')
    end),
    f(function()
        return os.date('%d/%m/%Y')
    end),
    i(0)
}))
table.insert(snippets, info)

-- End Refactoring -- ]]]

return snippets, autosnippets
