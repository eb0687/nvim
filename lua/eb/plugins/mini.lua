-- https://github.com/echasnovski/mini.nvim

-- TODO: check this for configuration imporvements
-- NOTE: https://github.com/nvim-mini/MiniMax/blob/main/configs/nvim-0.11/plugin/30_mini.lua

return {
    "nvim-mini/mini.nvim",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    version = "*",
    event = "VeryLazy",
    config = function()
        require("eb.plugins.mini.ai").setup()
        require("eb.plugins.mini.surround").setup()
        require("eb.plugins.mini.pairs").setup()
        require("eb.plugins.mini.comment").setup()
        require("eb.plugins.mini.move").setup()
        require("eb.plugins.mini.indentscope").setup()
        require("eb.plugins.mini.clue").setup()
        require("eb.plugins.mini.hipatterns").setup()
        require("eb.plugins.mini.splitjoin").setup()
        require("eb.plugins.mini.cursorword").setup()
        require("eb.plugins.mini.statusline").setup()
        require("eb.plugins.mini.misc").setup()
        require("eb.plugins.mini.keymap").setup()
        require("eb.plugins.mini.trailspace").setup()
        require("eb.plugins.mini.visits").setup()
        require("eb.plugins.mini.pick").setup()
        require("eb.plugins.mini.sessions").setup()
    end,
}
