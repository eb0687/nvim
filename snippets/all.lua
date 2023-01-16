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

-- ]]]

local snippets, autosnippets = {}, {}

-- Start Refactoring -- [[[

-- Funcs
-- NOTE: I do not really understand how the below function works yet
-- Use a function to execute any shell command and print its text.
local function bash(_, _, command)
    local file = io.popen(command, "r")
    local res = {}
    for line in file:lines() do
        table.insert(res, line)
    end
    return res
end

local filename = function()
    return { vim.fn.expand "%:p" }
end

-- Snips
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

-- TODO: change this section to a choice node to allow scrolling between different email addresses
local eb_email = s("eb_email", {
    t("ebrahim0687@gmail.com"),
    i(0),
})
table.insert(snippets, eb_email)

local shebang = s("shebang_general", fmt([[
#!/bin/{}
{}
]],{
        i(1, 'insert env here...'),
        i(0)
    }))
table.insert(snippets, shebang)

local dateDMY = s("dateDMY", {
    f(bash, {}, {
        user_args = { "date -u +%d/%m/%Y" }
    })
})
table.insert(snippets, dateDMY)

local pwd = s("pwd", {
    f(bash, {}, {
        user_args = { "pwd" }
    })
})
table.insert(snippets, pwd)

local current_filename = s("filename", {
    f(filename, {})
})
table.insert(snippets, current_filename)

-- todo snippet with a choice node for various todos...
local todo = s("todo", fmt([[
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
