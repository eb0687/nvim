return {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
        vim.api.nvim_set_hl(0, "DiffAddCustom", { fg = "#7daea3", bg = "#404946" })
        vim.api.nvim_set_hl(0, "DiffTextCustom", { fg = "#7daea3", bg = "#542937" })

        local gc = require("git-conflict")
        gc.setup({
            default_mappings = true, -- disable buffer local mapping created by this plugin
            default_commands = true, -- disable commands created by this plugin
            disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
            list_opener = "copen", -- command or function to open the conflicts list
            highlights = { -- They must have background color, otherwise the default color will be used
                incoming = "DiffAddCustom",
                current = "DiffTextCustom",
            },
        })
    end,
}
