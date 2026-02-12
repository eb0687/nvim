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

-- Leader remap
keymap_silent("", "<Space>", "<Nop>", "Leader")
vim.g.mapleader = " "

-----------------
-- NORMAL MODE --
-----------------

-- Save file
keymap_silent("n", "<leader>s", ":write<CR>", "Save file")

-- Source file
keymap_loud("n", "<leader><leader>S", ":.lua<CR>", "Execute lua line")
keymap_loud("n", "<leader><leader>s", function()
    local current_file = vim.fn.expand("%")
    vim.cmd("source " .. current_file)
    vim.notify("Sourced: " .. current_file, vim.log.levels.INFO, { title = "Neovim" })
end, "Source file")
keymap_loud("v", "<leader><leader>s", ":.lua<CR>", "Execute lua selection")

-- Quit Nvim
keymap_silent("n", "<leader>q", ":q!<CR>", "Quit Vim")

-- Yanks
keymap_silent("n", "Y", "yg$", "Yank to end of line")

-- Yank/paste with system clipboard
keymap_silent({ "n", "x" }, "<leader>y", '"+y', "Yank/Copy to system clipboard")
keymap_silent("n", "<leader>p", '"+p', "Paste from system clipboard")

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
-- keymap_silent("n", "<TAB>", ":bnext<CR>", "Next buffer")
-- keymap_silent("n", "<S-TAB>", ":bprevious<CR>", "Previous buffer")
keymap_silent("n", "<leader>bd", ":bdelete<CR>", "Delete focused buffer")
keymap_silent("n", "<leader>bD", ":%bd|e#<CR>", "Delete all except for focused buffer")
keymap_silent("n", "<leader>BD", ":%bd<CR>", "Delete all buffers")

-- Tab navigation
keymap_silent("n", "<leader><tab><tab>", "<cmd>tabnew<CR>", "New tab")
keymap_silent("n", "<leader><tab>]", "<cmd>tabnext<CR>", "Next tab")
keymap_silent("n", "<leader><tab>[", "<cmd>tabprevious<CR>", "Previous tab")
keymap_silent("n", "<leader><tab>d", "<cmd>tabclose<CR>", "Close tab")

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

-- Grep
-- keymap_loud("n", "<leader>gg", ":copen | :silent :grep ", "Custom grep")
keymap_loud("n", "<leader>gg", ":Grep ", "Custom grep")
keymap_loud("n", "<leader>gw", ":GrepCursorWord<CR>", "Grep for word under cursor")

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

-- Various
keymap_silent("n", "<leader>io", ":FileInfo<CR>", "open basic file information")
keymap_silent("n", "<leader>ih", ":ToggleInlayHints<CR>", "toggle inlay hints")
keymap_silent("n", "<leader>n", ":ToggleLineNumbers<CR>", "toggle line numbers")
-- keymap_silent("n", "<leader>xx", "<cmd>silent !chmod +x %<CR>", "Make executable")
keymap_silent("n", "<leader>xx", "<cmd>!chmod +x %<CR>", "Make executable")
keymap_silent("n", "<leader>w", ":set wrap!<CR>", "Toggle wrap")
keymap_silent("n", "gx", ":OpenInBrowser<CR>", "Open in web browser")

-----------------
-- INSERT MODE --
-----------------

-----------------
-- VISUAL MODE --
-----------------

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

-- Cut selection to system clipboard
keymap_silent("v", "<leader>d", '"+d<Esc>', "Cut line to system clipboard")
