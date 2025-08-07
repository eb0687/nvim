return {
    "brianhuster/live-preview.nvim",
    Lazy = true,
    dependencies = {
        "echasnovski/mini.pick",
    },
    config = function()
        local browser_cmd = vim.env.BROWSER_CMD or "xdg-open"
        require("livepreview.config").set({
            port = 5500,
            browser = browser_cmd,
            dynamic_root = false,
            sync_scroll = true,
            picker = "",
        })
    end,
}
