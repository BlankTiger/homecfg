local autocmd_group = vim.api.nvim_create_augroup("My custom auto commands", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = autocmd_group,
    pattern = "term://*",
    callback = function()
        vim.api.nvim_command("startinsert")
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
