return {
    desc = "Keep quickfix scrolled to the end when task completes",
    serializable = false,
    constructor = function()
        return {
            on_complete = function()
                vim.schedule(function()
                    local qf = vim.fn.getqflist({ winid = 0, items = 1 })
                    local winid = qf.winid or 0
                    if winid == 0 then
                        return
                    end

                    local items = qf.items
                    local last_valid = #items

                    while last_valid > 0 and items[last_valid].text:match("^%s*$") do
                        last_valid = last_valid - 1
                    end

                    if last_valid < #items then
                        vim.fn.setqflist({}, "r", { items = vim.list_slice(items, 1, last_valid) })
                    end

                    if last_valid > 0 then
                        local bufnr = vim.api.nvim_win_get_buf(winid)
                        vim.api.nvim_win_set_cursor(winid, { last_valid, 0 })
                    end
                end)
            end,
        }
    end,
}
