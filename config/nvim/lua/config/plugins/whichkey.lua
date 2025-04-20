return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        tag = "v2.1.0",
        config = function()
            require("user.keymaps")
        end,
    },
}
