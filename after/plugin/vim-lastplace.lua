-- VIM-LASTPLACE

-- there is a lua version of this here: https://github.com/ethanholz/nvim-lastplace
-- TODO: check out the lua version

-- SETUP [[[

local global_var = vim.g

global_var.lastplace_open_folds = 0
global_var.lastplace_ignore_buftype = 'quickfix, nofile, help'
global_var.lastplace_ignore = 'gitcommit, gitrebase, svn, hgcommit'

-- ]]]

-- TEST:
-- print('Hello from AFTER/HOP')
