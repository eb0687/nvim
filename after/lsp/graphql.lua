-- SOURCE: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#graphql
-- NOTE:
-- temporary fix for  graphql lsp
-- SOURCE: https://www.reddit.com/r/neovim/comments/1dfpp3m/for_anyone_whos_trying_to_get_graphql_ls_working/
-- SOURCE: https://github.com/graphql/graphiql/issues/3538

return {
    cmd = { "graphql-lsp", "server", "-m", "stream" },
    -- TODO: need to test this
    root_dir = vim.fs.dirname(vim.fs.find({
        ".graphqlrc",
        ".graphql.config.*",
        "graphql.config.*",
    }, { upward = true })[1]),
}
