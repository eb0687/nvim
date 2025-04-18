-- markdown preview
-- https://github.com/iamcco/markdown-preview.nvim

return {
    "iamcco/markdown-preview.nvim",
    enabled = false,
    ft = "markdown",
    build = function()
        vim.fn["mkdp#util#install"]()
    end,
    cmd = {
        "MarkdownPreviewToggle",
        "MarkdownPreview",
        "MarkdownPreviewStop",
    },
}
