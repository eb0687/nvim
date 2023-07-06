--  _
-- | | _____ _   _ _ __ ___   __ _ _ __  ___
-- | |/ / _ \ | | | '_ ` _ \ / _` | '_ \/ __|
-- |   <  __/ |_| | | | | | | (_| | |_) \__ \
-- |_|\_\___|\__, |_| |_| |_|\__,_| .__/|___/
--           |___/                |_|

local keymap_silent = function(mode, keys, func, desc)
    if desc then
        desc = 'KEYBIND: ' .. desc
    end
    vim.keymap.set(mode, keys, func, {
        noremap = true,
        silent = true,
        desc = desc
    })
end

local keymap_loud = function(mode, keys, func, desc)
    if desc then
        desc = 'KEYBIND: ' .. desc
    end
    vim.keymap.set(mode, keys, func, {
        noremap = true,
        silent = false,
        desc = desc
    })
end

-- leader remap
keymap_silent("", "<Space>", "<Nop>", 'Leader')
vim.g.mapleader = " "

-- NOTE:
-- Modes
-- normal_mode = "n",
-- insert_mode = "i",
-- visual_mode = "v",
-- visual_block_mode = "x",
-- term_mode = "t",
-- command_mode = "c",

-- KEYMAPS

-- NORMAL MODE [[[
-- ]]]

-- Save file
-- keymap("n", "<leader>s", ":w<CR>", 'Save file')
keymap_loud("n", "<leader>s", ":update<CR>", 'Save file')
-- Quit Nvim
keymap_silent("n", "<leader>q", ":q!<CR>", 'Quit Vim')
-- Source Nvim
keymap_loud("n", "<leader>xo", ":luafile %<CR>", 'Source NVIM')
-- Yank from current position to end of line
keymap_silent("n", "Y", "yg$", 'Yank to end of line')
-- Create splits
keymap_silent("n", "<leader>h", ":split<CR>", 'Horizontal split')
keymap_silent("n", "<leader>v", ":vsplit<CR>", 'Vertical split')
-- Resize buffer splits
keymap_silent("n", "<C-A-Left>", ":vertical resize +3<CR>", 'Vertical resize (+)')
keymap_silent("n", "<C-A-Right>", ":vertical resize -3<CR>", 'Vertical resize (-)')
keymap_silent("n", "<C-A-Up>", ":resize +3<CR>", 'Vertical resize (+)')
keymap_silent("n", "<C-A-Down>", ":resize -3<CR>", 'Vertical resize (-)')
-- Zoom in/out pane
keymap_silent("n", "<leader>-", ":wincmd _<CR>:wincmd |<CR>", 'Zoom out')
keymap_silent("n", "<leader>=", ":wincmd =<CR>", 'Zoom in')
-- Highlight off
keymap_silent("n", "<leader>ho", ":noh<CR>", 'Highlight off')
-- Search & Replace
keymap_loud("n", "<C-s>", ":%s/", 'Search and replace')
keymap_silent("n", "n", "nzzzv", 'Go to next search')
keymap_silent("n", "N", "Nzzzv", 'Go to previous search')
keymap_loud("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    'Search and replace word under cursor')
-- Automatically create the file if it does not exist
keymap_silent("n", "gf", ":edit <cfile><CR>", 'Go to file (creates file if missing)')
-- Motions
keymap_silent("n", "^", "0", 'Go to beggining fo the line')
keymap_silent("n", "0", "^", 'Go to first non blank character on a line')
keymap_silent("n", "<C-u>", "<C-u>zz", 'Navigate upwards while keeping cursor centered')
keymap_silent("n", "<C-d>", "<C-d>zz", 'Navigate downwards while keeping cursor centered')
keymap_silent("n", "n", "nzz", 'Keep cursor centered while searching') -- navigate downwardsv ertically while keeping cursor centered
-- Quickfix list
keymap_silent("n", "<leader>j", "<cmd>cnext<CR>zz", 'Quickfix next')
keymap_silent("n", "<leader>k", "<cmd>cprev<CR>zz", 'Quickfix prev')
-- Various
keymap_silent("n", "<leader>xx", "<cmd>silent !chmod +x %<CR>", 'Make executable')
keymap_silent("n", "<leader>w", ":set wrap!<CR>", 'Toggle wrap')
keymap_silent("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", 'Tmux sessionizer')
keymap_silent("n", "<leader>tmss", "<cmd>silent !tmux neww tmss<CR>", 'Switch Tmux session')
keymap_silent("n", "gx", "<cmd>execute '!xdg-open ' .. shellescape(expand('<cfile>'), v:true)<CR>", "Open in web browser")

-- TODO: needs more work
-- NOTE: temporarily disabling the below keymap and using CODE_RUNNER for script execution
-- keymap_silent("n","@P",function ()
--     vim.cmd('term bash %')
-- end,"Execute bash script")
-- keymap_silent("n","@P",":w<CR>:!bash %<CR>","Execute bash script")

-- CD into current file directory
keymap_loud("n", "<leader>cd", function()
    vim.cmd('cd %:h')
    vim.cmd('pwd')
end, 'Change directory to current file working directory')
-- Append line
keymap_silent("n", "J", "mzJ`z", 'Append bottom line')

-- INSERT MODE [[[
-- ]]]

-- Escape remap
keymap_silent("i", "jk", "<Esc>", 'Escape')
keymap_silent("i", "kj", "<Esc>", 'Escape')
keymap_silent("i", "jj", "<Esc>", 'Escape')

-- VISUAL MODE [[[
-- ]]]

-- Move highlighted text around using J / K
keymap_silent("v", "J", ":m '>+1<CR>gv=gv", 'Move highlighted text down')
keymap_silent("v", "K", ":m '<-2<CR>gv=gv", 'Move hightlighted text up')
-- Indent line using "<" ">", tip: you can repeat the action with "."
keymap_silent("v", ">", ">gv", 'Indent line -->')
keymap_silent("v", "<", "<gv", 'Indent line <--')
-- Mutli-line editing
keymap_silent("v", "<leader>,", "<C-v><S-i>", 'Edit multiple lines')
-- Put sane
keymap_silent("v", "p", '"_dP', 'Sane put (paste)')
-- keymap("v", "<leader>p", "\"_dP", opts)
-- Increment and Decrement numbers
-- Inspired by: https://www.youtube.com/shorts/kkcHypEr5y8
keymap_silent("v", "+", 'g<C-a>gv', 'Ascending')
keymap_silent("v", "-", 'g<C-x>gv', 'Descending')
keymap_silent("v", "<leader>-", '<C-x>gv', 'Increment')
keymap_silent("v", "<leader>+", '<C-a>gv', 'Decrement')
