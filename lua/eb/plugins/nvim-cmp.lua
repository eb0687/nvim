-- _ ____   _(_)_ __ ___         ___ _ __ ___  _ __
-- | '_ \ \ / / | '_ ` _ \ _____ / __| '_ ` _ \| '_ \
-- | | | \ V /| | | | | | |_____| (__| | | | | | |_) |
-- |_| |_|\_/ |_|_| |_| |_|      \___|_| |_| |_| .__/
--                                             |_|
-- https://github.com/hrsh7th/nvim-cmp

-- Description:
-- A completion engine plugin for neovim written in Lua

return {
    "hrsh7th/nvim-cmp", -- main completion plugin
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer", -- plugin for buffer completion
        "hrsh7th/cmp-path", -- plugin for path completion
        "hrsh7th/cmp-nvim-lsp",
        "saadparwaiz1/cmp_luasnip", -- plugin for snippet completion
        "hrsh7th/cmp-cmdline", -- plugin for command line completion
        "hrsh7th/cmp-nvim-lua", -- plugin for nvim-lua completion
        "hrsh7th/cmp-nvim-lsp-signature-help", -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
        "onsails/lspkind.nvim", -- https://github.com/onsails/lspkind.nvim
        "rafamadriz/friendly-snippets", -- https://github.com/rafamadriz/friendly-snippets
        {
            "Dynge/gitmoji.nvim", -- https://github.com/Dynge/gitmoji.nvim
            opts = {},
            ft = "gitcommit",
        },
    },

    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
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

            -- KEYMAPPING
            mapping = {
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
                    { "i" }
                ),
                ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
                ["<C-j>"] = cmp.mapping({
                    c = function()
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
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
                -- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                ["<C-e>"] = cmp.mapping({
                    i = cmp.mapping.close(),
                    c = cmp.mapping.close(),
                }),
                ["<CR>"] = cmp.mapping({
                    i = function(fallback)
                        if cmp.visible() and cmp.get_active_entry() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
                        else
                            fallback()
                        end
                    end,
                    s = cmp.mapping.confirm({ select = true }),
                    c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
                }),
            },
            -- FORMATTING
            window = {
                -- completion = {
                --     col_offset = -3,
                --     side_padding = 1,
                --     winhighlight = 'Normal:#32302F',
                -- },
                documentation = {
                    cmp.config.window.bordered(),
                    winblend = 0,
                    border = "rounded",
                    winhighlight = "Normal:None,FloatBorder:None",
                    col_offset = -3,
                    side_padding = 1,
                },
                completion = {
                    cmp.config.window.bordered(),
                    winblend = 0,
                    border = "rounded",
                    winhighlight = "Normal:None,FloatBorder:None",
                    col_offset = -3,
                    side_padding = 1,
                },
            },
            formatting = {
                -- fields = { "kind", "abbr", "menu" },
                format = lspkind.cmp_format({
                    mode = "symbol_text", -- show only symbol annotations
                    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    menu = {
                        nvim_lsp = "[LSP]",
                        nvim_lua = "[NVIM_LUA]",
                        luasnip = "[LUASNIP]",
                        buffer = "[BUFFER]",
                        gitmoji = "[GITMOJI]",
                        path = "[PATH]",
                        Codeium = "[CODEIUM]",
                    },
                    before = require("tailwindcss-colorizer-cmp").formatter,
                }),
            },

            -- SOURCES
            sources = cmp.config.sources({
                { name = "vim-dadbod-completion" },
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "codeium" },
                { name = "nvim_lua" },
                { name = "nvim_lsp_signature_help" },
                { name = "path" },
                { name = "gitmoji" },
                { name = "buffer" },
            }),

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

        -- TEST:
        -- print("Hello from lazy cmp")
    end,
}
