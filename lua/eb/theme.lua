local M = {}

local theme_file = vim.fn.expand("~/.config/colorschemes/.current-theme")

function M.apply()
    local ok, lines = pcall(vim.fn.readfile, theme_file)
    local theme = ok and vim.trim(lines[1] or "") or ""
    local scheme = ({
        ["flexoki-dark"] = "flexoki-dark",
        ["catppuccin-macchiato"] = "catppuccin-macchiato",
        ["gruvbox-dark"] = "gruvbox-material",
    })[theme] or "gruvbox-material"

    local loaded, err = pcall(vim.cmd.colorscheme, scheme)
    if not loaded then
        vim.notify(("Could not load colorscheme %q: %s"):format(scheme, err), vim.log.levels.WARN)
        vim.cmd.colorscheme("gruvbox-material")
    end
end

return M
