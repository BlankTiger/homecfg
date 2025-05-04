local set = vim.keymap.set

set("n", "<F10>", "<cmd>TagbarToggle<cr>", vim.g.n_opts)
set({ "t", "n" }, "<F1>", "<cmd>AsyncStop<cr>", vim.g.n_opts)
set({ "t", "n" }, "<F2>", function()
    vim.cmd("AsyncStop")
    vim.cmd("copen | AsyncRun " .. vim.g.mk)
end, vim.g.n_opts)

return {
    "nvim-lua/plenary.nvim",

    { "tpope/vim-repeat", event = "VeryLazy" },

    { "tpope/vim-sleuth", event = "VeryLazy" },

    {
        "preservim/tagbar",
        cmd = { "TagbarToggle" },
    },

    {
        "skywind3000/asyncrun.vim",
        cmd = { "AsyncRun", "AsyncStop" },
    },
}
