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

-- CargoCheck: cargo check
vim.api.nvim_buf_create_user_command(0, "CargoCheck", function()
    notify("Running: cargo check")
    run_cmd({ "cargo", "check", "--message-format=short" }, {
        cwd = get_crate_root(),
        on_exit = function(result)
            if result.code == 0 then
                notify("cargo check: OK")
            else
                notify("cargo check failed:\n" .. (result.stderr or result.stdout), vim.log.levels.WARN)
            end
        end,
    })
end, { desc = "cargo check" })

-- RustDoc: open docs.rs for word under cursor
vim.api.nvim_buf_create_user_command(0, "RustDoc", function(opts)
    local crate = opts.args ~= "" and opts.args or vim.fn.expand("<cword>")
    local url = "https://docs.rs/" .. crate
    local is_wsl = vim.env.WSL_DISTRO_NAME ~= nil and vim.env.WSL_DISTRO_NAME ~= ""
    if is_wsl then
        -- Prefer wslview in WSL
        if vim.fn.executable("wslview") == 1 then
            vim.ui.open(url, { cmd = { "wslview" } })
        else
            -- fallback if wslview is missing
            vim.ui.open(url, { cmd = { "xdg-open" } })
        end
    else
        -- native Linux
        vim.ui.open(url, { cmd = { "xdg-open" } })
    end
    vim.notify("Opening: " .. url)
end, { nargs = "?", desc = "Open docs.rs for crate" })

-- CargoClean: cargo clean
vim.api.nvim_buf_create_user_command(0, "CargoClean", function()
    notify("Running: cargo clean")
    run_cmd({ "cargo", "clean" }, {
        cwd = get_crate_root(),
        on_exit = function(result)
            if result.code == 0 then
                notify("cargo clean: completed")
            else
                notify("cargo clean failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { desc = "cargo clean" })
