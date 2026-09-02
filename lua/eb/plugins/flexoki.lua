return {
    "emiara/flexoki.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
        require("flexoki").setup(opts)
        -- vim.cmd.colorscheme("flexoki")
    end,
}
