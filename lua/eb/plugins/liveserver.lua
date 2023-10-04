--  _     _           ____
-- | |   (_)_   _____/ ___|  ___ _ ____   _____ _ __
-- | |   | \ \ / / _ \___ \ / _ \ '__\ \ / / _ \ '__|
-- | |___| |\ V /  __/___) |  __/ |   \ V /  __/ |
-- |_____|_| \_/ \___|____/ \___|_|    \_/ \___|_|
-- https://github.com/aurum77/live-server.nvim

-- DESCRIPTION:
-- Visual Studio Code live server implementation in nvim

return {
    "aurum77/live-server.nvim",
    event = "VeryLazy",
    config = function()
        require('live_server').setup {}
    end,
    cmd = {
        "LiveServer",
        "LiveServerStart",
        "LiveServerStop"
    },
    build = function()
        require('live_server.util').install()
    end
}
