--                 _
--    ___ ___   __| | ___   _ __ _   _ _ __  _ __   ___ _ __
--   / __/ _ \ / _` |/ _ \ | '__| | | | '_ \| '_ \ / _ \ '__|
--  | (_| (_) | (_| |  __/ | |  | |_| | | | | | | |  __/ |
--   \___\___/ \__,_|\___| |_|   \__,_|_| |_|_| |_|\___|_|
-- https://github.com/CRAG666/code_runner.nvim

-- TODO:
-- go through the documentation for harpoon integration
-- figure out if I should lazy load this?

-- NOTE: have not been using this as much, maybe disable this soon?

return {
    "CRAG666/code_runner.nvim",
    enabled = true,
    keys = {
        { "<leader>rr", ":RunCode<CR>", "Execute code" },
    },

    config = function()
        local code_runner = require("code_runner")
        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_normal = custom_helpers.keymap_normal

        -- SETUP
        code_runner.setup({
            -- https://github.com/CRAG666/code_runner.nvim#setup-global

            -- choose default mode (valid term, tab, float, toggle, buf)
            mode = "term",
            -- Focus on runner window(only works on toggle, term and tab mode)
            focus = true,
            -- startinsert (see ':h inserting-ex')
            startinsert = false,
            filetype = {
                python = "python3 -u",
                go = "go run .",
            },
        })

        keymap_normal("<leader>rr", ":RunCode<CR>", "CODE_RUNNER", true, "Execute code")

        -- TEST:
        -- print("Hello from lazy code_runner")
    end,
}
