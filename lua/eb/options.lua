-- :help options

---@type vim.Option
local options = {
    wrap = false, -- disables word wrapping
    fileencoding = "utf-8", -- the encoding written to the file
    number = true, -- show numbered lines
    numberwidth = 4, -- set the width of the numbered lines
    relativenumber = true, -- set relative numbered lines
    signcolumn = "yes", -- always show the sign column
    laststatus = 3, -- :help laststatus
    swapfile = false, -- creates a swapfile
    scrolloff = 8, -- :help scrolloff
    sidescrolloff = 8, -- :help sidescrolloff
    hlsearch = false, -- :highlight all matches on search pattern
    incsearch = true, -- :help incsearch
    ignorecase = true, -- ignore case in search patterns
    smartcase = true, -- :help smartcase
    list = true, -- enables visual indicators of spaces/tabs/trails/eol
    listchars = { trail = ".", tab = "  " }, -- enables trail and represents it with a "."
    cmdheight = 1, -- number of screen lines to use for the command-line
    pumheight = 10, -- pop up menu height
    ttimeoutlen = 50, -- delay when changing from insert to normal mode
    timeoutlen = 500, -- time in milliseconds to wait for a mapped sequence to complete.
    foldmarker = "[[[,]]]", -- :help foldmarker
    hidden = true, -- :help hidden
    showtabline = 0, -- specifies when the line with tab page labels will be displayed
    mouse = "a", -- enables mouse in neovim
    colorcolumn = "80",
    -- mouse = "niv",                  -- :help mouse
    -- clipboard = "unnamedplus", -- :help clipboard
    splitbelow = true, -- sane splits
    splitright = true, -- sane splits
    showmode = false, -- show mode indicator NORMAL/INSERT/VISUAL
    lbr = true, -- :help lbr
    tw = 500, -- :help tw
    autoindent = true, -- :help autoindent
    smartindent = true, -- :help smartindent
    smarttab = true, -- :help smarttab
    expandtab = true, -- converts tabs to spaces
    shiftwidth = 4, -- number of spaces inserted for each indentation
    tabstop = 4, -- number of steps for each tab
    termguicolors = true, -- :help termguicolors
    updatetime = 50,
    inccommand = "split", -- show a preview of the substitution in a split buffer
    winborder = "single",
    foldmethod = "expr",
    foldexpr = "v:lua.vim.treesitter.foldexpr()",
    foldcolumn = "0",
    foldlevel = 99,
    foldnestmax = 9,
    foldtext = "",
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

--
vim.opt.iskeyword:append("-") -- uses "-" to connect words when using vim motions
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- vim syntax
local cmd = vim.cmd
cmd([[
    "let g:python3_host_prog = '/usr/bin/python3'",

    " disables automatic commenting on new line
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o,

    " healthcheck
    command! Health checkhealth

    autocmd FileType * silent! :TSEnable highlight

    let g:suda#prompt = 'Enter password. (If fingerprint enabled, use reader)'
]])

-- clean healthcheck output
local g = vim.g
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
