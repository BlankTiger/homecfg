local M = {}

local namespace = vim.api.nvim_create_namespace("todo_comment_highlight")
local todo_pattern = "@(%w+)"

local function is_comment(buffer, line, column)
    for _, syntax_id in ipairs(vim.fn.synstack(line, column)) do
        local syntax_name = vim.fn.synIDattr(vim.fn.synIDtrans(syntax_id), "name")
        if syntax_name == "Comment" or syntax_name:find("comment", 1, true) then
            return true
        end
    end

    local ok, captures = pcall(vim.treesitter.get_captures_at_pos, buffer, line - 1, column - 1)
    if ok then
        for _, capture in ipairs(captures) do
            if capture.capture == "comment" or capture.capture:match("%.comment$") then
                return true
            end
        end
    end

    return false
end

local function highlight_buffer(buffer)
    if not vim.api.nvim_buf_is_valid(buffer) then
        return
    end

    vim.api.nvim_buf_clear_namespace(buffer, namespace, 0, -1)

    pcall(function()
        vim.treesitter.get_parser(buffer):parse()
    end)

    local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
    for line_number, line in ipairs(lines) do
        local start = 1
        while true do
            local match_start, match_end, note = line:find(todo_pattern, start)
            if not match_start then
                break
            end

            local parenthesized
            if line:sub(match_end + 1, match_end + 1) == "(" then
                local parenthesized_start, parenthesized_end = line:find("^%(([^()]*)%)", match_end + 1)
                if parenthesized_start then
                    parenthesized = line:sub(parenthesized_start, parenthesized_end)
                    match_end = parenthesized_end
                end
            end

            if is_comment(buffer, line_number, match_start) then
                vim.api.nvim_buf_set_extmark(buffer, namespace, line_number - 1, match_start - 1, {
                    end_col = parenthesized and match_end or match_start + #note,
                    hl_group = "Todo",
                    priority = 200,
                })

            end

            start = match_end + 1
        end
    end
end

local function refresh(buffer)
    vim.schedule(function()
        highlight_buffer(buffer)
    end)
end

local function attach(buffer)
    if vim.b[buffer].todo_highlight_attached then
        return
    end

    vim.b[buffer].todo_highlight_attached = true
    vim.api.nvim_buf_attach(buffer, false, {
        on_lines = function(_, _, _, _, _, _, _)
            refresh(buffer)
        end,
        on_detach = function()
            vim.b[buffer].todo_highlight_attached = nil
        end,
    })

    refresh(buffer)
end

function M.setup()
    vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
        group = vim.api.nvim_create_augroup("todo_comment_highlight", { clear = true }),
        callback = function(args)
            attach(args.buf)
        end,
    })

    attach(vim.api.nvim_get_current_buf())
end

return M
