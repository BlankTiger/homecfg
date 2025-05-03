vim.api.nvim_create_user_command("TermToggle", function()
    local is_open = vim.g.term_win_id ~= nil and vim.api.nvim_win_is_valid(vim.g.term_win_id)
    if vim.g.term_win_height == nil then
        vim.g.term_win_height = 18
    end

    local dir = nil
    if not is_open then
        local cur_buf = vim.api.nvim_get_current_buf()
        local cur_bufname = vim.api.nvim_buf_get_name(cur_buf)
        if cur_bufname:find("oil:///") then
            dir = cur_bufname:sub(7, -1)
        end
    end

    if is_open then
        vim.g.term_win_height = vim.api.nvim_win_get_height(vim.g.term_win_id)
        pcall(vim.api.nvim_win_hide, vim.g.term_win_id)
        vim.g.term_win_id = nil
        return
    end

    vim.cmd("botright " .. vim.g.term_win_height .. " new")
    vim.g.term_win_id = vim.api.nvim_get_current_win()

    local has_term_buf = vim.g.term_buf_id ~= nil and vim.api.nvim_buf_is_valid(vim.g.term_buf_id)

    if has_term_buf then
        vim.api.nvim_win_set_buf(vim.g.term_win_id, vim.g.term_buf_id)
    else
        vim.cmd.term()
        vim.g.term_buf_id = vim.api.nvim_get_current_buf()
        if dir ~= nil then
            local chan = vim.bo[vim.g.term_buf_id].channel
            vim.fn.chansend(chan, "cd " .. dir .. ";c\n")
        end
    end

    vim.cmd.startinsert()
end, {})

vim.api.nvim_create_user_command("TermKill", function()
    if vim.g.term_win_id ~= nil then
        vim.api.nvim_win_close(vim.g.term_win_id, true)
        vim.g.term_win_id = nil
    end
    if vim.g.term_buf_id ~= nil then
        vim.api.nvim_buf_delete(vim.g.term_buf_id, { force = true })
        vim.g.term_buf_id = nil
    end
end, {})


-- filter quickfix, if file contains search pattern then keep it
vim.api.nvim_create_user_command("Fqf", function(args)
    local aqf = require("aqf")
    aqf.filter_qf_by_query(args.bang)
end, { bang = true })

-- toggle previous quickfix list
vim.api.nvim_create_user_command("Pqf", function()
    local aqf = require("aqf")
    aqf.prev_qf()
end, {})

-- save current quickfix list as previoous quickfix list
vim.api.nvim_create_user_command("Sqf", function()
    local aqf = require("aqf")
    aqf.save_qf()
end, {})

vim.api.nvim_create_user_command("FDisable", function()
    vim.b.disable_autoformat = true
end, { desc = "Disable autoformat on save", bang = true })

vim.api.nvim_create_user_command("FEnable", function()
    vim.g.disable_autoformat = false
end, { desc = "Re-enable autoformat on save" })
