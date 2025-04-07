-- https://github.com/rachartier/tiny-inline-diagnostic.nvim

-- NOTE: nvim 0.11 improved their inline diagnostic mayb have a look at it?
return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
        require("tiny-inline-diagnostic").setup({
            preset = "nonerdfont",
            break_line = {
                enabled = true,
                after = 30,
            },
            options = {
                show_source = true,
                multilines = true,
                overflow = {
                    -- Manage the overflow of the message.
                    --    - wrap: when the message is too long, it is then displayed on multiple lines.
                    --    - none: the message will not be truncated.
                    --    - oneline: message will be displayed entirely on one line.
                    mode = "wrap",
                },
            },
        })
    end,
}
