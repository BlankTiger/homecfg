return {
    "nvim-lua/plenary.nvim",

    { "tpope/vim-repeat", event = "VeryLazy" },

    { "tpope/vim-sleuth", event = "VeryLazy" },

    {
        "preservim/tagbar",
        event = "VeryLazy",
        config = function()
            local set = vim.keymap.set
            set("n", "<f10>", ":TagbarToggle<cr>", vim.g.n_opts)
        end,
    },

    {
        "skywind3000/asyncrun.vim",
        event = "VeryLazy",
        config = function()
            local set = vim.keymap.set

            set({ "t", "n" }, "<F2>", function()
                vim.cmd("copen | AsyncStop | AsyncStop | AsyncRun " .. vim.g.mk)
            end, vim.g.n_opts)
        end,
    },
}
