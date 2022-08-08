-- :help options

local options = {
    wrap = false,                   -- disables word wrapping
    fileencoding = "utf-8",         -- the encoding written to the file
    number = true,                  -- show numbered lines
    numberwidth = 4,                -- set the width of the numbered lines
    relativenumber = true,          -- set relative numbered lines
    signcolumn = "yes",             -- always show the sign column
    laststatus = 2,                 -- :help laststatus 
    swapfile = false,               -- creates a swapfile
    incsearch = true,               -- :help incsearch
    scrolloff = 8,                  -- :help scrolloff
    sidescrolloff = 8,              -- :help sidescrolloff
    hlsearch = true,                -- :highlight all matches on search pattern
    ignorecase = true,              -- ignore case in search patterns
    smartcase = true,               -- :help smartcase
    list = true,                    -- enables visual indicators of spaces/tabs/trails/eol
    listchars = { trail = "." },    -- enables trail and represents it with a "."
    cmdheight = 1,                  -- number of screen lines to use for the command-line
    pumheight = 10,                 -- pop up menu height
    ttimeoutlen = 50,               -- delay when changing from insert to normal mode
    timeoutlen = 500,               -- time in milliseconds to wait for a mapped sequence to complete.
    foldmethod = "marker",          -- :help foldmethod
    foldmarker = "[[[,]]]",         -- :help foldmarker
    hidden = true,                  -- :help hidden
    showtabline = 2,                -- specifies when the line with tab page labels will be displayed
    mouse = "a",                    -- enables mouse in neovim
    -- mouse = "niv",                  -- :help mouse
    clipboard = "unnamedplus",      -- :help clipboard
    splitbelow = true,              -- sane splits
    splitright = true,              -- sane splits
    showmode = false,               -- show mode indicator NORMAL/INSERT/VISUAL
    lbr = true,                     -- :help lbr
    tw = 500,                       -- :help tw
    autoindent = true,              -- :help autoindent
    smartindent = true,             -- :help smartindent
    smarttab = true,                -- :help smarttab
    expandtab = true,               -- converts tabs to spaces
    shiftwidth = 4,                 -- number of spaces inserted for each indentation
    tabstop = 4,                    -- number of steps for each tab
    termguicolors = true,           -- :help termguicolors
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

--

vim.opt.iskeyword:append "-"        -- uses "-" to connect words when using vim motions

--

local cmd = vim.cmd
cmd([[
    "let g:python3_host_prog = '/usr/bin/python3'",
]])




