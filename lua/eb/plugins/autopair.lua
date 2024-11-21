--               _                    _
--    __ _ _   _| |_ ___  _ __   __ _(_)_ __
--   / _` | | | | __/ _ \| '_ \ / _` | | '__|
--  | (_| | |_| | || (_) | |_) | (_| | | |
--   \__,_|\__,_|\__\___/| .__/ \__,_|_|_|
--                       |_|
-- https://github.com/windwp/nvim-autopairs

return {
    "windwp/nvim-autopairs",
    enabled = false,
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/nvim-cmp",
    },

    config = function()
        local nvim_autopairs = require("nvim-autopairs")
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")

        nvim_autopairs.setup({
            check_ts = true,
            ts_config = {
                lua = { "string" }, -- dont add pairs in lua string treesitter nodes
                javascript = { "template_string" },
                java = false, -- dont check treesitter on java
            },

            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done()),

            -- source: https://github.com/windwp/nvim-autopairs#fastwrap
            fast_wrap = {
                map = "<M-e>",
                chars = { "{", "[", "(", '"', "'" },
                pattern = [=[[%'%"%>%]%)%}%,]]=],
                end_key = "$",
                before_key = "h",
                after_key = "l",
                cursor_pos_before = true,
                keys = "qwertyuiopzxcvbnmasdfghjkl",
                check_comma = true,
                manual_position = true,
                highlight = "Search",
                highlight_grey = "Comment",
            },
        })

        -- TEST:
        -- print('Hello from lazy autopairs')
    end,
}
