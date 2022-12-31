-- local nvim_lsp = require('lspconfig')

-- -- Use an on_attach function to only map the following keys after the language server attaches to the current buffer
-- local on_attach = function(client, bufnr)

--     local keymap = function(keys, func, desc)
--         if desc then
--             desc = 'LSP: ' .. desc
--         end

--         vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
--     end

--     keymap('rn', vim.lsp.buf.rename, '[R]e[N]ame')
--     keymap('ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

--     keymap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
--     keymap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
--     keymap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
--     keymap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
--     keymap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
--     keymap('<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', '[F]ormat code')
--     keymap('df', vim.diagnostic.open_float, 'Open [D]iagnostic [F]loat')

--     -- See `:help K` for why this keymap
--     keymap('K', vim.lsp.buf.hover, 'Hover Documentation')
--     keymap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

--     -- Lesser used LSP functionality
--     -- keymap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
--     -- keymap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
--     -- keymap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
--     -- keymap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
--     -- keymap('<leader>wl', function()
--     --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--     -- end, '[W]orkspace [L]ist Folders')

--     -- Disable Autoformat
--     client.server_capabilities.document_formatting = false
--     client.server_capabilities.document_range_formatting = false

--     -- Diagnostic Sigs
--     local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

--     for type, icon in pairs(signs) do
--         local hl = "DiagnosticSign" .. type
--         vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
--     end
-- end

-- -- language servers go here
-- local servers = { 'vimls', 'bashls', 'pyright', 'sumneko_lua', 'ansiblels' }
-- for _, lsp in ipairs(servers) do
--     nvim_lsp[lsp].setup {
--         -- capabilities = capabilities,
--         on_attach = on_attach,
--         settings = {
--             Lua = {
--                 diagnostics = {
--                     -- Get the language server to recognize the `vim` global
--                     globals = { 'vim' },
--                 },
--             },
--         },
--     }
-- end

-- -- capabilities
-- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- require 'lspconfig'.bashls.setup {
--     capabilities = capabilities
-- }

-- require 'lspconfig'.vimls.setup {
--     capabilities = capabilities
-- }

-- require 'lspconfig'.pylsp.setup {
--     capabilities = capabilities
-- }

-- require 'lspconfig'.ansiblels.setup {
--     capabilities = capabilities
-- }

-- vim.diagnostic.config({
--     virtual_text = false
-- })

-- -- Show line diagnostics automatically in hover window
-- vim.o.updatetime = 250
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
