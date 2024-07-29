-- nvim-siicon
-- https://github.com/michaelrommel/nvim-silicon

return {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    config = function()
        local silicon = require("silicon")
        local function get_title()
            return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
        end

        silicon.setup({
            font = "JetBrainsMono Nerd Font Mono=34;Noto Color Emoji=34",
            background = "#7daea3",
            window_title = get_title,
        })
    end,
}
