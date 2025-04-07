-- _ ____   _(_)_ __ ___         ___ _ __ ___  _ __
-- | '_ \ \ / / | '_ ` _ \ _____ / __| '_ ` _ \| '_ \
-- | | | \ V /| | | | | | |_____| (__| | | | | | |_) |
-- |_| |_|\_/ |_|_| |_| |_|      \___|_| |_| |_| .__/
--                                             |_|
-- https://github.com/hrsh7th/nvim-cmp

-- Description:
-- A completion engine plugin for neovim written in Lua

-- NOTE: replaced with blink

return {
    "hrsh7th/nvim-cmp", -- main completion plugin
    enabled = false,
    version = "v0.0.2",
    event = "InsertEnter",
    dependencies = {
        -- "hrsh7th/cmp-buffer", -- plugin for buffer completion
        -- "hrsh7th/cmp-path", -- plugin for path completion
        "hrsh7th/cmp-nvim-lsp",
        "saadparwaiz1/cmp_luasnip", -- plugin for snippet completion
        "hrsh7th/cmp-cmdline", -- plugin for command line completion
        "hrsh7th/cmp-nvim-lua", -- plugin for nvim-lua completion
        "hrsh7th/cmp-nvim-lsp-signature-help", -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
        "onsails/lspkind.nvim", -- https://github.com/onsails/lspkind.nvim
        "tailwind-tools",
        {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip").filetype_extend("javascriptreact", { "html" })
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        }, -- https://github.com/rafamadriz/friendly-snippets
        {
            "Dynge/gitmoji.nvim", -- https://github.com/Dynge/gitmoji.nvim
            opts = {},
            ft = { "gitcommit" },
        },
        "f3fora/cmp-spell",
        "stevearc/vim-vscode-snippets",
    },

    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        local utils = require("eb.utils.custom_helpers")
        local keymap_normal = utils.keymap_normal

        keymap_normal("<leader>uc", ":ToggleCmp<CR>", "CMP", true, "toggle nvim-cmp")

        -- NOTE: This is used to determine if there are any non-whitespace characters
        -- before the cursor in the current line. This is useful in various
        -- text-editing scenarios, such as deciding whether to trigger certain
        -- completions or actions based on the cursor's position relative to other text.
        -- delete this if it causes any issues.
        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        require("luasnip.loaders.from_vscode").lazy_load()

        vim.api.nvim_set_hl(0, "MyCursorLine", { fg = "#32302f", bg = "#7daea3", bold = true, italic = false })
        vim.api.nvim_set_hl(0, "MyBorder", { fg = "#7daea3" })

        cmp.setup({
            enabled = function()
                return vim.g.cmp_toggle
            end,

            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },

            -- SNIPPETS
            -- enable luasnip to handle snippet expansion for nvim-cmp
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body) -- For `luasnip` users.
                end,
            },

            confirm_opts = {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            },

            -- NOTE: disabling this for now, not liking how it doesnt select the thing i want
            -- preselect = "None",

            -- KEYMAPPING
            -- NOTE: to disable default keymappings assign it to cmp.config.disable
            -- for example: ["<C-y>"] = cmp.config.disable

            mapping = {
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-p>"] = cmp.mapping({
                    c = function()
                        if cmp.visible() then
                            cmp.mapping.scroll_docs(-3)
                        end
                    end,
                    i = function()
                        if cmp.visible() then
                            cmp.mapping.scroll_docs(-3)
                        end
                    end,
                }),
                ["<C-n>"] = cmp.mapping({
                    c = function()
                        if cmp.visible() then
                            cmp.mapping.scroll_docs(4)
                        end
                    end,
                    i = function()
                        if cmp.visible() then
                            cmp.mapping.scroll_docs(4)
                        end
                    end,
                }),
                ["<Down>"] = cmp.mapping(
                    cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    { "i", "c", "s" }
                ),
                ["<Up>"] = cmp.mapping(
                    cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    { "i", "c", "s" }
                ),
                ["<C-j>"] = cmp.mapping({
                    c = function()
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                        elseif has_words_before() then
                            cmp.complete()
                        end
                    end,
                    i = function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                        else
                            fallback()
                        end
                    end,
                }),
                ["<C-k>"] = cmp.mapping({
                    c = function()
                        if cmp.visible() then
                            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                        end
                    end,
                    i = function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                        else
                            fallback()
                        end
                    end,
                }),
                ["<C-e>"] = cmp.mapping({
                    i = cmp.mapping.close(),
                    c = cmp.mapping.close(),
                }),
                ["<CR>"] = cmp.mapping({
                    i = function(fallback)
                        -- if cmp.visible() and cmp.get_active_entry() then
                        if cmp.visible() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
                        else
                            fallback()
                        end
                    end,
                    s = function(fallback)
                        -- if cmp.visible() and cmp.get_active_entry() then
                        if cmp.visible() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
                        else
                            fallback()
                        end
                    end,
                    c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
                }),
            },

            -- FORMATTING
            window = {
                documentation = cmp.config.window.bordered({
                    winblend = 0,
                    winhighlight = "Normal:None,FloatBorder:None",
                    col_offset = 0,
                    side_padding = 1,
                    border = {
                        { "", "WarningMsg" },
                        { "─", "MyBorder" },
                        { "╮", "MyBorder" },
                        { "│", "MyBorder" },
                        { "╯", "MyBorder" },
                        { "─", "MyBorder" },
                        { "╰", "MyBorder" },
                        { "│", "MyBorder" },
                    },
                    scrollbar = false,
                }),
                completion = cmp.config.window.bordered({
                    winblend = 0,
                    winhighlight = "Normal:None,FloatBorder:None,CursorLine:MyCursorLine",
                    col_offset = 0,
                    side_padding = 1,
                    border = {
                        { "", "WarningMsg" },
                        { "─", "MyBorder" },
                        { "╮", "MyBorder" },
                        { "│", "MyBorder" },
                        { "╯", "MyBorder" },
                        { "─", "MyBorder" },
                        { "╰", "MyBorder" },
                        { "│", "MyBorder" },
                    },
                    scrollbar = false,
                }),
            },
            formatting = {
                -- fields = { "kind", "abbr", "menu" },
                format = lspkind.cmp_format({
                    before = require("tailwind-tools.cmp").lspkind_format,
                    mode = "symbol_text",
                    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    menu = {
                        nvim_lsp = "[LSP]",
                        luasnip = "[SNIP]",
                        nvim_lua = "[API]",
                        buffer = "[BUFF]",
                        gitmoji = "[GITMOJI]",
                        path = "[PATH]",
                        -- Codeium = "[Codeium]",
                        Copilot = "[Copilot]",
                    },
                    symbol_map = {
                        Copilot = "",
                        -- Codeium = "",
                    },
                    -- before = require("tailwindcss-colorizer-cmp").formatter,
                }),
            },
            experimental = {
                ghost_text = false,
            },

            -- Setup for vim-dadbod
            cmp.setup.filetype({ "sql" }, {
                sources = {
                    { name = "vim-dadbod-completion" },
                    { name = "buffer" },
                },
            }),

            -- NOTE: enable only buffer and path as sources for oil
            -- codeium completion error messages are annoying, this fixes it
            cmp.setup.filetype({ "oil" }, {
                sources = {
                    { name = "buffer" },
                    { name = "path" },
                },
            }),

            -- SOURCES
            sources = cmp.config.sources({
                -- { name = "vim-dadbod-completion" },
                { name = "nvim_lua" },
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "copilot" },
                -- { name = "codeium" },
                {
                    name = "lazydev",
                    group_index = 0,
                },
                { name = "path" },
                { name = "buffer" },
                { name = "nvim_lsp_signature_help" },
                { name = "gitmoji" },
            }),

            sorting = {
                priority_weight = 2,
                comparators = {
                    require("copilot_cmp.comparators").prioritize,
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.locality,
                    require("copilot_cmp.comparators").score,
                    function(entry1, entry2)
                        local _, entry1_under = entry1.completion_item.label:find("^_+")
                        local _, entry2_under = entry2.completion_item.label:find("^_+")
                        entry1_under = entry1_under or 0
                        entry2_under = entry2_under or 0
                        if entry1_under > entry2_under then
                            return false
                        elseif entry1_under < entry2_under then
                            return true
                        end
                    end,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },

            -- COMMAND LINE
            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline("/", {
                sources = {
                    { name = "buffer" },
                },
            }),

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(":", {
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            }),
        })

        -- https://github.com/roobert/tailwindcss-colorizer-cmp.nvim#hammer_and_wrench-usage
        -- NOTE: https://github.com/roobert/tailwindcss-colorizer-cmp.nvim/issues/5#issuecomment-1493050036
        -- integrated this with lspkind refer to the formatting section above
        -- require("cmp").setup {
        --     formatting = { format = require("tailwindcss-colorizer-cmp").formatter },
        -- }
    end,
}
