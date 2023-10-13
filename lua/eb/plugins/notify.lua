--              _                             _   _  __
--   _ ____   _(_)_ __ ___        _ __   ___ | |_(_)/ _|_   _
--  | '_ \ \ / / | '_ ` _ \ _____| '_ \ / _ \| __| | |_| | | |
--  | | | \ V /| | | | | | |_____| | | | (_) | |_| |  _| |_| |
--  |_| |_|\_/ |_|_| |_| |_|     |_| |_|\___/ \__|_|_|  \__, |
--                                                      |___/
-- https://github.com/rcarriga/nvim-notify

return {
    'rcarriga/nvim-notify',
    config = function()
        require("notify").setup {
            stages = 'slide',
            background_colour = 'FloatShadow',
            timeout = 1000,
            render = 'wrapped-compact',
            fps = 60,
            top_down = true
        }
        vim.notify = require('notify')
    end
}
