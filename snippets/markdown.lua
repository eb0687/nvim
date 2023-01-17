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
local get_visual = helper.get_visual

-- ]]]

local snippets, autosnippets = {}, {}

-- Start Refactoring (DEFINE SNIPPETS HERE) -- [[[

local bold_text = s({
    trig = "bold_custom",
    dscr = "Snippet for custom bold with visual selction functionality",
},
    fmt([[
    **{}** {}
    ]], {
        d(1, get_visual),
        i(0)
    }))
table.insert(snippets, bold_text)

local italic_text = s({
    trig = "italic_custom",
    dscr = "Snippet for custom bold with visual selction functionality",
},
    fmt([[
    _{}_ {}
    ]], {
        d(1, get_visual),
        i(0)
    }))
table.insert(snippets, italic_text)

local strikethrough_text = s({
    trig = "strikethrough_custom",
    dscr = "Snippet for custom bold with visual selction functionality",
},
    fmt([[
    ~~{}~~ {}
    ]], {
        d(1, get_visual),
        i(0)
    }))
table.insert(snippets, strikethrough_text)

local markdown_link = s({
    trig = "link_custom",
    dscr = "Snippet to create a markdown link",
},
    fmt([[
    [{}]({}) {}
    ]], {
        i(1, 'text'),
        d(2, get_visual),
        i(0)
    }))
table.insert(snippets, markdown_link)

local task_custom = s({
    trig = "task_custom",
    dscr = "Snippet to create a checkbox in list form",
},
    fmt([[
    - [ ] {}
    {}
    ]], {
        i(1, "this is placedholder text.."),
        i(0)
    }))
table.insert(snippets, task_custom)

-- End Refactoring -- ]]]

return snippets, autosnippets
