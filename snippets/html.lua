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

local html_boilerplate = s({
        trig = "html_boilerplate",
        dscr = "Snippet to create an HTML boilerplate",
    },
    fmt([[
    <!DOCTYPE html>
    <html lang="{}">
    <head>
      <meta charset="{}" />
      <title>{}</title>
      <meta name="viewport" content="width={},initial-scale={}" />
      <meta name="description" content="{}" />
      <link rel="icon" href="favicon.png">
    </head>
    <body>
      <h1>{}</h1>
    </body>
    </html>
    ]], {
        i(1, "en"),
        i(2, "UTF-8"),
        i(3, "Hello, World!"),
        i(4, "device-width"),
        i(5, "1"),
        i(6, "1"),
        i(7, "Hello, world!"),
    }))
table.insert(snippets, html_boilerplate)

-- TODO:
-- [ ] create a custom element wrapper
-- <em>text</em>
-- <strong>text</strong>

-- End Refactoring -- ]]]

return snippets, autosnippets
