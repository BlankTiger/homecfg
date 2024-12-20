local autocmd_group = vim.api.nvim_create_augroup("My custom auto commands", { clear = true })

vim.api.nvim_create_autocmd({ "CmdwinEnter" }, {
    group = autocmd_group,
    pattern = "*",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        vim.keymap.set({ "n", "i" }, "<C-q>", "<C-c><C-c>", { buffer = bufnr })
        vim.keymap.set({ "n" }, "q", "<C-c><C-c>", { buffer = bufnr })
    end,
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
    group = autocmd_group,
    pattern = "*",
    callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
        vim.api.nvim_command("startinsert")
    end,
})

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

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = autocmd_group,
    desc = "highlight trailing whitespace",
    pattern = { "*.zig", "*.lua", "*.rs", ".py", "*.js" },
    callback = function()
        vim.cmd([[
            highlight ExtraWhitespace ctermbg=red guibg=red
            match ExtraWhitespace /\s\+$/
        ]])
    end,
})
-- vim.g.treesitter_loaded = false
-- vim.api.nvim_create_autocmd(
-- 	{ "BufEnter" },
-- 	{
-- 		pattern = { "*.*" },
-- 		callback = function()
-- 			if not vim.g.treesitter_loaded then
-- 				-- require("cmp")
-- 				require("nvim-treesitter")
-- 				vim.g.treesitter_loaded = true
-- 				return
-- 			end
-- 		end,
-- 		group = autocmd_group,
-- 	}
-- )
