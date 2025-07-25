-- source: https://github.com/neovim/neovim/pull/15959
-- TESTING:
-- local user_command = vim.api.nvim_create_user_command
-- local input = vim.ui.input
--
-- local user_prompt = function()
--     input({
--         prompt = "Please enter some information: ",
--         default = "this is a test",
--     }, function(result)
--         vim.notify(result)
--     end)
-- end

-- user_command("HelloWorld", user_prompt, {
--     desc = "this a hello world user command test",
-- })

-------------------------------------------------------------------------------
-- NOTE: Snapshot
-- source: https://dev.to/vonheikemen/lazynvim-how-to-revert-a-plugin-back-to-a-previous-version-1pdp
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
    callback = function()
        if not should_ignore() then
            vim.wo.relativenumber = true
        end
    end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave", "FocusLost" }, {
    callback = function()
        if not should_ignore() then
            vim.wo.relativenumber = false
        end
    end,
})

-------------------------------------------------------------------------------
-- NOTE: Disable new line comment
vim.api.nvim_create_autocmd("BufEnter", {
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
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.html", "*.jsx", "*.tsx", "*.css", "*.scss" }, -- Replace with the desired filetypes
    callback = function()
        local buf_clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
        for _, client in ipairs(buf_clients) do
            if client.name == "tailwindcss" then
                vim.cmd("TailwindSort")
                return
            end
        end
    end,
    desc = "Automatically sort Tailwind classes on save, if Tailwind LSP is active",
})

-------------------------------------------------------------------------------
-- NOTE: Custom grep
vim.api.nvim_create_user_command("Grep", function(opts)
    local query = opts.args
    if query and query ~= "" then
        vim.cmd("copen")
        vim.cmd("silent grep " .. query)
    else
        vim.notify("Usage: :Grep <search_term>")
    end
end, { nargs = "+" })

-------------------------------------------------------------------------------
-- NOTE: remove messages from commandine after a set interval
vim.api.nvim_create_autocmd("CmdlineLeave", {
    callback = function()
        vim.defer_fn(function()
            vim.cmd("echo ''")
        end, 3000)
    end,
})

-------------------------------------------------------------------------------
-- NOTE: disable line numbers and mini indentscope plugin for specific filetypes
vim.api.nvim_create_autocmd("FileType", {
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
