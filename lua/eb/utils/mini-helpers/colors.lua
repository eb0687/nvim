local colors = {
    fg1 = "#282828",
    color2 = "#504945",
    fg2 = "#ddc7a1",
    bg = "#1D2021",
    color3 = "#32302f",
    color4 = "#a89984",
    color5 = "#7daea3",
    color6 = "#a9b665",
    color7 = "#d8a657",
    color8 = "#d3869b",
    color9 = "#ea6962",
}

return {
    main = {
        italic = { fg = colors.color4, bg = colors.bg, italic = true },
        bold = { fg = colors.color4, bg = colors.bg, bold = true },
        normal = { fg = colors.color4, bg = colors.bg },
    },
    filename = {
        modified = { fg = colors.color6, bg = colors.bg, italic = true },
        read_only = { fg = colors.color9, bg = colors.bg },
        normal = { fg = colors.color4, bg = colors.bg },
    },
    permissions = {
        read_only = { bg = colors.bg, fg = colors.color9 },
        executable = { bg = colors.bg, fg = colors.color8 },
        modifiable = { bg = colors.bg, fg = colors.color7 },
    },
    diff = {
        added = { bg = colors.bg, fg = colors.color6 },
        changed = { bg = colors.bg, fg = colors.color5 },
        removed = { bg = colors.bg, fg = colors.color9 },
    },
    quickfix = {
        icon = { bg = colors.bg, fg = colors.color8 },
        count = { bg = colors.bg, fg = colors.color4 },
    },
    diagnostics = {
        warn = { bg = colors.bg, fg = colors.color7 },
        error = { bg = colors.bg, fg = colors.color9 },
    },
    git = { fg = colors.color5, bg = colors.bg },
    macro = { fg = colors.color9, bg = colors.bg },
    lsp = { fg = colors.color5, bg = colors.bg },
    location = { fg = colors.color2, bg = colors.bg },
    lazy = { fg = colors.color6, bg = colors.bg },
}
