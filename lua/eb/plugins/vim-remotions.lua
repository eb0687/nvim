local motions = {
    para = { backward = "{", forward = "}" },
    sentence = { backward = "(", forward = ")" },
    change = { backward = "g,", forward = "g;" },
    class = { backward = "[[", forward = "]]" },
    classend = { backward = "[]", forward = "][" },
    method = { backward = "[m", forward = "]m" },
    methodend = { backward = "[M", forward = "]M" },
    arg = { backward = "[a", forward = "]a" },
    line = { backward = "k", forward = "j", repeat_if_count = 1, repeat_count = 1 },
    char = { backward = "h", forward = "l", repeat_if_count = 1, repeat_count = 1 },
    word = { backward = "b", forward = "w", repeat_if_count = 1, repeat_count = 1 },
    fullword = { backward = "B", forward = "W", repeat_if_count = 1, repeat_count = 1 },
    wordend = { backward = "ge", forward = "e", repeat_if_count = 1, repeat_count = 1 },
    buffer = { backward = "<S-Tab>", forward = "<Tab>" },
    location = { backward = "[l", forward = "]l" },
    quickfix = { backward = "[q", forward = "]q" },
    diagnostic = { backward = "[g", forward = "]g" },
}
return {
    "vds2212/vim-remotions",
    event = { "BufRead", "BufWinEnter", "BufNewFile" },

    config = function()
        vim.g.remotions_motions = motions
    end,
}
