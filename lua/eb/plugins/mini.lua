-- https://github.com/echasnovski/mini.nvim

-- TODO: check this for configuration imporvements
-- NOTE: https://github.com/nvim-mini/MiniMax/blob/main/configs/nvim-0.11/plugin/30_mini.lua

return {
    "nvim-mini/mini.nvim",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    version = "*",
    event = "VeryLazy",
    config = function()
        local extra = require("mini.extra")
        ----------------------------
        -- MINI AI
        -- SOURCE: https://github.com/echasnovski/mini.ai?tab=readme-ov-file
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
        -- SOURCE: https://github.com/echasnovski/mini.surround
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
        -- SOURCE: https://github.com/echasnovski/mini.pairs
        ----------------------------
        local pairs = require("mini.pairs")
        pairs.setup()

        ----------------------------
        -- MINI COMMENT
        -- SOURCE: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md
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
        -- SOURCE: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-hipatterns.md
        -- NOTE: look at the examples for custom setup similar to todo-comments
        ----------------------------
        local hipatterns = require("mini.hipatterns")
        -- local hi_words = extra.gen_highlighter.words
        hipatterns.setup({
            highlighters = {
                todo = { pattern = "%f[%w]()TODO:.*", group = "MiniHipatternsTodo" },
                fixme = { pattern = "%f[%w]()FIXME:.*", group = "MiniHipatternsFixme" },
                test = { pattern = "%f[%w]()TEST:.*", group = "MiniHipatternsHack" },
                note = { pattern = "%f[%w]()NOTE:.*", group = "MiniHipatternsNote" },
                info = { pattern = "%f[%w]()INFO:.*", group = "MiniHipatternsNote" },
                source = { pattern = "%f[%w]()SOURCE:", group = "MiniHipatternsNote" },
                small_source = { pattern = "%f[%w]()source:", group = "MiniHipatternsNote" },
                -- note = hi_words({ "NOTE", "INFO" }, "MiniHipatternsNote"),
                -- source = hi_words({ "SOURCE", "source" }, "MiniHipatternsNote"),

                hex_color = hipatterns.gen_highlighter.hex_color(),
            },
        })

        ----------------------------
        -- MINI SPLIT-JOIN
        -- SOURCE: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-splitjoin.md
        ----------------------------
        local splitjoin = require("mini.splitjoin")
        splitjoin.setup({})

        ----------------------------
        -- MINI CURSORWORD
        -- SOURCE: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-cursorword.md
        ----------------------------
        local cursorword = require("mini.cursorword")
        -- cursorword.setup({ delay = 50 })
        cursorword.setup()

        ----------------------------
        -- MINI STATUSLINE
        ----------------------------
        local statusline = require("mini.statusline")
        -- TODO: move colors to colorscheme file
        vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", require("eb.utils.mini-helpers.colors").main.normal)
        vim.api.nvim_set_hl(0, "MiniStatuslineFilename", require("eb.utils.mini-helpers.colors").filename.normal)
        vim.api.nvim_set_hl(
            0,
            "MiniStatuslineFilenameModified",
            require("eb.utils.mini-helpers.colors").filename.modified
        )
        vim.api.nvim_set_hl(
            0,
            "MiniStatuslineFilenameReadonly",
            require("eb.utils.mini-helpers.colors").filename.read_only
        )
        vim.api.nvim_set_hl(0, "MiniStatuslineGit", require("eb.utils.mini-helpers.colors").git)
        vim.api.nvim_set_hl(0, "MiniStatuslineMacro", require("eb.utils.mini-helpers.colors").macro)
        vim.api.nvim_set_hl(0, "MiniStatuslineLocation", require("eb.utils.mini-helpers.colors").location)
        vim.api.nvim_set_hl(0, "MiniStatuslineLsp", require("eb.utils.mini-helpers.colors").lsp)
        vim.api.nvim_set_hl(0, "MiniStatusLineLazy", require("eb.utils.mini-helpers.colors").lazy)

        statusline.setup({
            use_icons = true,
            content = {
                active = function()
                    local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 1000 })
                    local filename = require("eb.utils.mini-helpers.filename").format_filename()
                    local git = require("eb.utils.mini-helpers.git").branch_name()
                    local word_count = require("eb.utils.lualine-helpers.word-count")
                    local macro = require("eb.utils.mini-helpers.macro").status()
                    local words = word_count.filetype() and word_count.word_count() or ""
                    local buffer_count = require("eb.utils.mini-helpers.buffer-count").count_buffers()
                    local permissions = require("eb.utils.mini-helpers.permissions").get_permissions()
                    local diff = require("eb.utils.mini-helpers.git-diff").diff_source()
                    local qf = require("eb.utils.mini-helpers.quickfix").counter()
                    local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
                    local location = MiniStatusline.section_location({ trunc_width = 1000 })
                    local lazy_status = require("lazy.status")
                    local diagnostics = require("eb.utils.mini-helpers.diagnostics").status()

                    return statusline.combine_groups({
                        { hl = mode_hl, strings = { mode } },
                        { hl = "MiniStatuslineGit", strings = { git } },
                        {
                            hl = (vim.bo.readonly or not vim.bo.modifiable) and "MiniStatuslineFilenameReadonly"
                                or (vim.bo.modified and "MiniStatuslineFilenameModified")
                                or "MiniStatuslineFilename",
                            strings = { filename },
                        },
                        { strings = { diff } },
                        { strings = { diagnostics } },
                        { strings = { permissions } },
                        { strings = { "%=" } },
                        { strings = { words } },
                        { strings = { "%=" } },
                        { strings = { qf } },
                        { hl = "MiniStatusLineLazy", strings = { lazy_status.updates() } },
                        { strings = { buffer_count } },
                        { hl = "MiniStatuslineLocation", strings = { location } },
                        { hl = "MiniStatuslineLsp", strings = { lsp } },
                        { hl = "MiniStatuslineMacro", strings = { macro } },
                    })
                end,
            },
        })

        -- MINI MISC
        require("mini.misc").setup({})
        require("mini.misc").setup_restore_cursor()

        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_silent = custom_helpers.keymap_silent

        keymap_silent("n", "<leader>=", function()
            require("mini.misc").zoom()
        end, "MINI: Zoom in/out buffer")

        ----------------------------
        -- MINI KEYMAP
        -- SOURCE: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-keymap.md
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
        -- MINI TRAILSPACE
        ----------------------------

        local trailspace = require("mini.trailspace")
        trailspace.setup({})

        ----------------------------
        -- MINI VISITS
        ----------------------------
        local visits = require("mini.visits")
        visits.setup({})

        ----------------------------
        -- MINI PICK
        ----------------------------
        local pick = require("mini.pick")
        local hostname = custom_helpers.get_hostname()

        extra.setup()
        pick.setup({
            mappings = {
                choose_marked = "<C-q>",
                mark = "<C-a>",
                mark_all = "<C-x>",
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
                    width = 100,
                    height = 20,
                    border = "bold",
                },
            },
        })

        vim.ui.select = pick.ui_select

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

        pick.registry.grep_live_smartcase = function()
            load_temp_rg(function()
                pick.builtin.grep_live({ tool = "rg" })
            end)
        end

        -- SOURCE: https://github.com/echasnovski/mini.nvim/discussions/1926
        pick.registry.command_history = function()
            local edit_command = function()
                local match = pick.get_picker_matches()
                if not match then
                    return
                end
                local value = type(match.current) == "table" and match.current.value or tostring(match.current)
                value = value:gsub("^:+", "")
                pick.stop()
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
            extra.pickers.history({ scope = ":" }, opts)
        end

        local reboot_projects_dir = ""
        local obsidian_vault = ""
        local dotfiles_bare_dir = ""
        if hostname == "JIGA" then
            reboot_projects_dir = "~/reboot/"
            obsidian_vault = "/mnt/d/the_vault/"
            dotfiles_bare_dir = "$HOME/.dotfiles"
        elseif hostname == "eb-t490" then
            reboot_projects_dir = "~/scripts/reboot/"
            obsidian_vault = "~/Documents/the_vault"
            dotfiles_bare_dir = "$HOME/.cfg"
        end

        pick.registry.configs = function()
            local cwd = vim.fn.expand("$HOME/.config")
            local choose = function(item)
                vim.schedule(function()
                    pick.builtin.files(nil, { source = { cwd = item.path } })
                end)
            end
            return extra.pickers.explorer({ cwd = cwd }, { source = { choose = choose } })
        end

        pick.registry.reboot_projects = function()
            local cwd = vim.fn.expand(reboot_projects_dir)
            local choose = function(item)
                vim.schedule(function()
                    pick.builtin.files(nil, { source = { cwd = item.path } })
                end)
            end
            return extra.pickers.explorer({ cwd = cwd }, { source = { choose = choose } })
        end

        pick.registry.find_obsidian = function()
            load_temp_rg(function()
                pick.builtin.files({ tool = "rg" }, { source = { cwd = obsidian_vault } })
            end)
        end

        pick.registry.grep_obsidian = function()
            load_temp_rg(function()
                pick.builtin.grep({ tool = "rg" }, { source = { cwd = obsidian_vault } })
            end)
        end

        pick.registry.dotfiles = function()
            local git_dir = vim.fn.expand(dotfiles_bare_dir)
            local work_tree = vim.fn.expand("$HOME")

            if vim.fn.isdirectory(git_dir) == 0 then
                vim.notify("Git directory does not exist: " .. git_dir, vim.log.levels.WARN)
                return
            end

            local items = vim.fn.systemlist({
                "git",
                "--git-dir=" .. git_dir,
                "-C",
                work_tree,
                "ls-files",
            })

            vim.schedule(function()
                pick.start({
                    source = {
                        items = vim.tbl_map(function(item)
                            return work_tree .. "/" .. item
                        end, items),
                        name = "Dotfiles",
                    },
                })
            end)
        end

        local keymap = function(keys, func, desc)
            if desc then
                desc = "MINI: " .. desc
            end

            vim.keymap.set("n", keys, func, { desc = desc })
        end

        -- helper command to invoke smart pick
        vim.api.nvim_create_user_command("SmartPick", function()
            require("eb.utils.smart-pick").setup()
            require("eb.utils.smart-pick").picker()
        end, {})

        -- keymap("<leader>ff", ":Pick find_files<CR>", "Find files")
        keymap("<leader>fh", ":Pick help<CR>", "Find help")
        -- keymap("<leader>fb", ":Pick buffers<CR>", "Find open buffers")
        keymap("<leader>ff", function()
            require("eb.utils.smart-pick").setup()
            require("eb.utils.smart-pick").picker()
        end, "SmartPick")
        keymap("<leader>fk", ":Pick keymaps<CR>", "Find keymaps")
        keymap("<leader>fo", ":Pick oldfiles<CR>", "Find old files")
        keymap("<leader>fm", ":Pick marks<CR>", "Find marks")
        keymap("<leader>fg", ":Pick git_files<CR>", "Find files in current git repository")
        keymap("<leader>fe", ":Pick git_files scope='modified'<CR>", "Find modified git files")
        keymap("<leader>fss", ":Pick grep_live_smartcase<CR>", "Grep live search (smartcase)")
        keymap("<leader>fsu", ":Pick commands<CR>", "Find search user commands")
        keymap("<leader>fsw", ":Pick grep pattern='<cword>'<CR>", "Find search word under cursor")
        keymap("<leader>fch", ":Pick command_history<CR>", "Find command history")
        keymap("<leader>fsh", ":Pick history scope='/'<CR>", "Find search history")
        keymap("<leader>fsf", ":Pick visit_paths<CR>", "Find recently visited files")
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
        keymap("<leader>fsb", ":Pick buf_lines scope='current' preserve_order=true<CR>", "Find search buffer")
        keymap("<leader>fst", ":Pick hipatterns<CR>", "Find search hipatterns")
        keymap("<leader>fsr", ":Pick registers<CR>", "Find search registers")
        keymap("<leader>fF", ":Pick find_home<CR>", "Find file from home directory")
        keymap("<leader>co", ":Pick list scope='quickfix'<CR>", "Find all items in quickfix list")
        keymap("<leader>os", ":Pick find_obsidian<CR>", "Find in obsidian vault")
        keymap("<leader>oz", ":Pick grep_obsidian<CR>", "Grep in obsidian vault")
        keymap("<leader>fn", function()
            pick.builtin.files(nil, { source = { cwd = vim.fn.stdpath("config") } })
        end, "Find file in nvim config")

        ----------------------------
        -- MINI SESSIONS
        ----------------------------
        local MiniSessions = require("mini.sessions")
        MiniSessions.setup({})

        local session_name = custom_helpers.get_project_name()

        keymap("<leader>ws", function()
            MiniSessions.write(session_name)
            vim.notify("Session saved: " .. session_name)
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
