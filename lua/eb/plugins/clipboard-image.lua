-- clipboard.nvim
-- https://github.com/ekickx/clipboard-image.nvim

-- NOTE: fix for the plugin to work
-- https://github.com/ekickx/clipboard-image.nvim/pull/48

return {
    "ekickx/clipboard-image.nvim",
    ft = "markdown",
    config = function()
        local ci = require("clipboard-image")
        ci.setup({
            default = {
                img_dir = { "%:p:h", "./assets/img" },
                img_dir_txt = "assets/img",
                img_name = function()
                    vim.fn.inputsave()
                    local name = vim.fn.input("Name the image: ")
                    vim.fn.inputrestore()
                    return name:gsub(" ", "-")
                end,
            },
        })
    end,
}
