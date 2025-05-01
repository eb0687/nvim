local border_chars = { "", "─", "╮", "│", "╯", "─", "╰", "│" }

return {
    "saghen/blink.cmp",
    dependencies = {
        "rafamadriz/friendly-snippets",
        "moyiz/blink-emoji.nvim",
        "MahanRahmati/blink-nerdfont.nvim",
        "disrupted/blink-cmp-conventional-commits",
        -- "giuxtaposition/blink-cmp-copilot",
        { "L3MON4D3/LuaSnip", version = "v2.*" },
        -- "folke/lazydev.nvim",
        {
            "stevearc/vim-vscode-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
                require("luasnip.loaders.from_vscode").lazy_load({ paths = "./custom_snippets" })
            end,
        },
    },
    version = "1.*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        enabled = function()
            return vim.g.blink_cmp
        end,
        keymap = { preset = "enter" },
        appearance = {
            nerd_font_variant = "mono",
            -- kind_icons = {
            --     Copilot = "",
            -- },
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
                    border = border_chars,
                },
            },
            menu = {
                border = border_chars,
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
                border = border_chars,
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
                "nerdfont",
                "conventional_commits",
                -- "copilot",
                -- "lazydev",
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
                nerdfont = {
                    module = "blink-nerdfont",
                    name = "Nerd Fonts",
                    score_offset = 15,
                    opts = { insert = true },
                },
                conventional_commits = {
                    name = "Conventional Commits",
                    module = "blink-cmp-conventional-commits",
                    enabled = function()
                        return vim.bo.filetype == "gitcommit"
                    end,
                    ---@module 'blink-cmp-conventional-commits'
                    ---@type blink-cmp-conventional-commits.Options
                    opts = {},
                },
                -- copilot = {
                --     name = "copilot",
                --     module = "blink-cmp-copilot",
                --     score_offset = 100,
                --     async = true,
                --     transform_items = function(_, items)
                --         local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                --         local kind_idx = #CompletionItemKind + 1
                --         CompletionItemKind[kind_idx] = "Copilot"
                --         for _, item in ipairs(items) do
                --             item.kind = kind_idx
                --         end
                --         return items
                --     end,
                -- },
                -- lazydev = {
                --     name = "LazyDev",
                --     module = "lazydev.integrations.blink",
                --     -- make lazydev completions top priority (see `:h blink.cmp`)
                --     score_offset = 100,
                -- },
            },
        },
        fuzzy = {
            implementation = "prefer_rust_with_warning",
            -- sorts = { "exact", "kind", "sort_text", "label", "score" },
            sorts = { "exact", "score", "sort_text", "kind", "label" },
        },
    },
    opts_extend = { "sources.default" },
}
