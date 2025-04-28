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
