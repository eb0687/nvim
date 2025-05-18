-- debug print
-- https://github.com/andrewferrier/debugprint.nvim

return {
    "andrewferrier/debugprint.nvim",
    -- opts = { … },
    dependencies = {
        "echasnovski/mini.nvim", -- Optional: Needed for line highlighting
        "nvim-telescope/telescope.nvim", -- Optional: If you want to use the :SearchDebugPrints command with telescope.nvim
    },
    lazy = false, -- Required to make line highlighting work before debugprint is first used
    version = "*", -- Remove if you DON'T want to use the stable version
    config = function()
        require("debugprint").setup({})
    end,
}
