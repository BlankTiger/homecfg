return {
    -- {
    --     "seandewar/paragon.vim",
    --     lazy = false,
    --     priority = 1000,
    -- },

    {
        "RostislavArts/naysayer.nvim",
        lazy = false,
        priority = 1000,
        cond = vim.g.theme == "naysayer",
    },
    {
        "Shatur/neovim-ayu",
        lazy = false,
        priority = 1000,
        cond = vim.g.theme ~= "naysayer",
    },
}
