local vcmd = vim.cmd

local keymap = function(mode, keys, func, desc)
    if desc then
        desc = "MARKDOWN DIAGNOSTIC: " .. desc
    end
    vim.keymap.set(mode, keys, func, {
        noremap = true,
        silent = false,
        desc = desc,
    })
end

-- check if the current file is inside the Obsidian directory
local function is_in_obsidian_repo()
    local home_dir = vim.fn.expand("$HOME")
    local current_file_path = vim.fn.expand("%:p:h")
    return string.find(current_file_path, home_dir .. "/Documents/the_vault") ~= nil
end

-- standard settings for markdown files
vcmd("setlocal spell spelllang=en_us")
vcmd("setlocal expandtab shiftwidth=4 softtabstop=4 autoindent")

-- this setting makes markdown auto-set the 80 text width limit when typing for the color column
if is_in_obsidian_repo() then
    vim.bo.textwidth = 175 -- No limit for Obsidian repository
    vim.opt_local.colorcolumn = "175"
else
    vim.bo.textwidth = 80 -- Limit to 80 for other repositories
    vim.opt_local.colorcolumn = "80"
end

-- jump to diagnostics
keymap("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
keymap("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic message")
-- past image from clipboard
keymap("n", "<leader>pi", ":PasteImg<CR>", "Paste image from clipboard")
