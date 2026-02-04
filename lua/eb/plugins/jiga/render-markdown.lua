return {
    -- NOTE: for configuration options refer to this link:
    -- https://github.com/MeanderingProgrammer/render-markdown.nvim/wiki
    "MeanderingProgrammer/render-markdown.nvim",
    event = "VeryLazy",
    opts = {
        file_types = {
            "markdown",
            "Avante",
        },
        render_modes = {
            "n",
            "c",
            "t",
        },
        completions = {
            blink = {
                enabled = true,
            },
            lsp = {
                enabled = true,
            },
        },
        heading = {
            position = "right",
            width = "block",
            right_pad = 2,
        },
        latex = {
            enabled = false,
        },
    },
    ft = {
        "markdown",
        "Avante",
    },
}
