-- trouble.nvim
-- https://github.com/folke/trouble.nvim

return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
    config = function ()
        local trouble = require('trouble')
        trouble.setup{}

        local keymap = function(keys, func, desc)
            if desc then
                desc = 'TROUBLE: ' .. desc
            end

            vim.keymap.set('n', keys, func, { desc = desc })
        end

        keymap("<leader>to",":Trouble todo toggle focus=true filter.buf=0<CR>","Toggle todo list")
        keymap("<leader>tO",":Trouble todo toggle focus=true<CR>","Toggle todo list")
        keymap("<leader>tt",":Trouble diagnostics toggle focus=true<CR>","Open/Close trouble list")
        keymap("<leader>tB",":Trouble diagnostics toggle focus=true<CR>","Diagnostics in current buffer")
        keymap("<leader>tb",":Trouble diagnostics toggle focus=true filter.buf=0<CR>","Diagnostics in current buffer")
        keymap("<leader>te",":Trouble diagnostics toggle focus=true filter.severity = vim.diagnostic.severity.ERROR<CR>","Show ERROR in current buffer")
        keymap("<leader>tq",":Trouble quickfix toggle focus=true<CR>","Toggle quickfix list")
        keymap("<leader>ts",":Trouble symbols toggle focus=true<CR>","Toggle symbols list")
    end
}
