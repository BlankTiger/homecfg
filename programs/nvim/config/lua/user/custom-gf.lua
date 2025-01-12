local M = {}

function M.filter_windows(windows)
    -- TODO: filter out unnecessary windows like
    -- notification windows, quickfix and other stuff
    return windows
end

function M.map_windows_to_positions(windows)
    local map = {}
    for _, v in ipairs(windows) do
        map[v] = vim.api.nvim_win_get_position(v)
    end
    return map
end

function M.find_win(windows_to_positions, find_win_opts)
    if #windows_to_positions == 1 then
        return nil
    end

    local win = nil
    local leftmost = find_win_opts.leftmost
    if leftmost then
        local min_col = 100000
        for i, v in pairs(windows_to_positions) do
            if v[2] < min_col then
                min_col = v[2]
                win = i
            end
        end
    else
        local max_col = -1
        for i, v in pairs(windows_to_positions) do
            if v[2] > max_col then
                max_col = v[2]
                win = i
            end
        end
    end

    return win
end

local uv = vim.loop

function M.file_exists(filepath)
    return not vim.tbl_isempty(uv.fs_stat(filepath) or {})
end

function M.split_to_file_and_cur_pos(str)
    local file_end_pos = string.find(str, ":")
    if not file_end_pos then
        return { file = str, curpos = nil }
    end

    local file = string.sub(str, 1, file_end_pos - 1)
    local pos = string.sub(str, file_end_pos + 1, #str)
    if pos == "" then
        return { file = file, curpos = nil }
    end
    local delim_idx = string.find(pos, ":")
    local row = -1
    local col = 0
    if delim_idx then
        row = tonumber(string.sub(pos, 1, delim_idx - 1))
        local col_str = string.sub(pos, delim_idx + 1, #pos)
        local col_num = tonumber(string.match(col_str, "%d*"))
        if col_num then
            col = col_num - 1
        end
    else
        row = tonumber(pos)
    end
    local curpos = { row, col }
    return { file = file, curpos = curpos }
end

function M.gf_to_the(left_opts)
    local function open_in_new_split(left)
        local old = vim.opt.splitright
        if left then
            vim.opt.splitright = false
        else
            vim.opt.splitright = true
        end
        vim.api.nvim_command("vs")
        vim.opt.splitright = old
        vim.cmd.normal("gF")
    end

    local open_wins = vim.api.nvim_tabpage_list_wins(0)
    open_wins = M.filter_windows(open_wins)
    local is_left = left_opts.left
    if #open_wins == 1 then
        -- open a new one to the left/right
        open_in_new_split(is_left)
    else
        -- find the nearest window to the left/right and open the file in that window
        -- if curr_win is the leftmost/rightmost window, open a new split
        local window_positions = M.map_windows_to_positions(open_wins)
        local left_or_right_most_win = M.find_win(window_positions, { leftmost = is_left })
        if left_or_right_most_win then
            local word_under_cursor = vim.fn.expand("<cWORD>")
            local split = M.split_to_file_and_cur_pos(word_under_cursor)
            vim.api.nvim_win_call(left_or_right_most_win, function()
                if M.file_exists(split.file) then
                    vim.api.nvim_command("edit " .. split.file)
                    if split.curpos then
                        vim.api.nvim_win_set_cursor(left_or_right_most_win, split.curpos)
                    end
                end
            end)
            vim.api.nvim_tabpage_set_win(0, left_or_right_most_win)
        else
            open_in_new_split(is_left)
        end
    end
end

return M
