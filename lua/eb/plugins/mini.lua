-- mini-animate.nvim
-- https://github.com/echasnovski/mini.animate

return {
    "echasnovski/mini.nvim",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    version = "*",
    event = "VeryLazy",
    config = function()
        ----------------------------
        -- MINI AI
        -- source: https://github.com/echasnovski/mini.ai?tab=readme-ov-file
        ----------------------------
        local gen_ai_spec = require("mini.extra").gen_ai_spec
        local ai = require("mini.ai")
        ai.setup({
            custom_textobjects = {
                B = gen_ai_spec.buffer(),
                D = gen_ai_spec.diagnostic(),
                I = gen_ai_spec.indent(),
                L = gen_ai_spec.line(),
                N = gen_ai_spec.number(),
            },
        })

        ----------------------------
        -- MINI SURROUND
        -- source: https://github.com/echasnovski/mini.surround
        ----------------------------
        local surround = require("mini.surround")
        surround.setup({
            highlight_duration = 200,
            mappings = {
                add = "gsa", -- Add surrounding in Normal and Visual modes
                delete = "gsd", -- Delete surrounding
                find = "gsf", -- Find surrounding (to the right)
                find_left = "gsF", -- Find surrounding (to the left)
                highlight = "gsh", -- Highlight surrounding
                replace = "gsr", -- Replace surrounding
                update_n_lines = "gsn", -- Update `n_lines`

                suffix_last = "l", -- Suffix to search with "prev" method
                suffix_next = "n", -- Suffix to search with "next" method
            },
        })

        ----------------------------
        -- MINI PAIRS
        -- source: https://github.com/echasnovski/mini.pairs
        ----------------------------
        local pairs = require("mini.pairs")
        pairs.setup()

        ----------------------------
        -- MINI COMMENT
        -- source: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md
        ----------------------------
        local comment = require("mini.comment")
        comment.setup({
            options = {
                custom_commentstring = function()
                    return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
                end,
            },
        })

        -- MINI MOVE
        local move = require("mini.move")
        move.setup({
            -- Module mappings. Use `''` (empty string) to disable one.
            mappings = {
                -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
                left = "<",
                right = ">",
                down = "J",
                up = "K",

                -- Move current line in Normal mode
                line_left = "<M-Left>",
                line_right = "<M-Right>",
                line_down = "<M-Down>",
                line_up = "<M-Up>",
            },

            -- Options which control moving behavior
            options = {
                -- Automatically reindent selection during linewise vertical move
                reindent_linewise = true,
            },
        })

        ----------------------------
        -- MINI INDENTSCOPE
        ----------------------------
        local indent = require("mini.indentscope")
        indent.setup({
            -- symbol = "▎",
            symbol = "│ ",
            draw = {
                animation = indent.gen_animation.none(),
            },
        })

        ----------------------------
        -- MINI CLUE
        ----------------------------
        local clue = require("mini.clue")
        clue.setup({
            triggers = {
                -- Leader triggers
                { mode = "n", keys = "<Leader>" },
                { mode = "x", keys = "<Leader>" },

                -- Built-in completion
                { mode = "i", keys = "<C-x>" },

                -- `g` key
                { mode = "n", keys = "g" },
                { mode = "x", keys = "g" },

                -- Marks
                { mode = "n", keys = "'" },
                { mode = "n", keys = "`" },
                { mode = "x", keys = "'" },
                { mode = "x", keys = "`" },

                -- Registers
                { mode = "n", keys = '"' },
                { mode = "x", keys = '"' },
                { mode = "i", keys = "<C-r>" },
                { mode = "c", keys = "<C-r>" },

                -- Window commands
                { mode = "n", keys = "<C-w>" },

                -- `z` key
                { mode = "n", keys = "z" },
                { mode = "x", keys = "z" },
            },

            clues = {
                -- Enhance this by adding descriptions for <Leader> mapping groups
                -- clue.gen_clues.builtin_completion(),
                -- clue.gen_clues.g(),
                -- clue.gen_clues.marks(),
                -- clue.gen_clues.registers(),
                -- clue.gen_clues.windows(),
                -- clue.gen_clues.z(),
            },
            window = {
                config = { width = 50 },
            },
        })

        ----------------------------
        -- MINI HI-PATTERNS
        -- source: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-hipatterns.md
        -- NOTE: look at the examples for custom setup similar to todo-comments
        ----------------------------
        local hipatterns = require("mini.hipatterns")
        hipatterns.setup({
            highlighters = {
                hex_color = hipatterns.gen_highlighter.hex_color(),
            },
        })

        ----------------------------
        -- MINI SPLIT-JOIN
        -- source: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-splitjoin.md
        ----------------------------
        local splitjoin = require("mini.splitjoin")
        splitjoin.setup({})

        ----------------------------
        -- MINI CURSORWORD
        -- source: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-cursorword.md
        ----------------------------
        local cursorword = require("mini.cursorword")
        -- cursorword.setup({ delay = 50 })
        cursorword.setup()

        -- MINI MISC
        require("mini.misc").setup({})
        require("mini.misc").setup_restore_cursor()

        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_silent = custom_helpers.keymap_silent

        keymap_silent("n", "<leader>=", function()
            MiniMisc.zoom()
        end, "MINI: Zoom in/out buffer")

        ----------------------------
        -- MINI KEYMAP
        -- source: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-keymap.md
        ----------------------------
        local notify_many_keys = function(key)
            local lhs = string.rep(key, 5)
            local action = function()
                vim.notify("Too many " .. key)
            end
            require("mini.keymap").map_combo({ "n", "x" }, lhs, action)
        end
        notify_many_keys("h")
        notify_many_keys("j")
        notify_many_keys("k")
        notify_many_keys("l")

        local map_combo = require("mini.keymap").map_combo
        -- Support most common modes. This can also contain 't', but would
        -- only mean to press `<Esc>` inside terminal.
        local mode = { "i", "c", "x", "s" }
        map_combo(mode, "jk", "<BS><BS><Esc>")
        -- To not have to worry about the order of keys, also map "kj"
        map_combo(mode, "kj", "<BS><BS><Esc>")
        -- Escape into Normal mode from Terminal mode
        map_combo("t", "jk", "<BS><BS><C-\\><C-n>")
        map_combo("t", "kj", "<BS><BS><C-\\><C-n>")

        ----------------------------
        -- MINI PICK
        ----------------------------
        -- require("mini.extra").setup()
        local extra = require("mini.extra")
        local pick = require("mini.pick")
        local hostname = custom_helpers.get_hostname()

        extra.setup()
        pick.setup({
            mappings = {
                choose_marked = "<C-q>",
                mark = "<Tab>",
                move_up = "<C-k>",
                move_down = "<C-j>",
                scroll_up = "<C-u>",
                scroll_down = "<C-d>",
                toggle_preview = "<C-p>",
            },
            options = {
                content_from_bottom = false,
                use_cache = false,
            },
            window = {
                config = {
                    width = 200,
                    height = 20,
                    border = "rounded",
                },
            },
        })

        -- Custom find_files
        local load_temp_rg = function(f)
            local rg_env = "RIPGREP_CONFIG_PATH"
            local cached_rg_config = vim.uv.os_getenv(rg_env) or ""
            vim.uv.os_setenv(rg_env, vim.fn.stdpath("config") .. "/.rg")
            f()
            vim.uv.os_setenv(rg_env, cached_rg_config)
        end

        pick.registry.find_files = function()
            load_temp_rg(function()
                pick.builtin.files({ tool = "rg" })
            end)
        end

        pick.registry.find_home = function()
            load_temp_rg(function()
                pick.builtin.files({ tool = "rg" }, { source = { cwd = "~/" } })
            end)
        end

        -- SOURCE: https://github.com/echasnovski/mini.nvim/discussions/1926
        pick.registry.command_history = function()
            local edit_command = function()
                local match = MiniPick.get_picker_matches()
                if not match then
                    return
                end
                local value = type(match.current) == "table" and match.current.value or tostring(match.current)
                value = value:gsub("^:+", "")
                MiniPick.stop()
                vim.schedule(function()
                    local cmd = ":" .. value
                    local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
                    vim.api.nvim_feedkeys(keys, "n", false)
                end)
                return true
            end
            local opts = {
                mappings = {
                    edit_command = {
                        char = "<C-e>",
                        func = edit_command,
                    },
                },
            }
            MiniExtra.pickers.history({ scope = ":" }, opts)
        end

        if hostname == "JIGA" then
            pick.registry.find_obsidian = function()
                load_temp_rg(function()
                    pick.builtin.files({ tool = "rg" }, { source = { cwd = "/mnt/d/the_vault/" } })
                end)
            end

            pick.registry.grep_osidian = function()
                load_temp_rg(function()
                    pick.builtin.grep({ tool = "rg" }, { source = { cwd = "/mnt/d/the_vault/" } })
                end)
            end
        elseif hostname == "eb-t490" then
            pick.registry.find_obsidian = function()
                load_temp_rg(function()
                    pick.builtin.files({ tool = "rg" }, { source = { cwd = "~/Documents/the_vault<CR>" } })
                end)
            end

            pick.registry.grep_osidian = function()
                load_temp_rg(function()
                    pick.builtin.grep({ tool = "rg" }, { source = { cwd = "~/Documents/the_vault<CR>" } })
                end)
            end
        end

        local keymap = function(keys, func, desc)
            if desc then
                desc = "MINI: " .. desc
            end

            vim.keymap.set("n", keys, func, { desc = desc })
        end

        keymap("<leader>ff", ":Pick find_files<CR>", "Find files")
        keymap("<leader>fh", ":Pick help<CR>", "Find help")
        keymap("<leader>fb", ":Pick buffers<CR>", "Find open buffers")
        keymap("<leader>fk", ":Pick keymaps<CR>", "Find keymaps")
        keymap("<leader>fo", ":Pick oldfiles<CR>", "Find old files")
        keymap("<leader>fm", ":Pick marks<CR>", "Find marks")
        keymap("<leader>fg", ":Pick git_files<CR>", "Find files in current git repository")
        keymap("<leader>fe", ":Pick git_files scope='modified'<CR>", "Find modified git files")
        keymap("<leader>fss", ":Pick grep_live<CR>", "Find search buffer")
        keymap("<leader>fsu", ":Pick commands<CR>", "Find search user commands")
        keymap("<leader>fsw", ":Pick grep pattern='<cword>'<CR>", "Find search word under cursor")
        keymap("<leader>fch", ":Pick command_history<CR>", "Find command history")
        keymap("<leader>fsh", ":Pick history scope='/'<CR>", "Find search history")
        keymap("<leader>fS", ":Pick spellsuggest<CR>", "Spell suggetions")
        keymap(
            "<leader>fsd",
            ":Pick diagnostic scope='current' sort_by='severity'<CR>",
            "Find search diagnostic in current buffer"
        )
        keymap(
            "<leader>fsD",
            ":Pick diagnostic scope='all' sort_by='severity'<CR>",
            "Find search diagnostic in all buffers"
        )
        keymap("<leader>fsb", ":Pick buf_lines<CR>", "Find search buffer")
        keymap("<leader>fsr", ":Pick registers<CR>", "Find search registers")
        keymap("<leader>fF", ":Pick find_home<CR>", "Find file from home directory")
        keymap("<leader>co", ":Pick list scope='quickfix'<CR>", "Find all items in quickfix list")
        keymap("<leader>os", ":Pick find_obsidian<CR>", "Find in obsidian vault")
        keymap("<leader>oz", ":Pick grep_osidian<CR>", "Grep in obsidian vault")
        keymap("<leader>fn", function()
            MiniPick.builtin.files(nil, { source = { cwd = vim.fn.stdpath("config") } })
        end, "Find file in nvim config")

        ----------------------------
        -- MINI SESSIONS
        ----------------------------
        require("mini.sessions").setup({})
        keymap("<leader>ws", function()
            local session_name = vim.fn.input("Session name: ")
            MiniSessions.write(session_name)
        end, "Write a session")
        keymap("<leader>wr", function()
            MiniSessions.read()
        end, "Read and restore a session")

        keymap("<leader>wl", function()
            MiniSessions.select()
        end, "Select from a list of sessions")

        keymap("<leader>wd", function()
            local session_dir = vim.fn.stdpath("data") .. "/session"
            local files = vim.fn.glob(session_dir .. "/*", false, true)

            if vim.tbl_isempty(files) then
                vim.notify("No sessions found in " .. session_dir, vim.log.levels.WARN)
                return
            end

            local sessions = vim.tbl_map(function(path)
                return vim.fn.fnamemodify(path, ":t")
            end, files)

            vim.ui.select(sessions, { prompt = "Delete which session?" }, function(choice)
                if choice then
                    MiniSessions.delete(choice, { force = true })
                    vim.notify("Deleted session: " .. choice)
                end
            end)
        end, "Select from a list of sessions")
    end,
}
