return {
    "nvim-lua/plenary.nvim",

    {
        "folke/trouble.nvim",
        event = "VeryLazy",
        config = function()
            require("trouble").setup()
        end,
    },

    -- {
    --     "folke/todo-comments.nvim",
    --     event = "VeryLazy",
    --     config = function()
    --         require("todo-comments").setup()
    --     end,
    --     dependencies = { "nvim-lua/plenary.nvim" },
    -- },

    { "tpope/vim-sleuth", event = "VeryLazy" },
    { "tpope/vim-obsession", event = "VeryLazy" },

    { "nvim-pack/nvim-spectre", event = "VeryLazy" },

    {
        "AckslD/nvim-neoclip.lua",
        event = "VeryLazy",
        config = function()
            require("neoclip").setup()
        end,
    },

    {
        "chomosuke/term-edit.nvim",
        event = "TermOpen",
        version = "1.*",
        config = function()
            require("term-edit").setup({
                prompt_end = "❯",
            })
        end,
    },

    { "preservim/tagbar", event = "VeryLazy" },

    {
        "kr40/nvim-macros",
        cmd = { "MacroSave", "MacroYank", "MacroSelect", "MacroDelete" },
        opts = {

            json_file_path = vim.fs.normalize(vim.fn.stdpath("config") .. "/macros.json"),
            default_macro_register = "q",
            json_formatter = "jq",
        },
    },

    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
}
