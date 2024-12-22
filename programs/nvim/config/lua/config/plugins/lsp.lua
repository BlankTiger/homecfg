return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        cmd = { "Mason", "LspInfo", "LspInstall", "LspUninstall" },
        config = function()
            require("config.lsp")
        end,
        dependencies = {},
    },

    {
        "folke/neodev.nvim",
        ft = "lua",
        config = function()
            require("neodev").setup({})
        end,
        opts = {},
    },

    {
        "mrcjkb/rustaceanvim",
        version = "^5", -- Recommended
        lazy = false, -- This plugin is already lazy
    },

    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
    },
}
