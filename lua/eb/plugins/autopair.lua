--               _                    _
--    __ _ _   _| |_ ___  _ __   __ _(_)_ __
--   / _` | | | | __/ _ \| '_ \ / _` | | '__|
--  | (_| | |_| | || (_) | |_) | (_| | | |
--   \__,_|\__,_|\__\___/| .__/ \__,_|_|_|
--                       |_|
-- https://github.com/windwp/nvim-autopairs

return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',

    config = function()
        local nvim_autopairs = require("nvim-autopairs")
        nvim_autopairs.setup({
            -- source: https://github.com/windwp/nvim-autopairs#fastwrap
            fast_wrap = {
                map = '<M-e>',
                chars = { '{', '[', '(', '"', "'" },
                pattern = [=[[%'%"%>%]%)%}%,]]=],
                end_key = '$',
                keys = 'qwertyuiopzxcvbnmasdfghjkl',
                check_comma = true,
                manual_position = true,
                highlight = 'Search',
                highlight_grey = 'Comment'
            }
        })

        -- TEST:
        print('Hello from lazy autopairs')
    end
}
