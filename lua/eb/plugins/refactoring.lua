return {
    "ThePrimeagen/refactoring.nvim",
    enabled = false,
    ft = {
        "javascript",
        "lua",
        "python",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("refactoring").setup()
        -- NOTE: disabling these for now and will use Telescope integration
        -- local keymap = function(mode, keys, func, desc)
        --     if desc then
        --         desc = 'REFACTOR' .. desc
        --     end

        --     vim.keymap.set(mode, keys, func, { desc = desc })
        -- end

        -- keymap('x', '<leader>re', ':Refactor extract ','Refactor extract last highlight/selection')
        -- keymap('x', '<leader>rf', ':Refactor extract_to_file ','Refactor extract to another file')
        -- keymap('x', '<leader>rv', ':Refactor extract_var','Extract occurances of selected expression to its own variable')
        -- keymap({ 'x', 'n' }, '<leader>ri', ':Refactor inline_var','Inverse of extract_var')
        -- keymap('n', '<leader>rI', ':Refactor inline_func','Inverse of extract_func')
        -- keymap('n', '<leader>rb', ':Refactor extract_block','Extract block')
        -- keymap('n', '<leader>rB', ':Refactor extract_block_to_file','Extract block to a file')
    end,
}
