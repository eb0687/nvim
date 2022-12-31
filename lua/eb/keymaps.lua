--  _
-- | | _____ _   _ _ __ ___   __ _ _ __  ___
-- | |/ / _ \ | | | '_ ` _ \ / _` | '_ \/ __|
-- |   <  __/ |_| | | | | | | (_| | |_) \__ \
-- |_|\_\___|\__, |_| |_| |_|\__,_| .__/|___/
--           |___/                |_|

-- local variables
local opts = { noremap = true, silent = true }
local opts2 = { noremap = true }
local keymap = vim.keymap.set

-- leader remap
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- NOTE:
-- Modes
-- normal_mode = "n",
-- insert_mode = "i",
-- visual_mode = "v",
-- visual_block_mode = "x",
-- term_mode = "t",
-- command_mode = "c",

-- [[[ General Keymaps

-- NORMAL MODE --
-- Save file
keymap("n", "<leader>s", ":w<CR>", opts2)
keymap("n", "<leader>s", ":update<CR>", opts2)
-- Quit Nvim
keymap("n", "<leader>q", ":q!<CR>", opts)
-- Source Nvim
keymap("n", "<leader>xo", ":luafile %<CR>", opts2)
-- Yank from current position to end of line
keymap("n", "Y", "yg$", opts)
-- Create splits
keymap("n", "<leader>h", ":split<CR>", opts)
keymap("n", "<leader>v", ":vsplit<CR>", opts)
-- Resize buffer splits
keymap("n", "<C-A-Left>", ":vertical resize +3<CR>", opts)
keymap("n", "<C-A-Right>", ":vertical resize -3<CR>", opts)
keymap("n", "<C-A-Up>", ":resize +3<CR>", opts)
keymap("n", "<C-A-Down>", ":resize -3<CR>", opts)
-- Zoom in/out pane
keymap("n", "<leader>-", ":wincmd _<CR>:wincmd |<CR>", opts)
keymap("n", "<leader>=", ":wincmd =<CR>", opts)
-- Highlight off
keymap("n", "<leader>ho", ":noh<CR>", opts)
-- Search & Replace
keymap("n", "<C-s>", ":%s/", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
-- Automatically create the file if it does not exist
keymap("n", "gf", ":edit <cfile><CR>", opts)
-- Motions
keymap("n", "^", "0", opts) -- o to the beginning of the line
keymap("n", "0", "^", opts) -- go to first non blank character on a line
keymap("n", "<C-u>", "<C-u>zz", opts) -- navigate upwards vertically while keeping cursor centered
keymap("n", "<C-d>", "<C-d>zz", opts) -- navigate downwardsv ertically while keeping cursor centered
keymap("n", "n", "nzz", opts) -- navigate downwardsv ertically while keeping cursor centered
-- Quickfix list
keymap("n", "<leader>j", "<cmd>cnext<CR>zz", opts)
keymap("n", "<leader>k", "<cmd>cprev<CR>zz", opts)
-- Various
keymap("n", "<leader>xx", "<cmd>!chmod +x %<CR>", { silent = true })
keymap("n", "<leader>w", ":set wrap!<CR>", opts)
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", opts)
keymap("n", "<leader>tmss", "<cmd>silent !tmux neww tmss<CR>", opts)
-- CD into current file directory
keymap("n", "<leader>cd", ":cd %:h<CR>", opts)
-- Append line
keymap("n", "J", "mzJ`z", opts)

-- INSERT MODE --
-- Escape remap
keymap("i", "jk", "<Esc>", opts)
keymap("i", "kj", "<Esc>", opts)
keymap("i", "jj", "<Esc>", opts)

-- VISUAL MODE --
-- Move highlighted text around using J / K
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
-- Indent line using "<" ">", tip: you can repeat the action with "."
keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)
-- Mutli-line editing
keymap("v", "<leader>,", "<C-v><S-i>", opts)
-- Put sane
keymap("v", "p", '"_dP', opts)
-- keymap("v", "<leader>p", "\"_dP", opts)
-- Increment and Decrement numbers
-- Inspired by: https://www.youtube.com/shorts/kkcHypEr5y8
keymap("v", "+", 'g<C-a>', opts)
keymap("v", "-", 'g<C-x>', opts)
keymap("v", "<leader>-", '<C-x>', opts)
keymap("v", "<leader>+", '<C-a>', opts)

-- ]]]

-- TODO: migrate the below keybinds to the ../../after/plugin/ folder

-- [[[ Null-ls

-- keymap("n", "<leader>lf", ":lua vim.lsp.buf.format({ async = true })<CR>", opts)
keymap("n", "<leader>lf", ":lua vim.lsp.buf.format { async = true }<CR>", { desc = '[L]SP [F]ormat' })

-- ]]]
-- [[[ OSC52

vim.keymap.set('n', '<leader>c', require('osc52').copy_operator, { expr = true })
vim.keymap.set('n', '<leader>cc', '<leader>c_', { remap = true })
vim.keymap.set('x', '<leader>c', require('osc52').copy_visual)

-- ]]]
