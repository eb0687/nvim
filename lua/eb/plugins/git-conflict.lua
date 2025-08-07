return {
    "akinsho/git-conflict.nvim",
    version = "*",

    ---@module "git-conflict"
    opts = {
        default_mappings = false,
        default_commands = true,
        disable_diagnostics = true,
        list_opener = "copen",
        highlights = {
            incoming = "IncomingCustom",
            current = "CurrentCustom",
        },
        debug = false,
    },

    config = function(_, opts)
        -- custom highlights
        vim.api.nvim_set_hl(0, "CurrentCustom", { fg = "#7daea3", bg = "#404946" })
        vim.api.nvim_set_hl(0, "IncomingCustom", { fg = "#7daea3", bg = "#542937" })

        local gc = require("git-conflict")
        gc.setup(opts)

        local function choose_ours()
            vim.cmd("GitConflictChooseOurs")
            vim.cmd("GitConflictNextConflict")
        end
        local function choose_theirs()
            vim.cmd("GitConflictChooseTheirs")
            vim.cmd("GitConflictNextConflict")
        end

        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_normal = custom_helpers.keymap_normal

        keymap_normal("co", choose_ours, "GitConflict", true, "choose ours, move to next conflict and refresh qflist")
        keymap_normal(
            "ct",
            choose_theirs,
            "GitConflict",
            true,
            "choose theirs, move to next conflict and refresh qflist"
        )
        keymap_normal("c0", "<Plug>(git-conflict-none)", "GitConflict", true, "choose none")
        keymap_normal("cb", "<Plug>(git-conflict-both)", "GitConflict", true, "choose both")
        keymap_normal("[x", "<Plug>(git-conflict-prev-conflict)", "GitConflict", true, "goto prev conflict")
        keymap_normal("]x", "<Plug>(git-conflict-next-conflict)", "GitConflict", true, "goto next conflict")
    end,
}
