-- nvim-siicon
-- https://github.com/michaelrommel/nvim-silicon
-- dependencies:
-- nerdfont defined in the config
-- the silicon binary installed and available in the path
-- https://github.com/Aloxaf/silicon
-- TODO: add a check and install using my ansible role

return {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    config = function()
        local silicon = require("nvim-silicon")
        local function get_title()
            return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
        end

        local custom_output = function()
            local img_dir = vim.fn.expand("~/Pictures/Screenshots/silicon-screenshots")
            vim.fn.mkdir(img_dir, "p")

            local timestamp = os.date("!%Y-%m-%dT%H-%M-%SZ")
            local filename = timestamp .. "_code.png"
            local new_path = img_dir .. "/" .. filename
            return new_path
        end

        silicon.setup({
            font = "JetBrainsMono Nerd Font Mono=34;Noto Color Emoji=34",
            background = "#7daea3",
            window_title = get_title,
            to_clipboard = true,
            output = custom_output,
        })
    end,
}
