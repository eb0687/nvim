vim.opt_local.tabstop = 4 -- Show tabs as 4 spaces
vim.opt_local.shiftwidth = 4 -- Indent by 4 spaces
vim.opt_local.softtabstop = 4 -- Pressing tab inserts 4 spaces
vim.opt_local.expandtab = true -- Convert tabs to spaces

-- Utils

local function notify(msg, level)
    vim.notify(msg, level or vim.log.levels.INFO)
end

local function run_cmd(cmd, opts)
    opts = opts or {}
    local on_exit = opts.on_exit or function() end
    local cwd = opts.cwd or vim.fn.getcwd()

    vim.system(cmd, { text = true, cwd = cwd }, function(result)
        vim.schedule(function()
            on_exit(result)
        end)
    end)
end

local function get_crate_root()
    local filepath = vim.api.nvim_buf_get_name(0)
    local dir = vim.fn.fnamemodify(filepath, ":h")
    while dir ~= "/" do
        if vim.fn.filereadable(dir .. "/Cargo.toml") == 1 then
            return dir
        end
        dir = vim.fn.fnamemodify(dir, ":h")
    end
    return vim.fn.getcwd()
end

-- Commands

-- CargoBuild: cargo build
vim.api.nvim_buf_create_user_command(0, "CargoBuild", function(opts)
    local args = opts.args ~= "" and opts.args or ""
    local cmd_str = "cargo build " .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "cargo build" })

-- CargoBuildRelease: cargo build --release
vim.api.nvim_buf_create_user_command(0, "CargoBuildRelease", function()
    vim.cmd("split | terminal cargo build --release")
end, { desc = "cargo build --release" })

-- CargoRun: cargo run
vim.api.nvim_buf_create_user_command(0, "CargoRun", function(opts)
    local args = opts.args ~= "" and " -- " .. opts.args or ""
    local cmd_str = "cargo run" .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "cargo run" })

-- CargoRunRelease: cargo run --release
vim.api.nvim_buf_create_user_command(0, "CargoRunRelease", function(opts)
    local args = opts.args ~= "" and " -- " .. opts.args or ""
    local cmd_str = "cargo run --release" .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "cargo run --release" })
