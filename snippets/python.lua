-- Python Snippets

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

local mysql_con = s("mysql_con", fmt([[
import mysql.connector

# establish a database connection
con = mysql.connector.connect(
    host = "{}",
    user = "{}",
    password = "{}",
    database = "{}",
    port = "{}"
)

# create a client cursor
cur = con.cursor()

# close cursor connection
cur.close()
# close database connection
con.close()
]], {
        i(1, "ipaddress,localhost or hostname"),
        i(2, "username"),
        i(3, "supersecurepasswordhere"),
        i(4, "database name"),
        i(5, "port number (optional)"),
    }))
table.insert(snippets, mysql_con)

-- End Refactoring -- ]]]

return snippets, autosnippets
