-- Rainbow delimeters

-- This module contains a number of default definitions
local rainbow_delimiters = require 'rainbow-delimiters'

vim.g.rainbow_delimiters = {
    strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        commonlisp = rainbow_delimiters.strategy['local'],
    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
    },
    blacklist = { 'c', 'cpp' },
}

-- NOTE: Custom colors for delimeters
local cmd = vim.cmd
cmd([[
    highlight RainbowDelimiterRed guifg = #ea6962
    highlight RainbowDelimiterYellow guifg = #d8a657
    highlight RainbowDelimiterBlue guifg = #89b482
    highlight RainbowDelimiterOrange guifg = #e78a4e
    highlight RainbowDelimiterGreen guifg = #e9b413
    highlight RainbowDelimiterViolet guifg = #7daea3
    highlight RainbowDelimiterCyan guifg = #dfbf8e
]])
