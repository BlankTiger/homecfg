vim.api.nvim_create_user_command("ParseCreatedIssues", function(opts)
    vim.cmd([[%v/Created issue/s/.*//]])
    vim.cmd([[%s/^\n//]])
    vim.cmd([[%s/.*browse\//]])
    vim.cmd([[%s/.*/'\0',]])
    vim.cmd([[norm Gdd$xa)ggIkey in (]])
end, {})

vim.api.nvim_create_user_command("Rg", function(opts)
    local function highlight(text)
        if string.find(text, "--vimgrep") == nil then
            return {}
        end

        local first_space, _ = string.find(text, " ")
        local highlight_groups = {
            { 0, first_space - 1, "Directory" },
            { first_space, string.len(text), "Question" },
        }
        return highlight_groups
    end

    local function on_confirm(input)
        if input == nil or input == "rg --vimgrep " then
            return
        end

        local cmd = "cexpr system('" .. input .. "') | copen"
        vim.api.nvim_command(cmd)
    end

    vim.ui.input({
        prompt = "",
        default = "rg --vimgrep ",
        completion = "shellcmd",
        highlight = highlight,
    }, on_confirm)
end, {})

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

vim.g.mk = "make"
vim.api.nvim_create_user_command("Make", function()
    local cmd_check_tmux_win_open = "tmux list-windows -F '#{window_name}'"
    local res = vim.fn.system(cmd_check_tmux_win_open)
    local is_tmux_win_open = res:find("make") ~= nil

    if is_tmux_win_open then
        local cmd = 'silent !tmux send-keys -t ":9" "'
            .. vim.g.mk
            .. '" Enter;tmux select-window -t ":9"'
        vim.api.nvim_command(cmd)
        return
    else
        local cmd = "silent !tmux new-window -n 'make' -t 9 '"
            .. vim.g.mk
            .. ";/usr/bin/env $SHELL'"
        vim.api.nvim_command(cmd)
    end
end, {})

vim.api.nvim_create_user_command("AsyncMake", function()
    local lines = { "" }
    local winnr = vim.fn.win_getid()
    local bufnr = vim.api.nvim_win_get_buf(winnr)

    local makeprg = vim.api.nvim_get_option_value("makeprg", {
        -- buf = bufnr
    })
    if not makeprg then
        return
    end

    local cmd = vim.fn.expandcmd(makeprg)

    local function on_event(job_id, data, event)
        if event == "stdout" or event == "stderr" then
            local msg = ""
            for _, v in pairs(data) do
                msg = msg .. v .. "\n"
            end
            vim.notify(event .. ": " .. msg)
            if data then
                vim.list_extend(lines, data)
            end
        end

        if event == "exit" then
            vim.fn.setqflist({}, " ", {
                title = cmd,
                lines = lines,
                efm = vim.api.nvim_get_option_value("errorformat", {
                    -- buf = bufnr
                }),
            })
            vim.api.nvim_command("doautocmd QuickFixCmdPost")
        end
    end

    vim.fn.jobstart(cmd, {
        on_stderr = on_event,
        on_stdout = on_event,
        on_exit = on_event,
        stdout_buffered = true,
        stderr_buffered = true,
    })
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
