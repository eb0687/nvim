-- trouble.nvim
-- https://github.com/folke/trouble.nvim

return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
    config = function()
        local trouble = require("trouble")
        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_normal = custom_helpers.keymap_normal

        local trouble_next = function()
            trouble.next({ jump = true })
        end
        local trouble_prev = function()
            trouble.prev({ jump = true })
        end

        trouble.setup({})

        keymap_normal("<leader>to", ":Trouble todo toggle focus=true<CR>", "TROUBLE", true, "Toggle todo list")
        -- keymap_normal(
        --     "<leader>td",
        --     ":Trouble diagnostics toggle focus=true<CR>",
        --     "TROUBLE",
        --     true,
        --     "Toggle trouble list"
        -- )
        keymap_normal("<leader>tq", ":Trouble quickfix toggle focus=true<CR>", "TROUBLE", true, "Toggle quickfix list")
        keymap_normal("<leader>ts", ":Trouble symbols toggle focus=true<CR>", "TROUBLE", true, "Toggle symbols list")
        keymap_normal("<leader>tl", ":Trouble loclist toggle focus=true<CR>", "TROUBLE", true, "Toggle symbols list")
        keymap_normal(
            "<leader>tt",
            ":Trouble telescope_files toggle focus=true<CR>",
            "TROUBLE",
            true,
            "Toggle symbols list"
        )
        keymap_normal("]t", trouble_next, "TROUBLE", true, "Next trouble")
        keymap_normal("[t", trouble_prev, "TROUBLE", true, "Previous trouble")
    end,
}
