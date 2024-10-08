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

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = autocmd_group,
    pattern = "term://*",
    callback = function()
        vim.api.nvim_command("startinsert")
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", {}),
    desc = "Hightlight selection on yank",
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "Search", timeout = 130 })
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
