--             _                             _
--  _ ____   _(_)_ __ ___         ___  _ __ | |_ ___
-- | '_ \ \ / / | '_ ` _ \ _____ / _ \| '_ \| __/ __|
-- | | | \ V /| | | | | | |_____| (_) | |_) | |_\__ \
-- |_| |_|\_/ |_|_| |_| |_|      \___/| .__/ \__|___/
--                                    |_|

-- :help options

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
    listchars = { trail = "." , tab = ">."}, -- enables trail and represents it with a "."
    cmdheight = 1, -- number of screen lines to use for the command-line
    pumheight = 10, -- pop up menu height
    ttimeoutlen = 50, -- delay when changing from insert to normal mode
    timeoutlen = 500, -- time in milliseconds to wait for a mapped sequence to complete.
    foldmethod = "marker", -- :help foldmethod
    foldmarker = "[[[,]]]", -- :help foldmarker
    hidden = true, -- :help hidden
    showtabline = 0, -- specifies when the line with tab page labels will be displayed
    mouse = "a", -- enables mouse in neovim
    colorcolumn = "80",
    -- mouse = "niv",                  -- :help mouse
    clipboard = "unnamedplus", -- :help clipboard
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
    updatetime = 50
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

--
vim.opt.iskeyword:append "-" -- uses "-" to connect words when using vim motions

-- vim syntax
local cmd = vim.cmd
cmd([[
    "let g:python3_host_prog = '/usr/bin/python3'",

    " center documents when in INSERT mode
    autocmd InsertEnter * norm zz,

    " disables automatic commenting on new line
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o,

    " automatically rebalance windows on vim resize when in a TMUX session.
    autocmd VimResized * :wincmd =

    " highlight on yank
    augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=100}
    augroup END

    " healthcheck
    command! Health checkhealth

    " https://gist.github.com/sideshowcoder/ba5faad45300737c66e9
    function ClearQuickfixList()
      call setqflist([])
    endfunction
    command! ClearQuickfixList call ClearQuickfixList()
]])
-- NOTE: temporarily disabling this keybind and using CODE_RUNNER for script execution
    -- " execute python script
    -- "augroup run_file
    --     "autocmd BufEnter *.py let @p=":silent w\<CR>:vsp | terminal python %\<CR>i"
    -- "augroup end

-- vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]

-- clean healthcheck output
local g = vim.g
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
