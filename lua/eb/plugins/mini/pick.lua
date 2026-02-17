-- MINI PICK

local M = {}

function M.setup()
    local pick = require("mini.pick")
    local extra = require("mini.extra")
    local custom_helpers = require("eb.utils.custom_helpers")
    local hostname = custom_helpers.get_hostname()

    extra.setup()
    pick.setup({
        mappings = {
            choose_marked = "<C-q>",
            mark = "<C-a>",
            mark_all = "<C-x>",
            move_up = "<C-k>",
            move_down = "<C-j>",
            scroll_up = "<C-u>",
            scroll_down = "<C-d>",
            toggle_preview = "<C-p>",
        },
        options = {
            content_from_bottom = false,
            use_cache = false,
        },
        window = {
            config = {
                width = 100,
                height = 20,
                border = "bold",
            },
        },
    })

    vim.ui.select = pick.ui_select

    -- Custom find_files
    local load_temp_rg = function(f)
        local rg_env = "RIPGREP_CONFIG_PATH"
        local cached_rg_config = vim.uv.os_getenv(rg_env) or ""
        vim.uv.os_setenv(rg_env, vim.fn.stdpath("config") .. "/.rg")
        f()
        vim.uv.os_setenv(rg_env, cached_rg_config)
    end

    pick.registry.find_files = function()
        load_temp_rg(function()
            pick.builtin.files({ tool = "rg" })
        end)
    end

    pick.registry.find_home = function()
        load_temp_rg(function()
            pick.builtin.files({ tool = "rg" }, { source = { cwd = "~/" } })
        end)
    end

    pick.registry.grep_live_smartcase = function()
        load_temp_rg(function()
            pick.builtin.grep_live({ tool = "rg" })
        end)
    end

    -- SOURCE: https://github.com/echasnovski/mini.nvim/discussions/1926
    pick.registry.command_history = function()
        local edit_command = function()
            local match = pick.get_picker_matches()
            if not match then
                return
            end
            local value = type(match.current) == "table" and match.current.value or tostring(match.current)
            value = value:gsub("^:+", "")
            pick.stop()
            vim.schedule(function()
                local cmd = ":" .. value
                local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
                vim.api.nvim_feedkeys(keys, "n", false)
            end)
            return true
        end
        local opts = {
            mappings = {
                edit_command = {
                    char = "<C-e>",
                    func = edit_command,
                },
            },
        }
        extra.pickers.history({ scope = ":" }, opts)
    end

    local reboot_projects_dir = ""
    local obsidian_vault = ""
    local dotfiles_bare_dir = ""
    if hostname == "JIGA" then
        reboot_projects_dir = "~/reboot/"
        obsidian_vault = "/mnt/d/the_vault/"
        dotfiles_bare_dir = "$HOME/.dotfiles"
    elseif hostname == "eb-t490" then
        reboot_projects_dir = "~/scripts/reboot/"
        obsidian_vault = "~/Documents/the_vault"
        dotfiles_bare_dir = "$HOME/.cfg"
    end

    pick.registry.configs = function()
        local cwd = vim.fn.expand("$HOME/.config")
        local choose = function(item)
            vim.schedule(function()
                pick.builtin.files(nil, { source = { cwd = item.path } })
            end)
        end
        return extra.pickers.explorer({ cwd = cwd }, { source = { choose = choose } })
    end

    pick.registry.reboot_projects = function()
        local cwd = vim.fn.expand(reboot_projects_dir)
        local choose = function(item)
            vim.schedule(function()
                pick.builtin.files(nil, { source = { cwd = item.path } })
            end)
        end
        return extra.pickers.explorer({ cwd = cwd }, { source = { choose = choose } })
    end

    pick.registry.find_obsidian = function()
        load_temp_rg(function()
            pick.builtin.files({ tool = "rg" }, { source = { cwd = obsidian_vault } })
        end)
    end

    pick.registry.grep_obsidian = function()
        load_temp_rg(function()
            pick.builtin.grep({ tool = "rg" }, { source = { cwd = obsidian_vault } })
        end)
    end

    pick.registry.dotfiles = function()
        local git_dir = vim.fn.expand(dotfiles_bare_dir)
        local work_tree = vim.fn.expand("$HOME")

        if vim.fn.isdirectory(git_dir) == 0 then
            vim.notify("Git directory does not exist: " .. git_dir, vim.log.levels.WARN)
            return
        end

        local items = vim.fn.systemlist({
            "git",
            "--git-dir=" .. git_dir,
            "-C",
            work_tree,
            "ls-files",
        })

        vim.schedule(function()
            pick.start({
                source = {
                    items = vim.tbl_map(function(item)
                        return work_tree .. "/" .. item
                    end, items),
                    name = "Dotfiles",
                },
            })
        end)
    end

    local keymap = function(keys, func, desc)
        if desc then
            desc = "MINI: " .. desc
        end

        vim.keymap.set("n", keys, func, { desc = desc })
    end

    -- helper command to invoke smart pick
    vim.api.nvim_create_user_command("SmartPick", function()
        require("eb.utils.smart-pick").setup()
        require("eb.utils.smart-pick").picker()
    end, {})

    -- keymap("<leader>ff", ":Pick find_files<CR>", "Find files")
    keymap("<leader>fh", ":Pick help<CR>", "Find help")
    -- keymap("<leader>fb", ":Pick buffers<CR>", "Find open buffers")
    keymap("<leader>ff", function()
        require("eb.utils.smart-pick").setup()
        require("eb.utils.smart-pick").picker()
    end, "SmartPick")
    keymap("<leader>fk", ":Pick keymaps<CR>", "Find keymaps")
    keymap("<leader>fo", ":Pick oldfiles<CR>", "Find old files")
    keymap("<leader>fm", ":Pick marks<CR>", "Find marks")
    keymap("<leader>fg", ":Pick git_files<CR>", "Find files in current git repository")
    keymap("<leader>fe", ":Pick git_files scope='modified'<CR>", "Find modified git files")
    keymap("<leader>fss", ":Pick grep_live_smartcase<CR>", "Grep live search (smartcase)")
    keymap("<leader>fsu", ":Pick commands<CR>", "Find search user commands")
    keymap("<leader>fsw", function()
        require("mini.pick").builtin.grep({
            globs = { vim.fn.expand("%:t") },
            pattern = vim.fn.expand("<cword>"),
        })
    end, "Find search word under cursor (current buffer only)")
    keymap("<leader>fsW", ":Pick grep pattern='<cword>'<CR>", "Find search word under cursor")
    keymap("<leader>fch", ":Pick command_history<CR>", "Find command history")
    keymap("<leader>fsh", ":Pick history scope='/'<CR>", "Find search history")
    keymap("<leader>fsf", ":Pick visit_paths<CR>", "Find recently visited files")
    keymap("<leader>fS", ":Pick spellsuggest<CR>", "Spell suggetions")
    keymap("<leader>fsy", ":Pick lsp scope='document_symbol'<CR>", "Document symbols")
    keymap(
        "<leader>fsd",
        ":Pick diagnostic scope='current' sort_by='severity'<CR>",
        "Find search diagnostic in current buffer"
    )
    keymap(
        "<leader>fsD",
        ":Pick diagnostic scope='all' sort_by='severity'<CR>",
        "Find search diagnostic in all buffers"
    )
    keymap("<leader>fsb", ":Pick buf_lines scope='current' preserve_order=true<CR>", "Find search buffer")
    keymap("<leader>fst", ":Pick hipatterns<CR>", "Find search hipatterns")
    keymap("<leader>fsr", ":Pick registers<CR>", "Find search registers")
    keymap("<leader>fF", ":Pick find_home<CR>", "Find file from home directory")
    keymap("<leader>co", ":Pick list scope='quickfix'<CR>", "Find all items in quickfix list")
    keymap("<leader>os", ":Pick find_obsidian<CR>", "Find in obsidian vault")
    keymap("<leader>oz", ":Pick grep_obsidian<CR>", "Grep in obsidian vault")
    keymap("<leader>fn", function()
        pick.builtin.files(nil, { source = { cwd = vim.fn.stdpath("config") } })
    end, "Find file in nvim config")
end

return M
