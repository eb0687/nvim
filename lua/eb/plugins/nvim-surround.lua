--                                                                        _
--  _ ____   _(_)_ __ ___        ___ _   _ _ __ _ __ ___  _   _ _ __   __| |
-- | '_ \ \ / / | '_ ` _ \ _____/ __| | | | '__| '__/ _ \| | | | '_ \ / _` |
-- | | | \ V /| | | | | | |_____\__ \ |_| | |  | | | (_) | |_| | | | | (_| |
-- |_| |_|\_/ |_|_| |_| |_|     |___/\__,_|_|  |_|  \___/ \__,_|_| |_|\__,_|
-- https://github.com/kylechui/nvim-surround

-- NOTE: replaced with mini

return {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = { "BufReadPre", "BufNewFile" },
    enabled = false,
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })

        -- TEST:
        -- print("Hello from lazy nvim-surround")
    end,
}
