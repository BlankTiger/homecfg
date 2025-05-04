local autocmd_group = vim.api.nvim_create_augroup("BlankTiger custom autocmds", { clear = true })
local set = vim.keymap.set

-- for easier quitting from the cmdline window q:
vim.api.nvim_create_autocmd({ "CmdwinEnter" }, {
    group = autocmd_group,
    pattern = "*",
    callback = function(args)
        set({ "n", "i" }, "<C-q>", "<C-c><C-c>", { buffer = args.buf })
        set({ "n" }, "q", "<C-c><C-c>", { buffer = args.buf })
    end,
})

-- highlight nocheck/in (the things that prevents commiting stuff with it via hooks)
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    group = autocmd_group,
    pattern = "*",
    callback = function()
        local pat = [[nocheck.n]]
        vim.cmd([[
        highlight Nocheckin guifg=#fe0000
        match Nocheckin /]] .. pat .. [[/]])
    end,
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
    group = autocmd_group,
    pattern = "*",
    callback = function(opts)
        if opts.file:match("dap%-terminal") then
            return
        end
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
        vim.api.nvim_command("startinsert")
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = autocmd_group,
    pattern = "*",
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
    desc = "Remove trailing whitespace on save",
})

-- this enables me to go through all files detemined by the `pat` pattern
-- from the output of a command in a terminal buffer
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = autocmd_group,
    pattern = "*",
    callback = function(opts)
        if vim.bo[opts["buf"]].buftype ~= "terminal" then
            vim.cmd([[highlight clear Files]])
            return
        end

        local pat = [[\(^\|\s\+\)\zs\(\a\|\/\)\w\+\(\(\.\|\/\).\{-}\)\+:\ze\(\s\+\|$\)]]
        vim.cmd([[
        highlight Files gui=undercurl
        match Files /]] .. pat .. [[/]])

        set("n", "<C-S-p>", function()
            vim.fn.search(pat, "b")
        end, { silent = true })
        set("n", "<C-S-n>", function()
            vim.fn.search(pat)
        end, { silent = true })
    end,
})

-- flash yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", {}),
    desc = "Hightlight selection on yank",
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "Search", timeout = 125 })
    end,
})

local remove_invalid_tabpages_from_hist = function(tab_hist)
    local idx_start = #tab_hist
    local idx_stop = 1
    for i = idx_start, idx_stop, -1 do
        if vim.api.nvim_tabpage_is_valid(tab_hist[i]) then
            break
        else
            table.remove(tab_hist, i)
        end
    end
    return tab_hist
end

local remove_curr_tabpage_from_hist = function(tab_hist, tab_curr)
    local idx_start = #tab_hist
    local idx_stop = 1
    for i = idx_start, idx_stop, -1 do
        if tab_hist[i] == tab_curr then
            table.remove(tab_hist, i)
        end
    end
    return tab_hist
end

local tab_hist = { vim.api.nvim_get_current_tabpage() }
-- this makes it so that when I close a tabpage, neovim opens the one that I
-- visited last before the one that was just closed
vim.api.nvim_create_autocmd({ "TabEnter", "TabClosed" }, {
    group = autocmd_group,
    desc = "switch to previously open tab when closing another one",
    pattern = "*",
    callback = function(state)
        local tab_curr = vim.api.nvim_get_current_tabpage()
        if state.event == "TabEnter" then
            if tab_hist[#tab_hist] == tab_curr then
                return
            end
            tab_hist = remove_curr_tabpage_from_hist(tab_hist, tab_curr)
            table.insert(tab_hist, tab_curr)
        end
        if state.event == "TabClosed" then
            if #tab_hist < 2 then
                return
            end

            table.remove(tab_hist)
            tab_hist = remove_invalid_tabpages_from_hist(tab_hist)
            local tab_prev = tab_hist[#tab_hist]

            if not tab_prev then
                return
            end

            if vim.api.nvim_tabpage_is_valid(tab_prev) then
                vim.api.nvim_set_current_tabpage(tab_prev)
            end
        end
    end,
})
