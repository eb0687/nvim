local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

    -- Mappings
    local function keymaps(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    local opts = { noremap = true, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    keymaps('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    keymaps('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    keymaps('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    keymaps('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    keymaps('n', '<C-p>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    keymaps('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- keymaps('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    keymaps('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    keymaps('n', '<space>N', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    keymaps('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    keymaps('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    keymaps('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- keymaps('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    keymaps('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    keymaps('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    keymaps('n', '<space>gq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    keymaps('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    keymaps('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

    -- Disable Autoformat
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false

    -- Diagnostic Sigs
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
end

-- language servers go here
local servers = { 'vimls', 'bashls', 'pyright', 'sumneko_lua', 'ansiblels' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        -- capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            Lua = {
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim' },
                },
            },
        },
    }
end

-- capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

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
