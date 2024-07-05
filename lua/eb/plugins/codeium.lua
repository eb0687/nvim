-- codium.nvim
-- https://github.com/Exafunction/codeium.nvim

return {
    "Exafunction/codeium.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require("codeium").setup({
            enable_chat = true,
        })
    end,
}
