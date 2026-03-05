return {
    "pogyomo/submode.nvim",
    config = function()
        local submode = require("submode")
        local statusline_colors = require("eb.utils.mini-helpers.colors")

        submode.create("SplitResize", {
            mode = "n",
            enter = "<Space>r",
            leave = { "<Esc>", "q" },
            hook = {
                on_enter = function()
                    vim.notify(
                        "Use { h, j, k, l } to reize split or { <Left>, <Down>, <Up>, <Right> } to move the window"
                    )
                    vim.api.nvim_set_hl(0, "MiniStatuslineFilename", statusline_colors.submode_r.submode_on)
                    vim.cmd("redrawstatus")
                end,
                on_leave = function()
                    vim.notify("Exited ResizeMode")
                    vim.api.nvim_set_hl(0, "MiniStatuslineFilename", statusline_colors.submode_r.submode_off)
                    vim.cmd("redrawstatus")
                end,
            },
            default = function(register)
                register("h", "<Cmd>vertical resize +3<CR>", { desc = "Resize left" })
                register("l", "<Cmd>vertical resize -3<CR>", { desc = "Resize right" })
                register("j", "<Cmd>resize +3<CR>", { desc = "Resize up" })
                register("k", "<Cmd>resize -3<CR>", { desc = "Resize down" })
                register("<Left>", "<C-w>H", { desc = "Move window to left" })
                register("<Right>", "<C-w>L", { desc = "Move window to right" })
                register("<Up>", "<C-w>K", { desc = "Move window to right" })
                register("<Down>", "<C-w>J", { desc = "Move window to right" })
            end,
        })
    end,
}
