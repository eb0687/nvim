-- ALL Snippets

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
local get_bash = helper.get_bash
local get_filename = helper.get_filename

-- ]]]

local snippets, autosnippets = {}, {}

-- Start Refactoring (DEFINE SNIPPETS HERE) -- [[[

local hello_world = s("hi", {
    t("Hello World "),
    i(1, "placeholder_text"),
})
table.insert(snippets, hello_world)

local eb = s("eb", {
    t("Ebrahim Tarada"),
    i(0),
})
table.insert(snippets, eb)

local email_ = s({
    trig = "email_",
    dscr = "Snippet to cycle through commonly used email addresses",
},
    fmt([[
{}
]]   , {
        c(1, {
            t("ebrahim0687@gmail.com"),
            t("eatar.log@gmail.com"),
            t("mich.dee@gmail.com"),
            t("snake_s_pit@hotmail.com"),
            t("ebrahim0687@outlook.com"),
        })
    }))
table.insert(snippets, email_)

local shebang = s("shebang_general", fmt([[
#!/bin/{}
{}
]], {
    i(1, 'insert env here...'),
    i(0)
}))
table.insert(snippets, shebang)

local dateDMY = s("dateDMY", {
    f(get_bash, {}, {
        user_args = { "date -u +%d/%m/%Y" }
    })
})
table.insert(snippets, dateDMY)

local pwd = s("pwd", {
    f(get_bash, {}, {
        user_args = { "pwd" }
    })
})
table.insert(snippets, pwd)

local current_filename = s("filename", {
    f(get_filename, {})
})
table.insert(snippets, current_filename)

local todo = s({
    trig = "todo",
    dscr = "Snippet to cycle through todo choice nodes",
},
    fmt([[
    {}: {}
    ]], {
        c(1, {
            t("TODO"),
            t("NOTE"),
            t("FIX"),
            t("WARN"),
            t("HACK"),
        }),
        i(2, "add a description here...")
    }))
table.insert(snippets, todo)

-- End Refactoring -- ]]]

return snippets, autosnippets
