-- ALL Snippets

-- Variables [[[

local ls = require("luasnip")
local s = ls.s
local i = ls.i
local t = ls.t

-- local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
-- local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
-- local rep = require("luasnip.extras").rep

local helper = require("eb.utils.luasnip-helper-funcs")
local get_mirror = helper.get_mirror

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

local ansi_colors = s("ansi_colors", fmt([[
# Colors & Formatting
declare -A {}
{}[black]="\e[0;30m"
{}[red]="\e[0;31m"
{}[green]="\e[0;32m"
{}[brown]="\e[0;33m"
{}[blue]="\e[0;34m"
{}[purple]="\e[0;35m"
{}[Cyan]="\e[0;36m"
{}[LightGray]="\e[0;37m"

declare -A {}
{}[black]="\e[0;40m"
{}[red]="\e[0;41m"
{}[green]="\e[0;42m"
{}[brown]="\e[0;43m"
{}[blue]="\e[0;44m"
{}[purple]="\e[0;45m"
{}[Cyan]="\e[0;46m"
{}[LightGray]="\e[0;47m"

{}="\e[0m"

BOLD_TXT="\e[1m"
BOLD_ULINE="\e[4m"
]], {
        i(1, "FG_COLORS"),
        get_mirror(1),
        get_mirror(1),
        get_mirror(1),
        get_mirror(1),
        get_mirror(1),
        get_mirror(1),
        get_mirror(1),
        get_mirror(1),
        i(2, "BG_COLORS"),
        get_mirror(2),
        get_mirror(2),
        get_mirror(2),
        get_mirror(2),
        get_mirror(2),
        get_mirror(2),
        get_mirror(2),
        get_mirror(2),
        i(3, "COLOR_RESET")
    }))
table.insert(snippets, ansi_colors)

-- End Refactoring -- ]]]

return snippets, autosnippets
