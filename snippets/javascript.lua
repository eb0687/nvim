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

local javascript_function_es6 = s({
        trig = 'function_es6',
        dscr = 'Snippet to create a primitive javascript variable',
    },
    fmt([[
    {}{} = ({}) => {}
    ]], {
        c(1, {
            t('const '),
            t('let '),
            t('')
        }),
        i(2, "'function name'"),
        i(3, "'arguments'"),
        i(4, "'returned value'")
    }))
table.insert(snippets, javascript_function_es6)

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
        i(2, "'variable name'"),
        c(3, {
            t("'String Literal'"),
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
        i(1, '<thing to print to console goes here>'),
    }))
table.insert(snippets, javascript_console)

local javascript_object = s({
        trig = 'object',
        dscr = 'Snippet to create a javascript object',
    },
    fmt([[
    {} {} = {}
    ]], {
        c(1, {
            t('let'),
            t('const'),
            t(''),
        }),
        i(2, 'variable name'),
        i(3, '{}'),
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
        {}
    ];
    ]], {
        c(1, {
            t('let'),
            t('const'),
            t(''),
        }),
        i(2, 'array name'),
        i(3, 'value 1'),
        i(4, 'value 2'),
        i(5, 'value 3'),
        i(6, "''"),
    }))
table.insert(snippets, javascript_array)

-- End Refactoring -- ]]]

return snippets, autosnippets
