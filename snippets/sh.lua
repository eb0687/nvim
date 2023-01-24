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

-- Start Refactoring (DEFINE SNIPPETS HERE) -- [[[

-- todo snippet with a choice node for various todos...

local info = s("info", fmt([[
# ----------------------------------------------------------------------------
# Contributors:     {}
# Project name:     {}

# Version:          {}

# Description:
# {}

# Dependencies:
# {}

# Date created:     {}
# Last updated:     {}
# ----------------------------------------------------------------------------

{}
]], {
        c(1,{
            t('Eb'),
            t(''),
        }),
        i(2, 'enter project name here..'),
        c(3,{
            t('0.1'),
            t(''),
        }),
        i(4, 'enter a description for the project here..'),
        c(5, {
            i(1, 'are there any dependencies?'),
            t('none'),
            t(''),
        }),
        f(function ()
            return os.date('%d/%m/%Y')
        end),
        f(function ()
            return os.date('%d/%m/%Y')
        end),
        i(0)
    }))
table.insert(snippets, info)

local shebang = s("shebang_sh", {
    t({
        "#!/bin/sh", ""
    }),
    i(0)
})
table.insert(snippets, shebang)

-- End Refactoring -- ]]]

return snippets, autosnippets
