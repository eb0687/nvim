return {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
        vim.api.nvim_set_hl(0, "CurrentCustom", { fg = "#7daea3", bg = "#404946" })
        vim.api.nvim_set_hl(0, "IncomingCustom", { fg = "#7daea3", bg = "#542937" })

        local gc = require("git-conflict")
        gc.setup({
            default_mappings = true,
            default_commands = true,
            disable_diagnostics = true,
            list_opener = "copen",
            highlights = {
                incoming = "IncomingCustom",
                current = "CurrentCustom",
            },
        })
    end,
}
