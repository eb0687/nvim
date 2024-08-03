-- baredot
-- https://github.com/ejrichards/baredot.nvim

return {
    "ejrichards/baredot.nvim",

    config = function()
        local baredot = require("baredot")

        -- TODO: probably update this for compatibility with my vms on proxmox
        local git_dir = function()
            local result = ""
            if vim.fn.hostname() == "JIGA" then
                result = "~/.dotfiles"
            elseif vim.fn.hostname() == "eb-t490" then
                result = "~/.cfg"
            else
                result = "~/.dotfiles"
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
