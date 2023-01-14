-- LSP

-- NOTE: make sure mason-lspconfig is setup before lsp server configs are setup
-- Source: https://github.com/williamboman/mason.nvim/issues/124#issuecomment-1203211832

-- MASON CONFIG [[[

-- protective call so nothing breaks if lspconfig is missing
local status_ok, _ = pcall(require, 'mason-lspconfig')
if not status_ok then
    return
end

-- VARIABLES
local mason_setup = require("mason").setup
local mason_lsp = require("mason-lspconfig").setup

-- NOTE: setup calls required for both mason & mason-lspconfig
-- Source: https://github.com/williamboman/mason-lspconfig.nvim#setup

mason_setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

mason_lsp({
    -- NOTE: this section makes sure the below languages are available during first install when running :LSPInstall
    ensure_installed = {
        'vimls',
        'bashls',
        'pyright',
        'sumneko_lua',
        'ansiblels',
        'jsonls'
    }
})

-- ]]]
-- LSP CONFIGS & KEYMAPS [[[

-- VARIABLE
local nvim_lsp = require('lspconfig')

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
    keymap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
    keymap('gr', require('telescope.builtin').lsp_references, 'Goto References')
    keymap('gI', vim.lsp.buf.implementation, 'Goto Implementation')
    keymap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
    keymap('<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', 'Format code')
    keymap('df', vim.diagnostic.open_float, 'Open Diagnostic Float')

    -- NOTE: `:help K` for why this keymap
    keymap('K', vim.lsp.buf.hover, 'Hover Documentation')
    keymap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    -- keymap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    -- keymap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    -- keymap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    -- keymap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    -- keymap('<leader>wl', function()
    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, '[W]orkspace [L]ist Folders')

    -- Disable Autoformat
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false

    -- Diagnostic Signs
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
end

-- NOTE: Language servers go here
local servers = {
    'vimls',
    'bashls',
    'pyright',
    'sumneko_lua',
    'ansiblels',
    'jsonls'
}

for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        -- capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            Lua = {
                diagnostics = {
                    -- NOTE: Get the language server to recognize the `vim` global
                    globals = { 'vim' },
                },
            },
        },
    }
end

-- Capabilities
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

require 'lspconfig'.jsonls.setup {
    capabilities = capabilities
}

vim.diagnostic.config({
    virtual_text = false
})

-- NOTE: The below creates line diagnostics automatically in a hover window
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- ]]]

-- TEST:
-- print("Hello from AFTER/LSP")
