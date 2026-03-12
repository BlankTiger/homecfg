local function get_relative_path(absolute_path)
    return vim.fn.fnamemodify(absolute_path, ":~:.")
end

_G.MyQuickfixtextfunc = function(info)
    local qflist = vim.fn.getqflist({ all = 0 })

    local result = {}
    for i = info.start_idx, info.end_idx do
        local item = qflist.items[i]
        if item.valid == 1 then
            local filename = vim.api.nvim_buf_get_name(item.bufnr)
            local rel_filename = get_relative_path(filename)
            table.insert(
                result,
                "" .. rel_filename .. ":" .. item.lnum .. ":" .. item.col .. " -> " .. item.text
            )
        else
            if #item.text > 0 then
                table.insert(result, item.text)
            else
                table.insert(result, " ")
            end
        end
    end

    return result
end

vim.o.quickfixtextfunc = "v:lua.MyQuickfixtextfunc"
