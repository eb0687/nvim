-- deadcolumn

-- https://github.com/Bekaboo/deadcolumn.nvim
return {
    "Bekaboo/deadcolumn.nvim",
    event = "VeryLazy",
    config = function()
        local opts = {
            scope = "line", ---@type string|fun(): integer
            ---@type string[]|fun(mode: string): boolean
            modes = function(mode)
                return mode:find("^[ictRss\x13]") ~= nil
            end,
            blending = {
                threshold = 0.75,
                colorcode = "#000000",
                hlgroup = { "Normal", "bg" },
            },
            warning = {
                alpha = 0.4,
                offset = 0,
                colorcode = "#ea6962",
                hlgroup = { "Error", "bg" },
            },
            extra = {
                ---@type string?
                follow_tw = nil,
            },
        }

        require("deadcolumn").setup(opts) -- Call the setup function
    end,
}
