--  _
-- | | _____ _   _ _ __ ___   __ _ _ __  ___
-- | |/ / _ \ | | | '_ ` _ \ / _` | '_ \/ __|
-- |   <  __/ |_| | | | | | | (_| | |_) \__ \
-- |_|\_\___|\__, |_| |_| |_|\__,_| .__/|___/
--           |___/                |_|

local keymap = function(mode, keys, func, desc)
    if desc then
        desc = 'KEYBIND: ' .. desc
    end
    vim.keymap.set(mode, keys, func, {
        noremap = true,
        silent = true,
        desc = desc
    })
end

-- leader remap
keymap("", "<Space>", "<Nop>", 'Leader')
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
keymap("n", "<leader>s", ":update<CR>", 'Save file')
-- Quit Nvim
keymap("n", "<leader>q", ":q!<CR>", 'Quit Vim')
-- Source Nvim
keymap("n", "<leader>xo", ":luafile %<CR>", 'Source NVIM')
-- Yank from current position to end of line
keymap("n", "Y", "yg$", 'Yank to end of line')
-- Create splits
keymap("n", "<leader>h", ":split<CR>", 'Horizontal split')
keymap("n", "<leader>v", ":vsplit<CR>", 'Vertical split')
-- Resize buffer splits
keymap("n", "<C-A-Left>", ":vertical resize +3<CR>", 'Vertical resize (+)')
keymap("n", "<C-A-Right>", ":vertical resize -3<CR>", 'Vertical resize (-)')
keymap("n", "<C-A-Up>", ":resize +3<CR>", 'Vertical resize (+)')
keymap("n", "<C-A-Down>", ":resize -3<CR>", 'Vertical resize (-)')
-- Zoom in/out pane
keymap("n", "<leader>-", ":wincmd _<CR>:wincmd |<CR>", 'Zoom out')
keymap("n", "<leader>=", ":wincmd =<CR>", 'Zoom in')
-- Highlight off
keymap("n", "<leader>ho", ":noh<CR>", 'Highlight off')
-- Search & Replace
keymap("n", "<C-s>", ":%s/", 'Search and replace')
keymap("n", "n", "nzzzv", 'Go to next search')
keymap("n", "N", "Nzzzv", 'Go to previous search')
keymap("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], 'Search and replace word under cursor')
-- Automatically create the file if it does not exist
keymap("n", "gf", ":edit <cfile><CR>", 'Go to file (creates file if missing)')
-- Motions
keymap("n", "^", "0", 'Go to beggining fo the line')
keymap("n", "0", "^", 'Go to first non blank character on a line')
keymap("n", "<C-u>", "<C-u>zz", 'Navigate upwards while keeping cursor centered')
keymap("n", "<C-d>", "<C-d>zz", 'Navigate downwards while keeping cursor centered')
keymap("n", "n", "nzz", 'Keep cursor centered while searching') -- navigate downwardsv ertically while keeping cursor centered
-- Quickfix list
keymap("n", "<leader>j", "<cmd>cnext<CR>zz", 'Quickfix next')
keymap("n", "<leader>k", "<cmd>cprev<CR>zz", 'Quickfix prev')
-- Various
keymap("n", "<leader>xx", "<cmd>silent !chmod +x %<CR>", 'Make executable')
keymap("n", "<leader>w", ":set wrap!<CR>", 'Toggle wrap')
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", 'Tmux sessionizer')
keymap("n", "<leader>tmss", "<cmd>silent !tmux neww tmss<CR>", 'Switch Tmux session')
-- CD into current file directory
keymap("n", "<leader>cd", ":cd %:h<CR>", 'Change directory to current file working directory')
-- Append line
keymap("n", "J", "mzJ`z", 'Append bottom line')

-- INSERT MODE [[[
-- ]]]

-- Escape remap
keymap("i", "jk", "<Esc>", 'Escape')
keymap("i", "kj", "<Esc>", 'Escape')
keymap("i", "jj", "<Esc>", 'Escape')

-- VISUAL MODE [[[
-- ]]]

-- Move highlighted text around using J / K
keymap("v", "J", ":m '>+1<CR>gv=gv", 'Move highlighted text down')
keymap("v", "K", ":m '<-2<CR>gv=gv", 'Move hightlighted text up')
-- Indent line using "<" ">", tip: you can repeat the action with "."
keymap("v", ">", ">gv", 'Indent line -->')
keymap("v", "<", "<gv", 'Indent line <--')
-- Mutli-line editing
keymap("v", "<leader>,", "<C-v><S-i>", 'Edit multiple lines')
-- Put sane
keymap("v", "p", '"_dP', 'Sane put (paste)')
-- keymap("v", "<leader>p", "\"_dP", opts)
-- Increment and Decrement numbers
-- Inspired by: https://www.youtube.com/shorts/kkcHypEr5y8
keymap("v", "+", 'g<C-a>gv', 'Ascending')
keymap("v", "-", 'g<C-x>gv', 'Descending')
keymap("v", "<leader>-", '<C-x>gv', 'Increment')
keymap("v", "<leader>+", '<C-a>gv', 'Decrement')
