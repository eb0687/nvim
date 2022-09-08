--  _
-- | | _____ _   _ _ __ ___   __ _ _ __  ___
-- | |/ / _ \ | | | '_ ` _ \ / _` | '_ \/ __|
-- |   <  __/ |_| | | | | | | (_| | |_) \__ \
-- |_|\_\___|\__, |_| |_| |_|\__,_| .__/|___/
--           |___/                |_|

-- local variables
local opts = { noremap = true, silent = true }
local opts2 = { noremap = true }
local keymap = vim.api.nvim_set_keymap

-- leader remap
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- [[[ Help

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- ]]]
-- [[[ General Keymaps

-- NORMAL MODE --
-- Save file
keymap("n", "<leader>s", ":w<CR>", opts2)
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
keymap ("n", "<C-A-Up>", ":resize +3<CR>", opts)
keymap ("n", "<C-A-Down>", ":resize -3<CR>", opts)
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
-- Quickfix list
keymap("n", "<leader>j", "<cmd>cnext<CR>zz", opts)
keymap("n", "<leader>k", "<cmd>cprev<CR>zz", opts)
-- Various
keymap("n", "<leader>xx", "<cmd>!chmod +x %<CR>", { silent = true })
keymap("n", "<leader>w", ":set wrap!<CR>", opts)

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

-- ]]]
-- [[[ Barbar
-- SOURCE: https://github.com/romgrk/barbar.nvim

-- Navigate between buffers
keymap("n", "<S-tab>", "<Cmd>BufferPrevious<CR>", opts)
keymap("n", "<tab>", "<Cmd>BufferNext<CR>", opts)

-- Re-order buffers
keymap("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
keymap("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)

-- Pin/Unpin buffer
keymap("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)

-- Close buffer
keymap("n", "<leader>bd", "<Cmd>BufferClose<CR>", opts)
-- ]]]
-- [[[ Telescope

keymap("n", "<leader>fk", ":Telescope keymaps<CR>", opts)
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
keymap("n", "<leader>fp", ":Telescope man_pages<CR>", opts)
keymap("n", "<leader>fs", "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep for > ')}) <CR>", opts)
keymap("n", "<leader>fd", "<cmd>lua require('telescope.builtin').find_files({ prompt_title = '< VIMRC >', cwd = '~/.config/nvim/' }) <CR>", opts)
keymap("n", "<leader>fw", "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') }) <CR>", opts)
keymap("n", "<leader>fm", ":Telescope marks<CR>", opts)
keymap("n", "<leader>fb", "<cmd>lua require('eb.plugin-settings.telescope').telescope_buffers() <CR>", opts)
keymap("n", "<leader>fsh", "<cmd>lua require('eb.plugin-settings.telescope').telescope_search_history() <CR>", opts)
keymap("n", "<leader>fch", "<cmd>lua require('eb.plugin-settings.telescope').telescope_command_history() <CR>", opts)
keymap("n", "<C-_>", "<cmd>lua require('eb.plugin-settings.telescope').telescope_curr_buff() <CR>", opts)

-- ]]]
-- [[[ Harpoon

keymap("n", "<leader>hm", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
keymap("n", "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>", opts)
keymap("n", "<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>", opts)
keymap("n", "<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>", opts)
keymap("n", "<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>", opts)

-- ]]]
-- [[[ Nvim-tree

keymap("n", "<leader>e", ":NvimTreeFindFileToggle<CR>", opts)

-- ]]]
-- [[[ Vim-commentary

keymap("n", "<C-q>", ":Commentary<CR>", opts)
keymap("v", "<C-q>", ":Commentary<CR>", opts)

-- ]]]
-- [[[ Hop

-- vim-motions
keymap('', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
keymap('', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>", {})
keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>", {})
-- normal mode
keymap("n", "<leader>hw", ":HopWord<CR>", opts)
keymap("n", "<leader>hl", ":HopLine<CR>", opts)
keymap("n", "<leader>hp", ":HopPattern<CR>", opts)
-- visual mode
keymap("v", "<leader>hw", "<cmd>HopWord<CR>", opts)
keymap("v", "<leader>hl", "<cmd>HopLine<CR>", opts)


-- ]]]
-- [[[ True-Zen

keymap("n", "<leader>zn", ":TZNarrow<CR>", opts)
keymap("v", "<leader>zn", ":'<,'>TZNarrow<CR>", opts)
keymap("n", "<leader>zf", ":TZFocus<CR>", opts)
keymap("n", "<leader>zm", ":TZMinimalist<CR>", opts)
keymap("n", "<leader>za", ":TZAtaraxis<CR>", opts)

-- ]]]
-- [[[ FZF-Lua

-- keymap("n", "<leader>ff", ":FzfLua files cwd=~/<CR>", opts)
-- keymap("n", "<leader>fcu", ":FzfLua files<CR>", opts2)

-- ]]]
-- [[[ Tmux Navigator (WIP)

-- vim.g.tmux_navigator_no_mappings = 1

-- keymap("n", "<C-h>", ":TmuxNavigateLeft", opts)
-- keymap("n", "<C-l>", ":TmuxNavigateRight", opts)
-- keymap("n", "<C-k>", ":TmuxNavigateUp", opts)
-- keymap("n", "<C-j>", ":TmuxNavigateDown", opts)

-- ]]]
-- [[[ Null-ls 

-- keymap("n", "<leader>lf", ":lua vim.lsp.buf.format({ async = true })<CR>", opts)
keymap("n", "<leader>lf", ":lua vim.lsp.buf.formatting()<CR>", opts)

-- ]]]
