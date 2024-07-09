-- trouble.nvim
-- https://github.com/folke/trouble.nvim

return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
    config = function()
        local trouble = require("trouble")
        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_normal = custom_helpers.keymap_normal

        trouble.setup({})

        -- local keymap_normal = function(keys, func, desc)
        --     if desc then
        --         desc = 'TROUBLE: ' .. desc
        --     end

        --     vim.keymap_normal.set('n', keys, func, { desc = desc })
        -- end

        keymap_normal("<leader>to", ":Trouble todo toggle focus=true<CR>", "TROUBLE", true, "Toggle todo list")
        keymap_normal(
            "<leader>td",
            ":Trouble diagnostics toggle focus=true<CR>",
            "TROUBLE",
            true,
            "Toggle trouble list"
        )
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
    end,
}
