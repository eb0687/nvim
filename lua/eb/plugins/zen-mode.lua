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
                    laststatus = 0,
                },
            },
            plugins = {
                alacritty = {
                    enabled = true,
                    font = "15",
                },
            },
        })
    end,
}
