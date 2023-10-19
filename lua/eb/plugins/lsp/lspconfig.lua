--   _                            __ _
-- | |___ _ __   ___ ___  _ __  / _(_) __ _
-- | / __| '_ \ / __/ _ \| '_ \| |_| |/ _` |
-- | \__ \ |_) | (_| (_) | | | |  _| | (_| |
-- |_|___/ .__/ \___\___/|_| |_|_| |_|\__, |
--       |_|                          |___/
-- https://github.com/neovim/nvim-lspconfig

return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
    },

    config = function()
        local lspconfig = require('lspconfig')
        local cmp_nvim_lsp = require('cmp_nvim_lsp')

        -- KEYMAPS
        -- NOTE: Use an on_attach function to only map the following keys after the language server attaches to the current buffer
        local on_attach = function(client, bufnr)
            local keymap = function(keys, func, desc)
                if desc then
                    desc = 'LSP: ' .. desc
                end

                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end

            keymap('rn', vim.lsp.buf.rename, 'ReName')
            keymap('ca', vim.lsp.buf.code_action, 'Code Action')

            keymap('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
            -- keymap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
            -- keymap('gr', require('telescope.builtin').lsp_references, 'Goto References')
            keymap('gI', vim.lsp.buf.implementation, 'Goto Implementation')
            -- keymap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
            keymap('<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', 'Format code')
            keymap('df', vim.diagnostic.open_float, 'Open Diagnostic Float')

            -- NOTE: `:help K` for why this keymap
            keymap('K', vim.lsp.buf.hover, 'Hover Documentation')
            keymap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                vim.lsp.buf.format()
            end, { desc = 'Format current buffer with LSP' })

            -- Disable Autoformat
            client.server_capabilities.document_formatting = false
            client.server_capabilities.document_range_formatting = false

            -- Diagnostic Signs
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            -- NOTE: hover config, using noice for now
            -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            --     vim.lsp.handlers.hover, {
            --         border = "none",
            --     }
            -- )
        end

        -- NOTE: Language servers go here
        local servers = {
            'vimls',
            'bashls',
            'pyright',
            'lua_ls',
            'ansiblels',
            'jsonls',
            'terraformls',
            'html',
            'sqlls',
            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#emmet_language_server
            -- https://github.com/olrtg/emmet-language-server
            'emmet_language_server',
            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
            -- https://github.com/hrsh7th/vscode-langservers-extracted
            'eslint',
            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
            -- https://github.com/typescript-language-server/typescript-language-server
            'tsserver',
            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssls
            'cssls',
        }

        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup {
                on_attach = on_attach,
                sqlls = {
                    cmd = { "sql-language-server", "up", "--method", "stdio" },
                    filetypes = { "sql", "mysql" },
                    root_dir = function() return vim.loop.cwd() end,
                },
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            -- NOTE: Get the language server to recognize the `vim` global
                            globals = { 'vim' },
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            }
        end

        -- Capabilities
        local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

        -- NOTE: required for cssls to work
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssls
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        require 'lspconfig'.bashls.setup {
            capabilities = capabilities
        }

        require 'lspconfig'.vimls.setup {
            capabilities = capabilities
        }

        require 'lspconfig'.pylsp.setup {
            capabilities = capabilities
        }

        require 'lspconfig'.ansiblels.setup {
            capabilities = capabilities
        }

        require 'lspconfig'.jsonls.setup {
            capabilities = capabilities
        }

        require 'lspconfig'.terraformls.setup {
            capabilities = capabilities,
        }

        require 'lspconfig'.html.setup {
            capabilities = capabilities,
        }

        require 'lspconfig'.sqlls.setup {
            capabilities = capabilities,
        }

        require 'lspconfig'.emmet_language_server.setup {
            capabilities = capabilities,
            filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte",
                "pug", "typescriptreact", "vue" },

            -- https://github.com/olrtg/emmet-language-server#neovim
            init_options = {
                showSuggestionsAsSnippets = true,
            }
        }

        require 'lspconfig'.eslint.setup {
            capabilities = capabilities,
        }

        require 'lspconfig'.tsserver.setup {
            capabilities = capabilities,
        }

        require 'lspconfig'.cssls.setup {
            capabilities = capabilities,
        }

        vim.diagnostic.config({
            virtual_text = false
        })

        vim.o.updatetime = 250

        -- Old command for float, not being used and replaced with the below command
        -- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

        -- NOTE: Show diagnostics in a pop-up window on hover
        -- SOURCE: https://www.reddit.com/r/neovim/comments/mqspfo/is_there_any_way_to_hide_the_diagnostic_from/
        _G.LspDiagnosticsPopupHandler = function()
            local current_cursor = vim.api.nvim_win_get_cursor(0)
            local last_popup_cursor = vim.w.lsp_diagnostics_last_cursor or { nil, nil }

            -- Show the popup diagnostics window,
            -- but only once for the current cursor location (unless moved afterwards).
            if not (current_cursor[1] == last_popup_cursor[1] and current_cursor[2] == last_popup_cursor[2]) then
                vim.w.lsp_diagnostics_last_cursor = current_cursor
                vim.diagnostic.open_float(0, { scope = "cursor" }) -- for neovim 0.6.0+, replaces show_{line,position}_diagnostics
            end
        end
        vim.cmd([[
        augroup LSPDiagnosticsOnHover
        autocmd!
        autocmd CursorHold *   lua _G.LspDiagnosticsPopupHandler()
        augroup END
        ]])

        -- TEST:
        -- print("Hello from lazy lspconfig")
    end
}
