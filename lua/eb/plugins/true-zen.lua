--  _
-- | |_ _ __ _   _  ___ _______ _ __
-- | __| '__| | | |/ _ \_  / _ \ '_ \
-- | |_| |  | |_| |  __// /  __/ | | |
--  \__|_|   \__,_|\___/___\___|_| |_|
-- https://github.com/Pocco81/true-zen.nvim

return {

    'Pocco81/true-zen.nvim',
    config = function()
        local true_zen = require("true-zen")
        -- SETUP
        true_zen.setup({
            modes = {                        -- configurations per mode
                ataraxis = {
                    shade = "dark",          -- if `dark` then dim the padding windows, otherwise if it's `light` it'll brighten said windows
                    backdrop = 0,            -- percentage by which padding windows should be dimmed/brightened. Must be a number between 0 and 1. Set to 0 to keep the same background color
                    minimum_writing_area = { -- minimum size of main window
                        width = 70,
                        height = 44,
                    },
                    quit_untoggles = true, -- type :q or :qa to quit Ataraxis mode
                    padding = {            -- padding windows
                        left = 52,
                        right = 52,
                        top = 0,
                        bottom = 0,
                    },
                    callbacks = { -- run functions when opening/closing Ataraxis mode
                        open_pre = nil,
                        open_pos = nil,
                        close_pre = nil,
                        close_pos = nil
                    },
                },
                minimalist = {
                    ignored_buf_types = { "nofile" }, -- save current options from any window except ones displaying these kinds of buffers
                    options = {                       -- options to be disabled when entering Minimalist mode
                        number = true,
                        relativenumber = true,
                        showtabline = 0,
                        signcolumn = "no",
                        statusline = "",
                        cmdheight = 1,
                        laststatus = 0,
                        showcmd = false,
                        showmode = false,
                        ruler = false,
                        numberwidth = 1
                    },
                    callbacks = { -- run functions when opening/closing Minimalist mode
                        open_pre = nil,
                        open_pos = nil,
                        close_pre = nil,
                        close_pos = nil
                    },
                },
                narrow = {
                    --- change the style of the fold lines. Set it to:
                    --- `informative`: to get nice pre-baked folds
                    --- `invisible`: hide them
                    --- function() end: pass a custom func with your fold lines. See :h foldtext
                    folds_style = "informative",
                    run_ataraxis = true, -- display narrowed text in a Ataraxis session
                    callbacks = {        -- run functions when opening/closing Narrow mode
                        open_pre = nil,
                        open_pos = nil,
                        close_pre = nil,
                        close_pos = nil
                    },
                },
                focus = {
                    callbacks = { -- run functions when opening/closing Focus mode
                        open_pre = nil,
                        open_pos = nil,
                        close_pre = nil,
                        close_pos = nil
                    },
                },
            },
            integrations = {
                tmux = false, -- hide tmux status bar in (minimalist, ataraxis)
                kitty = {     -- increment font size in Kitty. Note: you must set `allow_remote_control socket-only` and `listen_on unix:/tmp/kitty` in your personal config (ataraxis)
                    enabled = false,
                    font = "+3"
                },
                twilight = false, -- enable twilight (ataraxis)
                lualine = false   -- hide nvim-lualine (ataraxis)
            },
        })

        -- KEYMAPS
        local keymap_n = function(keys, func, desc)
            if desc then
                desc = 'TRUE-ZEN: ' .. desc
            end

            vim.keymap.set('n', keys, func, { desc = desc })
        end

        local keymap_v = function(keys, func, desc)
            if desc then
                desc = 'TRUE-ZEN: ' .. desc
            end

            vim.keymap.set('v', keys, func, { desc = desc })
        end

        -- TODO: refactor the keymaps with functions

        keymap_v("<leader>zn", ":'<,'>TZNarrow<CR>", 'TZ Narrow')
        keymap_n("<leader>zn", ":TZNarrow<CR>", 'TZ Narrow')
        keymap_n("<leader>zf", ":TZFocus<CR>", 'TZ Focus')
        keymap_n("<leader>zm", ":TZMinimalist<CR>", 'TZ Minimalist')
        keymap_n("<leader>za", ":TZAtaraxis<CR>", 'TZ Ataraxis')
        -- keymap_n("<leader>zt", True_Zen_Minimal, 'TZ Minimalist')

        local keymap = function(keys, func, desc)
            if desc then
                desc = 'TEST: ' .. desc
            end

            vim.keymap.set('n', keys, func, { desc = desc })
        end

        -- NOTE: enable / disable tmux when toggling minimalist mode
        local cmd = vim.cmd
        local toggle = true
        function Background_Toggle()
            if toggle then
                cmd('BarbarDisable')
                require('true-zen.minimalist').toggle()
                cmd('silent !tmux set -g status off')
                -- require('barbar').setup {
                --     hide = {
                --         current = true,
                --         inactive = true,
                --     }
                -- }
                toggle = false
            else
                cmd('BarbarEnable')
                require('true-zen.minimalist').toggle()
                cmd('silent !tmux set -g status on')
                -- require('barbar').setup {
                --     hide = {
                --         current = false,
                --         inactive = false,
                --     }
                -- }
                toggle = true
            end
        end

        keymap('<leader>zz', Background_Toggle, 'Toggle Zen mode / Background')

        -- TEST:
        -- print("Hello from lazy true-zen")
    end
}
