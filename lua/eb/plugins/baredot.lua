-- baredot
-- https://github.com/ejrichards/baredot.nvim

return {
    "ejrichards/baredot.nvim",
    -- opts = {
    --     git_dir = "~/.dotfiles", -- Change this path
    -- },
    config = function()
        local baredot = require("baredot")
        local git_dir = function()
            local result = ""
            if vim.fn.hostname() == "JIGA" then
                result = "~/.dotfiles"
            elseif vim.fn.hostname() == "eb-t490" then
                result = "~/.cfg"
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
