-- NOTE: Snapshot
-- SOURCE: https://dev.to/vonheikemen/lazynvim-how-to-revert-a-plugin-back-to-a-previous-version-1pdp
local lazy_cmds = vim.api.nvim_create_augroup("lazy_cmds", { clear = true })
local snapshot_dir = vim.fn.stdpath("data") .. "/plugin-snapshot"
local lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json"

vim.api.nvim_create_user_command("BrowseSnapshots", "edit " .. snapshot_dir, {})

vim.api.nvim_create_autocmd("User", {
    group = lazy_cmds,
    pattern = "LazyUpdatePre",
    desc = "Backup lazy.nvim lockfile",
    callback = function(event)
        vim.fn.mkdir(snapshot_dir, "p")
        local snapshot = snapshot_dir .. os.date("/%Y-%m-%dT%H:%M:%S.json")

        vim.loop.fs_copyfile(lockfile, snapshot)
    end,
})

-------------------------------------------------------------------------------
vim.api.nvim_create_augroup("ui_enhancements", { clear = true })

-- NOTE: Toggle relative numbers for active panes only
local excluded_filetypes = {
    "alpha",
    "dashboard",
    "lazy",
    "NvimTree",
    "TelescopePrompt",
    "man",
    "help",
    -- add any others you want
}

local function should_ignore()
    return vim.tbl_contains(excluded_filetypes, vim.bo.filetype)
end

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "FocusGained" }, {
    group = "ui_enhancements",
    callback = function()
        if not should_ignore() then
            vim.wo.relativenumber = true
        end
    end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave", "FocusLost" }, {
    group = "ui_enhancements",
    callback = function()
        if not should_ignore() then
            vim.wo.relativenumber = false
        end
    end,
})

-------------------------------------------------------------------------------
-- NOTE: Disable new line comment
vim.api.nvim_create_autocmd("BufEnter", {
    group = "ui_enhancements",
    callback = function()
        vim.opt.formatoptions:remove({ "c", "r", "o" })
    end,
    desc = "Disable New Line Comment",
})

-------------------------------------------------------------------------------
-- NOTE: Rasi ft
vim.api.nvim_create_augroup("rasi_ft", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    group = "rasi_ft",
    pattern = "*.rasi",
    command = "set ft=rasi",
})

-------------------------------------------------------------------------------
-- NOTE: Wsl clipboard
local function get_distro_name()
    local handle = io.popen("echo $WSL_DISTRO_NAME")
    if not handle then
        return nil
    end

    local hostname = handle:read("*a")
    handle:close()
    return hostname:match("^%s*(.-)%s*$")
end

if get_distro_name() ~= "" then
    vim.g.clipboard = {
        name = "WslClipboard",
        copy = {
            ["+"] = "clip.exe",
            ["*"] = "clip.exe",
        },
        paste = {
            ["+"] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ["*"] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
end

-------------------------------------------------------------------------------
-- NOTE: autoformat on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.*",
    callback = function()
        -- List of filetypes to ignore
        local ignore_filetypes = { "query", "tmux" }

        -- Check if the current buffer's filetype is in the ignore list
        if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
            return
        end

        if vim.bo.modified == true then
            -- vim.cmd("Format")
            require("conform").format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        else
            vim.notify("No changes to save")
        end
    end,
})

-------------------------------------------------------------------------------
-- NOTE: autosort tailwindclasses on save
-- TODO: tailwind-tools is not longer being maintained, need to look for an alternative
-- vim.api.nvim_create_autocmd("BufWritePost", {
--     pattern = { "*.html", "*.jsx", "*.tsx", "*.css", "*.scss" }, -- Replace with the desired filetypes
--     callback = function()
--         local buf_clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
--         for _, client in ipairs(buf_clients) do
--             if client.name == "tailwindcss" then
--                 vim.cmd("TailwindSort")
--                 return
--             end
--         end
--     end,
--     desc = "Automatically sort Tailwind classes on save, if Tailwind LSP is active",
-- })

-------------------------------------------------------------------------------
-- NOTE: remove messages from commandine after a set interval
vim.api.nvim_create_autocmd("CmdlineLeave", {
    group = "ui_enhancements",
    callback = function()
        vim.defer_fn(function()
            vim.cmd("echo ''")
        end, 3000)
    end,
})

-------------------------------------------------------------------------------
-- NOTE: disable line numbers and mini indentscope plugin for specific filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = "ui_enhancements",
    pattern = { "man", "help" },
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.b.miniindentscope_disable = true
    end,
})

-------------------------------------------------------------------------------
-- NOTE: highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight selection on yank",
    callback = function()
        vim.hl.on_yank({ higroup = "YankHi", timeout = 50 })
    end,
})

-------------------------------------------------------------------------------

-- NOTE: https://oneofone.dev/post/neovim-diagnostics-float/
-- local group = vim.api.nvim_create_augroup("OoO", {})
--
-- local function au(typ, pattern, cmdOrFn)
--     if type(cmdOrFn) == "function" then
--         vim.api.nvim_create_autocmd(typ, { pattern = pattern, callback = cmdOrFn, group = group })
--     else
--         vim.api.nvim_create_autocmd(typ, { pattern = pattern, command = cmdOrFn, group = group })
--     end
-- end
--
-- au({ "CursorHold", "InsertLeave" }, nil, function()
--     local opts = {
--         focusable = true,
--         scope = "cursor",
--         close_events = { "CursorMoved", "InsertEnter" },
--         border = "rounded",
--     }
--     vim.diagnostic.open_float(nil, opts)
-- end)
--
-- au("InsertEnter", nil, function()
--     vim.diagnostic.enable(false)
-- end)
--
-- au("InsertLeave", nil, function()
--     vim.diagnostic.enable(true)
-- end)

-------------------------------------------------------------------------------

-- NOTE: do not remove this, its a workaround for rust files diagnostics
local function ra_flycheck()
    local clients = vim.lsp.get_clients({
        name = "rust_analyzer",
    })
    for _, client in ipairs(clients) do
        local params = vim.lsp.util.make_text_document_params()
        client.notify("rust-analyzer/runFlycheck", params)
    end
end

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    pattern = "*.rs",
    callback = function()
        vim.cmd("w")
        ra_flycheck()
    end,
})

-------------------------------------------------------------------------------
-- NOTE: Always open help in vertical split

vim.api.nvim_create_autocmd("BufWinEnter", {
    group = "ui_enhancements",
    callback = function()
        if vim.bo.filetype == "help" then
            vim.cmd("wincmd L")
            -- Recalculate scrolloff based on the new window size
            vim.opt_local.scrolloff = 10
        end
    end,
})

-------------------------------------------------------------------------------
-- NOTE: Auto save mini session

local custom_helpers = require("eb.utils.custom_helpers")
local session_name = custom_helpers.get_project_name()
local MiniSessions = require("mini.sessions")

vim.api.nvim_create_autocmd("BufWritePost", {
    group = "ui_enhancements",
    callback = function()
        MiniSessions.write(session_name)
    end,
})

-------------------------------------------------------------------------------
-- NOTE: Biome auto fix all on save
-- Whenever an LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if not client then
            return
        end

        -- When the client is Biome, add an automatic event on
        -- save that runs Biome's "source.fixAll.biome" code action.
        -- This takes care of things like JSX props sorting and
        -- removing unused imports.
        if client.name == "biome" then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("BiomeFixAll", { clear = true }),
                callback = function()
                    vim.lsp.buf.code_action({
                        context = {
                            only = { "source.fixAll.biome" },
                            diagnostics = {},
                        },
                        apply = true,
                    })
                end,
            })
        end
    end,
})

-------------------------------------------------------------------------------

-- SOURCE: https://gist.github.com/smnatale/692ac4f256d5f19fbcbb78fe32c87604

-- NOTE: ide like highlight when stopping cursor
-- vim.api.nvim_create_autocmd("CursorMoved", {
--     group = vim.api.nvim_create_augroup("LspReferenceHighlight", { clear = true }),
--     desc = "Highlight references under cursor",
--     callback = function()
--         -- NOTE: Only run if the cursor is not in insert mode
--         if vim.fn.mode() ~= "i" then
--             local clients = vim.lsp.get_clients({ bufnr = 0 })
--             local supports_highlight = false
--             for _, client in ipairs(clients) do
--                 if client.server_capabilities.documentHighlightProvider then
--                     supports_highlight = true
--                     break -- Found a supporting client, no need to check others
--                 end
--             end
--
--             -- NOTE: Proceed only if an LSP is active AND supports the feature
--             if supports_highlight then
--                 vim.lsp.buf.clear_references()
--                 vim.lsp.buf.document_highlight()
--             end
--         end
--     end,
-- })
--
-- NOTE: ide like highlight when stopping cursor
-- vim.api.nvim_create_autocmd("CursorMovedI", {
--     group = "LspReferenceHighlight",
--     desc = "Clear highlights when entering insert mode",
--     callback = function()
--         vim.lsp.buf.clear_references()
--     end,
-- })

return {}
