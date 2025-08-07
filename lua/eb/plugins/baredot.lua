-- baredot
-- https://github.com/ejrichards/baredot.nvim

return {
    "ejrichards/baredot.nvim",

    config = function()
        local baredot = require("baredot")

        -- TODO: probably update this for compatibility with my vms on proxmox

        -- TODO: probably move this to a utils folder
        local function directory_exists(path)
            ---@diagnostic disable-next-line: undefined-field
            local stat = vim.loop.fs_stat(path)
            return stat and stat.type == "directory" or false
        end

        local git_dir = function()
            local result = ""
            if vim.fn.hostname() == "JIGA" then
                result = "~/.dotfiles"
            elseif vim.fn.hostname() == "eb-t490" then
                result = "~/.cfg"
            else
                local dotfiles_path = vim.fn.expand("~/.dotfiles")
                if directory_exists(dotfiles_path) then
                    result = dotfiles_path
                else
                    print(dotfiles_path .. " does not exist!")
                end
            end
            return result
        end

        baredot.setup({
            git_dir = git_dir(),
            git_work_tree = "~",
            disable_pattern = "%.git",
        })
    end,
}
