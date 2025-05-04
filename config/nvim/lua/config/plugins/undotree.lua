return {
    {
        "mbbill/undotree",
        event = "VeryLazy",
        config = function()
            vim.keymap.set("n", "<leader>U", ":UndotreeToggle<cr>", vim.g.n_opts)
        end,
    },
}
