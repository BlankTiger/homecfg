return {
    {
        "mbbill/undotree",
        event = "VeryLazy",
        config = function()
            vim.keymap.set("n", "<leader>U", "<cmd>UndotreeToggle<cr>", vim.g.n_opts)
        end,
    },
}
