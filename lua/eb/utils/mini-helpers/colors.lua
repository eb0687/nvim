local colors = {
    bg = "#1D2021",
    bg1 = "#282828",
    bg2 = "#504945",

    fg0 = "#ebdbb2",

    red = "#ea6962",
    orange = "#e78a4e",
    yellow = "#d8a657",
    green = "#a9b665",
    aqua = "#89b482",
    blue = "#7daea3",
    purple = "#d3869b",

    grey0 = "#a89984",
    grey1 = "#928374",
    grey2 = "#7c6f64",
}

return {
    main = {
        italic = { fg = colors.grey0, bg = colors.bg, italic = true },
        bold = { fg = colors.grey0, bg = colors.bg, bold = true },
        normal = { fg = colors.grey0, bg = colors.bg },
    },
    filename = {
        modified = { fg = colors.green, bg = colors.bg, italic = true },
        read_only = { fg = colors.red, bg = colors.bg },
        normal = { fg = colors.grey0, bg = colors.bg },
    },
    permissions = {
        read_only = { bg = colors.bg, fg = colors.red },
        executable = { bg = colors.bg, fg = colors.purple },
        modifiable = { bg = colors.bg, fg = colors.yellow },
    },
    diff = {
        added = { bg = colors.bg, fg = colors.green },
        changed = { bg = colors.bg, fg = colors.blue },
        removed = { bg = colors.bg, fg = colors.red },
    },
    quickfix = {
        icon = { bg = colors.bg, fg = colors.purple },
        count = { bg = colors.bg, fg = colors.grey0 },
    },
    diagnostics = {
        warn = { bg = colors.bg, fg = colors.yellow },
        error = { bg = colors.bg, fg = colors.red },
    },
    git = { fg = colors.blue, bg = colors.bg },
    macro = { fg = colors.red, bg = colors.bg },
    lsp = { fg = colors.blue, bg = colors.bg },
    location = { fg = colors.grey0, bg = colors.bg },
    lazy = { fg = colors.green, bg = colors.bg },
    buffer_count = { bg = colors.bg, fg = colors.green },
    qf = {
        icon = { bg = colors.bg, fg = colors.purple },
        count = { bg = colors.bg, fg = colors.green },
    },
    count = {
        lines = { bg = colors.bg, fg = colors.green },
        words = { bg = colors.bg, fg = colors.blue },
        chars = { bg = colors.bg, fg = colors.purple },
    },
    submode_r = {
        submode_on = { bg = colors.purple, fg = colors.bg },
        submode_off = { fg = colors.grey0, bg = colors.bg },
    },
}
