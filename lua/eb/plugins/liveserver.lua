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
    enabled = false,
    cmd = {
        "LiveServer",
        "LiveServerStart",
        "LiveServerStop",
    },
    config = function()
        require("live_server").setup({
            port = 8080,
            browser_command = "", -- Empty string starts up with default browser
            quiet = false,
            no_css_inject = false, -- Disables css injection if true, might be useful when testing out tailwindcss
        })
    end,
    build = function()
        require("live_server.util").install()
    end,
}
