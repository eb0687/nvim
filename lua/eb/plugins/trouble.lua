-- trouble.nvim
-- https://github.com/folke/trouble.nvim

return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
    config = function()
        local trouble = require('trouble')
        trouble.setup {}

        local keymap = function(keys, func, desc)
            if desc then
                desc = 'TROUBLE: ' .. desc
            end

            vim.keymap.set('n', keys, func, { desc = desc })
        end

        keymap("<leader>to", ":Trouble todo toggle focus=true<CR>", "Toggle todo list")
        keymap("<leader>td", ":Trouble diagnostics toggle focus=true<CR>", "Toggle trouble list")
        keymap("<leader>tq", ":Trouble quickfix toggle focus=true<CR>", "Toggle quickfix list")
        keymap("<leader>ts", ":Trouble symbols toggle focus=true<CR>", "Toggle symbols list")
        keymap("<leader>tl", ":Trouble loclist toggle focus=true<CR>", "Toggle symbols list")
        keymap("<leader>tt", ":Trouble telescope_files toggle focus=true<CR>", "Toggle symbols list")
    end
}
