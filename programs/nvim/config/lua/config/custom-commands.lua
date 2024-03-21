vim.api.nvim_create_user_command("ParseCreatedIssues", function(opts)
    vim.cmd([[%v/Created issue/s/.*//]])
    vim.cmd([[%s/^\n//]])
    vim.cmd([[%s/.*browse\//]])
    vim.cmd([[%s/.*/'\0',]])
    vim.cmd([[norm Gdd$xa)ggIkey in (]])
end, {})

vim.api.nvim_create_user_command("TermToggle", function()
    local is_open = vim.g.term_win_id ~= nil and vim.api.nvim_win_is_valid(vim.g.term_win_id)
    if vim.g.term_win_height == nil then
        vim.g.term_win_height = 8
    end

    if is_open then
        vim.g.term_win_height = vim.api.nvim_win_get_height(vim.g.term_win_id)
        vim.api.nvim_win_hide(vim.g.term_win_id)
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
