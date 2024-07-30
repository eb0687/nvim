-- https://github.com/jellydn/my-nvim-ide/blob/main/lua/config/autocmds.lua
local function augroup(name)
    return vim.api.nvim_create_augroup("nvim_ide_" .. name, { clear = true })
end

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "help",
        "lspinfo",
        "notify",
        "qf",
        "startuptime",
        "tsplayground",
        "checkhealth",
        "gitsigns.blame",
        "man",
        "CodeAction",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})
