-- _ ____   _(_)_ __ ___         ___ _ __ ___  _ __
-- | '_ \ \ / / | '_ ` _ \ _____ / __| '_ ` _ \| '_ \
-- | | | \ V /| | | | | | |_____| (__| | | | | | |_) |
-- |_| |_|\_/ |_|_| |_| |_|      \___|_| |_| |_| .__/
--                                             |_|
-- https://github.com/hrsh7th/nvim-cmp

-- Description:
-- A completion engine plugin for neovim written in Lua

return {
    'hrsh7th/nvim-cmp', -- main completion plugin
    -- event = 'InsertEnter',
    dependencies = {
        'hrsh7th/cmp-buffer',                  -- plugin for buffer completion
        'hrsh7th/cmp-path',                    -- plugin for path completion
        'saadparwaiz1/cmp_luasnip',            -- plugin for snippet completion
        'hrsh7th/cmp-cmdline',                 -- plugin for command line completion
        'hrsh7th/cmp-nvim-lua',                -- plugin for nvim-lua completion
        'hrsh7th/cmp-nvim-lsp-signature-help', -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
        'onsails/lspkind.nvim',                -- https://github.com/onsails/lspkind.nvim
        'L3MON4D3/LuaSnip',                    -- https://github.com/L3MON4D3/LuaSnip
        'rafamadriz/friendly-snippets',        -- https://github.com/rafamadriz/friendly-snippets
    },

    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local lspkind = require('lspkind')

        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({

            completion = {
                completeopt = "menu,menuone,preview,noselect"
            },

            -- SNIPPETS
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body) -- For `luasnip` users.
                end,
            },

            -- KEYMAPPING
            mapping = {

                ['<A-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                ['<A-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
                ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
                ['<C-n>'] = cmp.mapping({
                    c = function()
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        end
                    end,
                    i = function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            fallback()
                        end
                    end
                }),
                ['<C-p>'] = cmp.mapping({
                    c = function()
                        if cmp.visible() then
                            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                        end
                    end,
                    i = function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            fallback()
                        end
                    end
                }),
                ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                ['<C-e>'] = cmp.mapping({
                    i = cmp.mapping.close(),
                    c = cmp.mapping.close(),
                }),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-y>'] = cmp.mapping({
                    i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
                    c = function(fallback)
                        if cmp.visible() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                        else
                            fallback()
                        end
                    end
                }),
            },
            -- FORMATTING
            window = {
                completion = {
                    col_offset = -3,
                    side_padding = 1,
                },
            },
            formatting = {
                -- fields = { "kind", "abbr", "menu" },
                format = lspkind.cmp_format({
                    mode = 'symbol',       -- show only symbol annotations
                    maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    before = function(entry, vim_item)
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            nvim_lua = "[NVIM_LUA]",
                            luasnip = "[LUASNIP]",
                            buffer = "[BUFFER]",
                            path = "[PATH]",
                        })[entry.source.name]
                        return vim_item
                    end
                }),
            },

            -- SOURCES
            sources = cmp.config.sources {
                { name = 'luasnip' },
                { name = 'nvim_lua' },
                { name = 'nvim_lsp' },
                { name = 'nvim_lsp_signature_help' },
                { name = 'path' },
                { name = 'buffer' },
            },

            -- COMMAND LINE
            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline('/', {
                sources = {
                    { name = 'buffer' }
                }
            }),

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        })

        -- TEST:
        -- print("Hello from lazy cmp")
    end
}
