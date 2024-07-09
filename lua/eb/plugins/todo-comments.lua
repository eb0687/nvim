--  _            _                                                      _
-- | |_ ___   __| | ___         ___ ___  _ __ ___  _ __ ___   ___ _ __ | |_ ___
-- | __/ _ \ / _` |/ _ \ _____ / __/ _ \| '_ ` _ \| '_ ` _ \ / _ \ '_ \| __/ __|
-- | || (_) | (_| | (_) |_____| (_| (_) | | | | | | | | | | |  __/ | | | |_\__ \
--  \__\___/ \__,_|\___/       \___\___/|_| |_| |_|_| |_| |_|\___|_| |_|\__|___/
-- https://github.com/folke/todo-comments.nvim

return {

    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        -- SETUP
        require("todo-comments").setup({
            signs = true, -- show icons in the signs column
            sign_priority = 8, -- sign priority
            -- keywords recognized as todo comments
            keywords = {
                FIX = {
                    icon = " ", -- icon used for the sign, and in search results
                    color = "error", -- can be a hex color, or a named color (see below)
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                    -- signs = false, -- configure signs for some keywords individually
                },
                TODO = { icon = " ", color = "info" },
                HACK = { icon = " ", color = "warning" },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = "󰎚 ", color = "hint", alt = { "INFO" } },
                TEST = { icon = "󱎫 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
            },
            gui_style = {
                fg = "NONE", -- The gui style to use for the fg highlight group.
                bg = "NONE", -- The gui style to use for the bg highlight group.
            },
            merge_keywords = true, -- when true, custom keywords will be merged with the defaults
            -- highlighting of the line containing the todo comment
            -- * before: highlights before the keyword (typically comment characters)
            -- * keyword: highlights of the keyword
            -- * after: highlights after the keyword (todo text)
            highlight = {
                multiline = true, -- enable multine todo comments
                multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
                multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
                before = "", -- "fg" or "bg" or empty
                keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
                after = "fg", -- "fg" or "bg" or empty
                pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
                comments_only = true, -- uses treesitter to match keywords in comments only
                max_line_len = 400, -- ignore lines longer than this
                exclude = {}, -- list of file types to exclude highlighting
            },
            -- list of named colors where we try to extract the guifg from the
            -- list of highlight groups or use the hex color if hl not found as a fallback
            colors = {
                error = { "DiagnosticError", "ErrorMsg", "#EA6962" },
                warning = { "DiagnosticWarn", "WarningMsg", "#E78A4E" },
                info = { "DiagnosticInfo", "#7DAEA3" },
                hint = { "DiagnosticHint", "#5D5D5D" },
                default = { "Identifier", "#665C54" },
                test = { "Identifier", "#A9B665" },
            },
            search = {
                command = "rg",
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                },
                -- regex that will be used to match keywords.
                -- don't replace the (KEYWORDS) placeholder
                pattern = [[\b(KEYWORDS):]], -- ripgrep regex
                -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
            },
        })

        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_normal = custom_helpers.keymap_normal

        -- NOTE: disabling this for now and replacing it with trouble.nvim
        -- local function todo_current_buffer_dir()
        --     -- NOTE:
        --     -- for more explanation on what the arguments passed to the expand
        --     -- method mean, check the docs :help expand()
        --     Command = "TodoTelescope cwd=" .. vim.fn.expand("%:p:h")
        --     vim.api.nvim_command(Command)
        --     print("TODO in: " .. vim.fn.expand("%:p:h"))
        -- end

        -- jump to next todo
        keymap_normal("]t", function()
            require("todo-comments").jump_next()
        end, "TODO COMMENTS", true, "Next todo comment")

        -- jump to previous todo
        keymap_normal("[t", function()
            require("todo-comments").jump_prev()
        end, "TODO COMMENTS", true, "Previous todo comment")

        -- NOTE: replaced with trouble.nvim
        -- list all todos in the current buffer's directory
        -- keymap_normal("<leader>tt", todo_current_buffer_dir,
        --     "Previous todo comment")

        -- TEST:
        -- print("Hello from lazy todo-comments")
    end,
}
