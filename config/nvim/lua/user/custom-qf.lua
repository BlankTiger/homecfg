local function get_relative_path(absolute_path)
    return vim.fn.fnamemodify(absolute_path, ":~:.")
end

_G.MyQuickfixtextfunc = function(info)
    local qflist
    if info.quickfix == 1 then
        qflist = vim.fn.getqflist({ all = 0 })
    else
        qflist = vim.fn.getloclist(info.winid or 0, { all = 0 })
    end

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
                local text = item.text
                if info.quickfix ~= 1 then
                    text = text:gsub("^||%s*", "")
                end
                table.insert(result, text)
            else
                table.insert(result, " ")
            end
        end
    end

    return result
end

vim.o.quickfixtextfunc = "v:lua.MyQuickfixtextfunc"
