return {
    "folke/zen-mode.nvim",
    config = function()
        require("zen-mode").setup({
            window = {
                width = 90,
                options = {
                    number = true,
                    relativenumber = true,
                    signcolumn = "yes",
                    cursorcolumn = false,
                },
            },
            plugins = {
                alacritty = {
                    enabled = true,
                    font = "15",
                },
                options = {
                    laststatus = 0,
                },
            },
        })
    end,
}
