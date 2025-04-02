return {
    "saghen/blink.cmp",
    dependencies = {
        "rafamadriz/friendly-snippets",
        "moyiz/blink-emoji.nvim",
        "giuxtaposition/blink-cmp-copilot",
        { "L3MON4D3/LuaSnip", version = "v2.*" },
    },
    version = "1.*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { preset = "enter" },
        appearance = {
            nerd_font_variant = "mono",
            kind_icons = {
                Copilot = "",
            },
        },

        cmdline = {
            enabled = true,
            completion = {
                menu = {
                    auto_show = true,
                },
            },
            keymap = {
                preset = "enter",
            },
        },
        completion = {
            documentation = {
                auto_show = true,
                window = {
                    border = { "", "─", "╮", "│", "╯", "─", "╰", "│" },
                },
            },
            menu = {
                border = { "", "─", "╮", "│", "╯", "─", "╰", "│" },
                auto_show = true,
                draw = {
                    columns = {
                        { "label", "label_description" },
                        { "kind_icon" },
                        { "kind" },
                        { "source_name" },
                        components = {
                            kind_icon = {
                                text = function(ctx)
                                    local lspkind = require("lspkind")
                                    local icon = ctx.kind_icon
                                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                        local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                                        if dev_icon then
                                            icon = dev_icon
                                        end
                                    else
                                        icon = require("lspkind").symbolic(ctx.kind, {
                                            mode = "symbol",
                                        })
                                    end

                                    return icon .. ctx.icon_gap
                                end,

                                -- Optionally, use the highlight groups from nvim-web-devicons
                                -- You can also add the same function for `kind.highlight` if you want to
                                -- keep the highlight groups in sync with the icons.
                                highlight = function(ctx)
                                    local hl = ctx.kind_hl
                                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                        local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                                        if dev_icon then
                                            hl = dev_hl
                                        end
                                    end
                                    return hl
                                end,
                            },
                        },
                    },
                },
            },
        },
        signature = {
            enabled = true,
            window = {
                border = { "", "─", "╮", "│", "╯", "─", "╰", "│" },
            },
        },

        snippets = { preset = "luasnip" },

        sources = {
            default = {
                "lsp",
                "path",
                "snippets",
                "buffer",
                "emoji",
                "copilot",
            },
            providers = {
                emoji = {
                    module = "blink-emoji",
                    name = "Emoji",
                    score_offset = 15, -- Tune by preference
                    opts = { insert = true },
                    should_show_items = function()
                        return vim.tbl_contains(
                            -- Enable emoji completion only for git commits and markdown.
                            -- By default, enabled for all file-types.
                            { "gitcommit", "markdown" },
                            vim.o.filetype
                        )
                    end,
                },
                copilot = {
                    name = "copilot",
                    module = "blink-cmp-copilot",
                    score_offset = 100,
                    async = true,
                    transform_items = function(_, items)
                        local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                        local kind_idx = #CompletionItemKind + 1
                        CompletionItemKind[kind_idx] = "Copilot"
                        for _, item in ipairs(items) do
                            item.kind = kind_idx
                        end
                        return items
                    end,
                },
            },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
