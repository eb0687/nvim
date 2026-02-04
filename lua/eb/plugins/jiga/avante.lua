return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    dependencies = {
        -- "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        {
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
        },
    },
    build = "make",
    opts = {
        provider = "copilot",
        hints = {
            enabled = true,
        },
        windows = {
            width = 40,
            sidebar_header = {
                align = "left",
            },
        },
    },
}
