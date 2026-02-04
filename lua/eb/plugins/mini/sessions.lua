-- MINI SESSIONS
local M = {}

function M.setup()
    local MiniSessions = require("mini.sessions")
    local custom_helpers = require("eb.utils.custom_helpers")

    MiniSessions.setup({})

    local session_name = custom_helpers.get_project_name()

    local keymap = function(keys, func, desc)
        if desc then
            desc = "MINI: " .. desc
        end

        vim.keymap.set("n", keys, func, { desc = desc })
    end

    keymap("<leader>ws", function()
        MiniSessions.write(session_name)
        vim.notify("Session saved: " .. session_name)
    end, "Write a session")

    keymap("<leader>wr", function()
        MiniSessions.read()
    end, "Read and restore a session")

    keymap("<leader>wl", function()
        MiniSessions.select()
    end, "Select from a list of sessions")

    keymap("<leader>wd", function()
        local session_dir = vim.fn.stdpath("data") .. "/session"
        local files = vim.fn.glob(session_dir .. "/*", false, true)

        if vim.tbl_isempty(files) then
            vim.notify("No sessions found in " .. session_dir, vim.log.levels.WARN)
            return
        end

        local sessions = vim.tbl_map(function(path)
            return vim.fn.fnamemodify(path, ":t")
        end, files)

        vim.ui.select(sessions, { prompt = "Delete which session?" }, function(choice)
            if choice then
                MiniSessions.delete(choice, { force = true })
                vim.notify("Deleted session: " .. choice)
            end
        end)
    end, "Select from a list of sessions")
end

return M
