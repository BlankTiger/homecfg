_G.MyQuickfixtextfunc = function(info)
    local qflist = vim.fn.getqflist({ all = 0 })

    local result = {}
    for i = info.start_idx, info.end_idx do
        local item = qflist.items[i]
        if item.valid == 1 then
            local filename = vim.api.nvim_buf_get_name(item.bufnr)
            table.insert(result, "" .. filename .. ":" .. item.lnum .. ":" .. item.col .. " ->" .. item.text)
        else
            table.insert(result, item.text)
        end
    end

    return result
end

vim.o.quickfixtextfunc = "v:lua.MyQuickfixtextfunc"
