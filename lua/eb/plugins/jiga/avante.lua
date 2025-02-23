return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        {
            -- NOTE: for configuration options refer to this link:
            -- https://github.com/MeanderingProgrammer/render-markdown.nvim/wiki
            "MeanderingProgrammer/render-markdown.nvim",
            event = "VeryLazy",
            opts = { file_types = { "markdown", "Avante" } },
            ft = { "markdown", "Avante" },
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
        },
    },
}
