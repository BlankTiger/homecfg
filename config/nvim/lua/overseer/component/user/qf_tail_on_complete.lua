return {
    desc = "Keep quickfix scrolled to the end when task completes",
    serializable = false,
    constructor = function()
        return {
            on_complete = function()
                vim.schedule(function()
                    local qf = vim.fn.getqflist({ winid = 0 })
                    local winid = qf.winid or 0
                    if winid == 0 then
                        return
                    end

                    local bufnr = vim.api.nvim_win_get_buf(winid)
                    local last_line = vim.api.nvim_buf_line_count(bufnr)
                    vim.api.nvim_win_set_cursor(winid, { last_line, 0 })
                end)
            end,
        }
    end,
}
