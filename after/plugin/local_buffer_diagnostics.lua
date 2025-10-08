local function get_local_diagnostics()
    local diags = vim.diagnostic.get(0) -- get diagnostics for current buffer
    -- vim.diagnostic.setqflist({ open = true }, 0) -- optional: send them to quickfix

    -- -- or manually:
    vim.fn.setqflist(vim.diagnostic.toqflist(diags))
    vim.cmd("copen")
end

vim.api.nvim_create_user_command(
    "GetLocalDiagnostics",
    get_local_diagnostics,
    { desc = "Get diagnostics in current buffer" }
)
