-- https://github.com/rachartier/tiny-inline-diagnostic.nvim
return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
        require("tiny-inline-diagnostic").setup({
            overflow = {
                -- Manage the overflow of the message.
                --    - wrap: when the message is too long, it is then displayed on multiple lines.
                --    - none: the message will not be truncated.
                --    - oneline: message will be displayed entirely on one line.
                mode = "wrap",
            },
            break_line = {
                enabled = true,
                after = 30,
            },
        })
    end,
}
