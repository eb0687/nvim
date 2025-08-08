-- NOTE: this requires installation of tatum to work
-- SOURCE: https://github.com/elijah-potter/tatum
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "markdown",
--     callback = function()
--         vim.api.nvim_buf_create_user_command(0, "MarkdownPreview", function()
--             vim.fn.jobstart({ "tatum", "serve", "--open", vim.fn.expand("%") }, {
--                 detach = true,
--             })
--         end, {})
--     end,
-- })

-- Table to keep track of job IDs per buffer
local markdown_preview_jobs = {}

-- Set up for markdown files only
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        -- Create the user command :MarkdownPreview for this buffer
        vim.api.nvim_buf_create_user_command(0, "MarkdownPreview", function()
            local bufnr = vim.api.nvim_get_current_buf()

            -- Prevent multiple previews for the same buffer
            if markdown_preview_jobs[bufnr] ~= nil then
                vim.notify("Markdown preview already running for this buffer", vim.log.levels.INFO)
                return
            end

            -- Start the preview process
            local job_id = vim.fn.jobstart({ "tatum", "serve", "--open", vim.fn.expand("%") }, {
                detach = true,
            })

            if job_id <= 0 then
                vim.notify("Failed to start Markdown preview", vim.log.levels.ERROR)
            else
                markdown_preview_jobs[bufnr] = job_id
                vim.notify("Markdown preview started", vim.log.levels.INFO)

                -- Auto-stop the process when this buffer is unloaded
                vim.api.nvim_create_autocmd("BufUnload", {
                    buffer = bufnr,
                    once = true,
                    callback = function()
                        local job = markdown_preview_jobs[bufnr]
                        if job then
                            vim.fn.jobstop(job)
                            markdown_preview_jobs[bufnr] = nil
                            vim.notify("Markdown preview stopped (buffer closed)", vim.log.levels.INFO)
                        end
                    end,
                })
            end
        end, {})
    end,
})
