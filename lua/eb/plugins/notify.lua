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
            stages = 'fade_in_slide_out',
            background_colour = 'FloatShadow',
            timeout = 3000,
        }
        vim.notify = require('notify')
    end
}
