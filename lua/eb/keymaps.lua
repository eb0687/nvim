--  _
-- | | _____ _   _ _ __ ___   __ _ _ __  ___
-- | |/ / _ \ | | | '_ ` _ \ / _` | '_ \/ __|
-- |   <  __/ |_| | | | | | | (_| | |_) \__ \
-- |_|\_\___|\__, |_| |_| |_|\__,_| .__/|___/
--           |___/                |_|

-- NOTE:
-- Modes
-- normal_mode = "n",
-- insert_mode = "i",
-- visual_mode = "v",
-- visual_block_mode = "x",
-- term_mode = "t",
-- command_mode = "c",

local custom_helpers = require("eb.utils.custom_helpers")
local keymap_silent = custom_helpers.keymap_silent
local keymap_loud = custom_helpers.keymap_loud
local file_info = custom_helpers.file_info
local open_url = custom_helpers.open_in_browser
local toggle_numbers = custom_helpers.toggle_numbering
local toggle_inlay_hints = custom_helpers.toggle_inlay_hint
-- local toggle_flow = custom_helpers.toggle_flow

-- Leader remap
keymap_silent("", "<Space>", "<Nop>", "Leader")
vim.g.mapleader = " "

-----------------
-- NORMAL MODE --
-----------------

-- Save file
-- keymap("n", "<leader>s", ":w<CR>", 'Save file')
-- keymap_silent("n", "<leader>s", ":update<CR>", "Save file")
keymap_silent("n", "<leader>s", ":write<CR>", "Save file")

-- Source file
keymap_loud("n", "<leader><leader>s", "<cmd>source %<CR>", "Source file")
keymap_loud("n", "<leader><leader>S", ":.lua<CR>", "Execute lua line")
keymap_loud("v", "<leader><leader>s", ":.lua<CR>", "Execute lua selection")

-- Quit Nvim
keymap_silent("n", "<leader>q", ":q!<CR>", "Quit Vim")

-- Yanks
keymap_silent("n", "Y", "yg$", "Yank to end of line")
keymap_silent("n", "<leader>yA", ":%yank<CR>", "Yank/Copy entire buffer")
keymap_silent("n", "<leader>yC", ":%yank+<CR>", "Yank/Copy entire buffer to system clipboard")

-- Yank/paste with system clipboard
keymap_silent({ "n", "x" }, "<leader>yy", '"+y', "Yank/Copy to system clipboard")
keymap_silent("n", "<leader>pp", '"+p', "Paste from system clipboard")

-- Registers
keymap_loud("v", "<leader>ya", function()
    custom_helpers.yank_to_register("a")
end, "Yank selection to register 'a")

keymap_loud("v", "<leader>ys", function()
    custom_helpers.yank_to_register("s")
end, "Yank selection to register 's")

keymap_loud("v", "<leader>yd", function()
    custom_helpers.yank_to_register("d")
end, "Yank selection to register 'd")

keymap_loud("v", "<leader>yf", function()
    custom_helpers.yank_to_register("f")
end, "Yank selection to register 'f")

-- TODO: refactor this
keymap_loud("n", "<leader>pa", function()
    vim.cmd('normal! "ap')
    vim.notify("Pasted from register 'a'", vim.log.levels.INFO, { title = "Paste" })
end, "Paste from register 'a'")

keymap_loud("n", "<leader>pa", function()
    vim.cmd('normal! "sp')
    vim.notify("Pasted from register 's'", vim.log.levels.INFO, { title = "Paste" })
end, "Paste from register 's'")

keymap_loud("n", "<leader>pa", function()
    vim.cmd('normal! "dp')
    vim.notify("Pasted from register 'd'", vim.log.levels.INFO, { title = "Paste" })
end, "Paste from register 'd'")

keymap_loud("n", "<leader>pa", function()
    vim.cmd('normal! "fp')
    vim.notify("Pasted from register 'f'", vim.log.levels.INFO, { title = "Paste" })
end, "Paste from register 'f'")

-- Create splits
keymap_silent("n", "<leader>h", ":split<CR>", "Horizontal split")
keymap_silent("n", "<leader>v", ":vsplit<CR>", "Vertical split")
keymap_loud("n", "<leader>ev", ':vsp <C-R>=expand("%:p:h") . "/" <CR>', "Open file in same dir in vsplit")

-- Resize buffer splits
keymap_silent("n", "<C-A-Left>", ":vertical resize +3<CR>", "Vertical resize (+)")
keymap_silent("n", "<C-A-Right>", ":vertical resize -3<CR>", "Vertical resize (-)")
keymap_silent("n", "<C-A-Up>", ":resize +3<CR>", "Vertical resize (+)")
keymap_silent("n", "<C-A-Down>", ":resize -3<CR>", "Vertical resize (-)")

-- Buffer navigation
keymap_silent("n", "<TAB>", ":bnext<CR>", "Next buffer")
keymap_silent("n", "<S-TAB>", ":bprevious<CR>", "Previous buffer")
keymap_silent("n", "<leader>bd", ":bdelete<CR>", "Delete focused buffer")
keymap_silent("n", "<leader>bD", ":%bd|e#<CR>", "Delete all except for focused buffer")
keymap_silent("n", "<leader>BD", ":%bd<CR>", "Delete all buffers")

-- Tab navigation
keymap_silent("n", "<leader><tab><tab>", "<cmd>tabnew<CR>", "New tab")
keymap_silent("n", "<leader><tab>]", "<cmd>tabnext<CR>", "Next tab")
keymap_silent("n", "<leader><tab>]", "<cmd>tabprevious<CR>", "Previous tab")
keymap_silent("n", "<leader><tab>d", "<cmd>tabclose<CR>", "Close tab")

-- Highlight off
keymap_silent("n", "<leader>ho", ":noh<CR>", "Highlight off")

-- Search & Replace
keymap_silent("n", "n", "nzzzv", "Go to next search")
keymap_silent("n", "N", "Nzzzv", "Go to previous search")
keymap_loud("n", "<C-s>s", ":%s/", "Search and replace")
keymap_loud(
    "n",
    "<C-s>w",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    "Search and replace word under cursor"
)
keymap_loud("v", "<C-s>v", ":s/\\%V", "Search & replace in visual selection")
keymap_loud("n", "<leader>re", "*``cgn", "Replace word under cursor forward")
keymap_loud("n", "<leader>rc", 'viw"+p', "Replace word under cursor with system clipboard")

-- Automatically create the file if it does not exist
keymap_silent("n", "gf", ":edit <cfile><CR>", "Go to file (creates file if missing)")

-- Motions/Movement
keymap_silent("n", "^", "0", "Go to beggining fo the line")
keymap_silent("n", "0", "^", "Go to first non blank character on a line")
keymap_silent("n", "<C-u>", "<C-u>zz", "Navigate upwards while keeping cursor centered")
keymap_silent("n", "<C-d>", "<C-d>zz", "Navigate downwards while keeping cursor centered")
keymap_silent("n", "n", "nzz", "Keep cursor centered while searching")
keymap_silent("n", "N", "Nzz", "Keep cursor centered while searching")
keymap_silent("n", "{", "{zz", "Navigate to previous paragraph")
keymap_silent("n", "}", "}zz", "Navigate to next paragraph")
keymap_silent("n", "gg", "ggzz", "Navigate to top of page")
keymap_silent("n", "G", "Gzz", "Navigate to bottom of page")
keymap_silent("n", "<C-i>", "<C-i>zz", "Navigate jumplist")
keymap_silent("n", "<C-o>", "<C-o>zz", "Navigate jumplist")
keymap_silent("n", "%", "%zz", "jump between matching parenthesis")
keymap_silent("n", "#", "#zz", "jump to previous matching word")

-- Remap for dealing with word wrap
-- NOTE: SOURCE: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Quickfix list
keymap_silent("n", "<leader>j", "<cmd>cnext<CR>zz", "Quickfix next")
keymap_silent("n", "<leader>k", "<cmd>cprev<CR>zz", "Quickfix prev")

-- Various
keymap_silent("n", "<leader>xx", "<cmd>silent !chmod +x %<CR>", "Make executable")
keymap_silent("n", "<leader>w", ":set wrap!<CR>", "Toggle wrap")

-- keymap_silent("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", 'Tmux sessionizer')
keymap_silent("n", "<C-f>", "<cmd>silent !t<CR>", "Tmux sessionizer")
keymap_silent("n", "<leader>tmss", "<cmd>silent !tmux neww tmss<CR>", "Switch Tmux session")
keymap_silent("n", "gx", open_url, "Open in web browser")
keymap_silent("n", "<leader>rw", ":RotateWindows<CR>", "Rotate windows")

-- Lazy
keymap_silent("n", "<leader>zz", "<cmd>Lazy<CR>", "Lazy")

-- Spellchecker
keymap_silent("n", "z0", "1z=", "Fix world under cursor")

-- CD into current file directory
keymap_loud("n", "<leader>cd", function()
    vim.cmd("cd %:h")
    vim.cmd("pwd")
end, "Change directory to current file working directory")

-- Append line
keymap_silent("n", "J", "mzJ`z", "Append bottom line")

-- Paste in Visual with `P` to not copy selected text (`:h v_P`)
keymap_silent("x", "<leader>p", '"+P', "Paste from system clipboard")

-- Custom
keymap_silent("n", "<leader>io", file_info, "open basic file information")
keymap_silent("n", "<leader>ih", toggle_inlay_hints, "toggle inlay hints")
keymap_silent("n", "<leader>n", toggle_numbers, "toggle line numbers")
-- keymap_silent("n", "<leader>zf", toggle_flow, "toggle flow")

-----------------
-- INSERT MODE --
-----------------

-- Escape remap
keymap_silent("i", "jk", "<Esc>", "Escape")
keymap_silent("i", "kj", "<Esc>", "Escape")
keymap_silent("i", "jj", "<Esc>", "Escape")

-----------------
-- VISUAL MODE --
-----------------

-- -- Move highlighted text around using J / K
-- keymap_silent("v", "J", ":m '>+1<CR>gv=gv", "Move highlighted text down")
-- keymap_silent("v", "K", ":m '<-2<CR>gv=gv", "Move hightlighted text up")
--
-- -- Indent line using "<" ">", tip: you can repeat the action with "."
-- keymap_silent("v", ">", ">gv", "Indent line -->")
-- keymap_silent("v", "<", "<gv", "Indent line <--")

-- Mutli-line editing
keymap_silent("v", "<leader>,", "<C-v><S-i>", "Edit multiple lines")

-- Put sane
keymap_silent("v", "p", '"_dP', "Sane put (paste)")

keymap_silent("n", "p", function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.cmd("put")
    vim.api.nvim_win_set_cursor(0, { row + 1, col })
end, "New paste")
-- keymap("v", "<leader>p", "\"_dP", opts)

-- Increment and Decrement numbers
-- Inspired by: https://www.youtube.com/shorts/kkcHypEr5y8
keymap_silent("v", "+", "g<C-a>gv", "Ascending")
keymap_silent("v", "-", "g<C-x>gv", "Descending")
keymap_silent("v", "<leader>-", "<C-x>gv", "Increment")
keymap_silent("v", "<leader>+", "<C-a>gv", "Decrement")
