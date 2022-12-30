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
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

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
-- [[[ Barbar
-- SOURCE: https://github.com/romgrk/barbar.nvim

-- Navigate between buffers
keymap("n", "<S-tab>", "<Cmd>BufferPrevious<CR>", { desc = 'Previous buffer' })
keymap("n", "<tab>", "<Cmd>BufferNext<CR>", { desc = 'Next buffer' })

-- Re-order buffers
keymap("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", { desc = 'Move buffer to the left' })
keymap("n", "<A->>", "<Cmd>BufferMoveNext<CR>", { desc = 'Move buffer to the right' })

-- Pin/Unpin buffer
keymap("n", "<A-p>", "<Cmd>BufferPin<CR>", { desc = 'Pin buffer' })

-- Close buffer
keymap("n", "<leader>bd", "<Cmd>BufferClose<CR>", { desc = 'Close current buffer' })
-- ]]]
-- [[[ Telescope

keymap("n", "<leader>fo", require('telescope.builtin').oldfiles, { desc = '[F]ind recently [O]pened files' })
keymap("n", "<leader>fk", ":Telescope keymaps<CR>", { desc = '[F]ind [K]eymaps' })
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = '[F]ind in [H]elp tags' })
keymap("n", "<leader>fp", ":Telescope man_pages<CR>", { desc = '[F]ind in man [P]ages' })
keymap("n", "<leader>fm", ":Telescope marks<CR>", { desc = '[F]ind in vim marks' })

keymap("n", "<leader>ff", require('telescope.builtin').find_files,
    { desc = '[F]ind [F]iles in local folder only recursively' })

keymap("n", "<leader>fg", require('telescope.builtin').git_files,
    { desc = '[F]ind files in [G]it repository' })

keymap("n", "<leader>fs",
    "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep for > ')}) <CR>",
    { desc = '[F]ind using [G]rep' })

keymap("n", "<leader>fn",
    "<cmd>lua require('telescope.builtin').find_files({ prompt_title = '< VIMRC >', cwd = '~/.config/nvim/' }) <CR>",
    { desc = '[F]ind in [N]vim configs' })

keymap("n", "<leader>fF",
    "<cmd>lua require('telescope.builtin').find_files({ prompt_title = '< Search $HOME >', cwd = '~/' }) <CR>",
    { desc = '[F]ind [F]iles in home directory' })

keymap("n", "<leader>fw", "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') }) <CR>"
    , { desc = '[F]ind [W]ord under cursor' })

keymap("n", "<leader>fb", "<cmd>lua require('eb.plugin-settings.telescope').telescope_buffers() <CR>",
    { desc = '[F]ind in existing [B]uffers' })

keymap("n", "<leader>fsh", "<cmd>lua require('eb.plugin-settings.telescope').telescope_search_history() <CR>",
    { desc = '[F]ind [S]earch [H]istory' })

keymap("n", "<leader>fch", "<cmd>lua require('eb.plugin-settings.telescope').telescope_command_history() <CR>",
    { desc = '[fch] [F]ind [C]ommand [H]istory' })

keymap("n", "<leader>fcb", "<cmd>lua require('eb.plugin-settings.telescope').telescope_curr_buff() <CR>",
    { desc = '[F]ind [C]urrent [B]uffer' })

-- ]]]
-- [[[ Harpoon

keymap("n", "<leader>hm", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", { desc = '[H]arpoon [M]enu' })
keymap("n", "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>", { desc = '[H]arpoon [M]ark' })
keymap("n", "<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>", { desc = 'Add to harpoon key [1]' })
keymap("n", "<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>", { desc = 'Add to harpoon key [2]' })
keymap("n", "<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>", { desc = 'Add to harpoon key [3]' })
keymap("n", "<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>", { desc = 'Add to harpoon key [4]' })

-- ]]]
-- [[[ Nvim-tree

keymap("n", "<leader>e", ":NvimTreeFindFileToggle<CR>zz", { desc = 'NvimTree toggle' })

-- ]]]
-- [[[ Vim-commentary

keymap("n", "<C-q>", ":Commentary<CR>", { desc = 'Add a comment in normal mode' })
keymap("v", "<C-q>", ":Commentary<CR>", { desc = 'Add a comment in visual mode' })

-- ]]]
-- [[[ Hop

-- vim-motions
keymap('', 'f',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
    , { desc = 'Hop forward to character' })
keymap('', 'F',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
    , { desc = 'Hop backward to character' })
keymap('', 't',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
    , { desc = 'Hop forward to character but place cursor behind character' })
keymap('', 'T',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>"
    , { desc = 'Hop backward to character but place cursor infront of character' })
-- normal mode
keymap("n", "<leader>hw", ":HopWord<CR>", { desc = '[H]op [W]ord' })
keymap("n", "<leader>hl", ":HopLine<CR>", { desc = '[H]op [L]ine' })
keymap("n", "<leader>hp", ":HopPattern<CR>", { desc = '[H]op [P]attern' })
-- visual mode
keymap("v", "<leader>hw", "<cmd>HopWord<CR>", { desc = '[H]op [W]ord' })
keymap("v", "<leader>hl", "<cmd>HopLine<CR>", { desc = '[H]op [L]ine' })


-- ]]]
-- [[[ True-Zen

keymap("n", "<leader>zn", ":TZNarrow<CR>", opts)
keymap("v", "<leader>zn", ":'<,'>TZNarrow<CR>", opts)
keymap("n", "<leader>zf", ":TZFocus<CR>", opts)
keymap("n", "<leader>zm", ":TZMinimalist<CR>", opts)
keymap("n", "<leader>za", ":TZAtaraxis<CR>", opts)

-- ]]]
-- [[[ Null-ls

-- keymap("n", "<leader>lf", ":lua vim.lsp.buf.format({ async = true })<CR>", opts)
keymap("n", "<leader>lf", ":lua vim.lsp.buf.format { async = true }<CR>", { desc = '[L]SP [F]ormat' })

-- ]]]
-- [[[ Markdown

keymap("n", "<leader>ml", ":MkdnCreateLink<CR>", { desc = 'Create a [M]arkdown [L]ink' })

-- ]]]
-- [[[ Todo-Comments

vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- ]]]
-- [[[ Undotree

keymap("n", "<F5>", ":UndotreeToggle<CR>", { desc = 'Undotree toggle' })

-- ]]]
-- [[[ OSC52

vim.keymap.set('n', '<leader>c', require('osc52').copy_operator, { expr = true })
vim.keymap.set('n', '<leader>cc', '<leader>c_', { remap = true })
vim.keymap.set('x', '<leader>c', require('osc52').copy_visual)

-- ]]]
