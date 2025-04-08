local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true }
vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>zm", opts)
vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>zm", opts)
vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>k", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>zm", opts)
vim.keymap.set(
    { "n", "i" },
    "<C-k>",
    "<cmd>lua vim.lsp.buf.signature_help()<CR>",
    { buf = bufnr, noremap = true, silent = true }
)
vim.api.nvim_buf_set_keymap(bufnr, "n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
--[[ vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) ]]
vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "[d",
    '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
    opts
)
vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "]d",
    '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',
    opts
)
vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gl",
    '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>',
    opts
)
vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>.",
    "<cmd>lua vim.diagnostic.setloclist()<CR>",
    opts
)
vim.cmd([[ command! Format execute "<cmd>lua require('conform').format({ async = true })<cr>" ]])
