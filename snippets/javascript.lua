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
local get_mirror = helper.get_mirror

-- ]]]

local snippets, autosnippets = {}, {}

-- Start Refactoring (DEFINE SNIPPETS HERE) -- [[[

local javascript_function_es6 = s({
        trig = 'function_es6',
        dscr = 'Snippet to create a primitive javascript variable',
    },
    fmt([[
    {}{} = ({}) => {{
        {}
    }}
    ]], {
        c(1, {
            t('const '),
            t('let '),
            t(''),
        }),
        c(2, {
            t("'function_name'"),
            t(""),
        }),
        c(3, {
            t("'arguments'"),
            t(""),
        }),
        c(4, {
            t("// function stuff goes here..."),
            t("console.log()"),
        }),
    }))
table.insert(snippets, javascript_function_es6)

local javascript_for_loop_es6 = s({
        trig = 'for_es6',
        dscr = 'The recommended way of creating for loops using ES6',
    },
    fmt([[
    for (const {} {} {}) {{
        console.log({})
    }}
    ]], {
        c(1, {
            t('i'),
            t('')
        }),
        c(2, {
            t('of'),
            t('in')
        }),
        c(3, {
            t("'variable'"),
            t('')
        }),
        get_mirror(1)
    }))
table.insert(snippets, javascript_for_loop_es6)

local javascript_variable = s({
        trig = 'variable',
        dscr = 'Snippet to create a primitive javascript variable.',
    },
    fmt([[
    {}{} = {};
    ]], {
        c(1, {
            t('let '),
            t('const '),
            t(''),
        }),
        c(2, {
            t("'variable_name'"),
            t('')
        }),
        c(3, {
            t("'string_literal'"),
            t(""),
            t("true"),
            t("false"),
            t('undefined'),
            t('null'),
        }),
    }))
table.insert(snippets, javascript_variable)

-- local javascript_constant = s({
--         trig = 'constant',
--         dscr = 'Snippet to create a javascript constant',
--     },
--     fmt([[
--     const {} = {};
--     ]], {
--         i(1, 'constant name'),
--         c(2, {
--             t(''),
--             t("'String Literal'"),
--             t('// Number Literal'),
--             t('// Boolean Literal'),
--             t('undefined'),
--             t('null'),
--         }),
--     }))
-- table.insert(snippets, javascript_constant)

local javascript_console = s({
        trig = 'console.log',
        dscr = 'Quickly create a console.log line for printing to console',
    },
    fmt([[
    console.log({});
    ]], {
        c(1, {
            t("'thing to print to console goes here'"),
            t("'Hello World'"),
            t(""),
        }),
    }))
table.insert(snippets, javascript_console)

local javascript_object = s({
        trig = 'object',
        dscr = 'Snippet to create a javascript object',
    },
    fmt([[
    {} {} = {{
        {}: {}
    }}
    ]], {
        c(1, {
            t('let'),
            t('const'),
            t(''),
        }),
        c(2, {
            t("'variable_name'"),
            t(''),
        }),
        c(3, {
                t("'key'"),
                t(""),
            }),
        c(4, {
                t("'value'"),
                t(""),
            }),
    }))
table.insert(snippets, javascript_object)

local javascript_array = s({
        trig = 'array',
        dscr = 'Snippet to create a javascript object',
    },
    fmt([[
    {} {} = [
        '{}',
        '{}',
        '{}',
        '{}',
    ];
    ]], {
        c(1, {
            t('let'),
            t('const'),
            t(''),
        }),
        c(2, {
                t("'array_name'"),
                t('')
            }),
        c(3, {
                t('value_1'),
                t(''),
            }),
        c(4, {
                t('value_2'),
                t(''),
            }),
        c(5, {
                t('value_3'),
                t(''),
            }),
        i(6, ''),
    }))
table.insert(snippets, javascript_array)

-- End Refactoring -- ]]]

return snippets, autosnippets
