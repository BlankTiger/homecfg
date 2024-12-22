return {
    {
        "glepnir/dashboard-nvim",
        lazy = false,
        priority = 900,
        config = function()
            require("dashboard").setup({
                theme = "hyper",
                config = {
                    project = { enable = false },
                    header = {},
                    footer = {},
                    week_header = {
                        enable = false,
                    },
                    shortcut = {
                        -- { desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
                        -- {
                        --   desc = ' Files',
                        --   group = 'Label',
                        --   action = 'Telescope find_files',
                        --   key = 'f',
                        -- },
                        -- {
                        --   desc = ' Apps',
                        --   group = 'DiagnosticHint',
                        --   action = 'Telescope app',
                        --   key = 'a',
                        -- },
                        {
                            desc = " Find File",
                            group = "Number",
                            action = 'require("telescope.builtin").find_files()',
                            key = "a",
                        },
                    },
                },
            })
        end,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 900,
        opts = {},
    },

    {
        "seandewar/paragon.vim",
        lazy = false,
        priority = 1000,
    },

    -- { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
}
