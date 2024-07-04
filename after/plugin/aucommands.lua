-- NOTE: https://github.com/neovim/neovim/pull/15959
-- TESTING:
local user_command = vim.api.nvim_create_user_command
local input = vim.ui.input

local user_prompt = function()
    input({
        prompt = "Please enter some information: ",
        default = "this is a test",
    }, function(result)
        vim.notify(result)
    end)
end

user_command("HelloWorld", user_prompt, {
    desc = "this a hello world user command test",
})

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
