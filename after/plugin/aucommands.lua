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

-- https://github.com/hadynz/dotfiles/blob/main/nvim/lua/config/autocmds.lua

-------------------------------------------------------------------------------
-- NOTE: Toggle relative numbers for active panes only
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "FocusGained" }, {
    callback = function()
        vim.wo.relativenumber = true
    end,
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave", "FocusLost" }, {
    callback = function()
        vim.wo.relativenumber = false
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
-- NOTE: Toggle MiniHiPattern usercommand
vim.api.nvim_create_user_command("ToggleMiniHipatterns", ":lua MiniHipatterns.toggle()", {})

-------------------------------------------------------------------------------
-- NOTE: Global find and replace
-- source: https://elanmed.dev/blog/global-find-and-replace-in-neovim
-- source: https://www.youtube.com/watch?v=9JCsPsdeflY
local utils = require("eb.utils.custom_helpers")
vim.api.nvim_create_user_command("FindAndReplaceGlobal", function(opts)
    if not utils.validate_args(opts.fargs, 2, "Usage: :FindAndReplaceGlobal <search_pattern> <replace_pattern>") then
        return
    end
    vim.api.nvim_command(string.format("cfdo s/%s/%s/g | update | bd", opts.fargs[1], opts.fargs[2]))
    utils.clear_quickfix()
end, { nargs = "*" })

-------------------------------------------------------------------------------
-- NOTE: Toggle autoformat on save
-- source: https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
require("conform").setup({
    format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end
        return { timeout_ms = 500, lsp_format = "fallback" }
    end,
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
    else
        vim.g.disable_autoformat = true
    end
end, {
    desc = "Disable autoformat-on-save",
    bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
end, {
    desc = "Re-enable autoformat-on-save",
})

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

-- vim.api.nvim_create_autocmd("BufWritePost", {
--     pattern = { "*.html", "*.jsx", "*.tsx", "*.css", "*.scss" }, -- Replace with the desired filetypes
--     command = "TailwindSort",
--     desc = "Automatically sort Tailwind classes on save",
-- })

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
-- NOTE: requires cmp
-- source: https://github.com/hrsh7th/nvim-cmp/issues/261
vim.g.cmp_toggle = true
local function toggle_autocomplete()
    vim.g.cmp_toggle = not vim.g.cmp_toggle
    local status

    if vim.g.cmp_toggle then
        status = "ENABLED"
    else
        status = "DISABLED"
    end

    print("Autocomplete", status)
end

vim.api.nvim_create_user_command("ToggleCmp", toggle_autocomplete, {})

-------------------------------------------------------------------------------
-- NOTE: Custom grep
vim.api.nvim_create_user_command("Grep", function(opts)
    local query = opts.args
    if query and query ~= "" then
        vim.cmd("copen")
        vim.cmd("silent grep " .. query)
    else
        print("Usage: :CustomGrep <search_term>")
    end
end, { nargs = "+" })

-------------------------------------------------------------------------------
-- NOTE: Grep word under cursor user command
vim.api.nvim_create_user_command(
    "GrepCursorWord",
    utils.grep_word_under_cursor,
    { desc = "Grep for the word under the cursor and open results in quickfix" }
)

-------------------------------------------------------------------------------
-- NOTE: remove messages from commandine after a set interval
vim.api.nvim_create_autocmd("CmdlineLeave", {
    callback = function()
        vim.defer_fn(function()
            vim.cmd("echo ''")
        end, 3000)
    end,
})
