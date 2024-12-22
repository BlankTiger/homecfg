return {
    --[[ "kyazdani42/nvim-web-devicons", ]]

    {
        "kevinhwang91/nvim-ufo",
        event = "VeryLazy",
        dependencies = "kevinhwang91/promise-async",
        config = function()
            require("ufo").setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return { "lsp", "indent" }
                end,
            })
        end,
    },

    {
        "folke/zen-mode.nvim",
        event = "VeryLazy",
        config = function()
            require("zen-mode").setup({
                window = {
                    -- backdrop = 0.95,
                    width = 130,
                },
                plugins = {
                    twilight = { enabled = false },
                    gitsigns = { enabled = false },
                    tmux = { enabled = false },
                    -- alacritty = {
                    --     enabled = true,
                    --     font = "20",
                    -- },
                },
            })
        end,
    },
    {
        "folke/twilight.nvim",
        config = function()
            require("twilight").setup()
        end,
        event = "VeryLazy",
    },

    {
        "RRethy/vim-illuminate",
        lazy = true,
        -- event = "VeryLazy",
    },

    { "romainl/vim-cool", event = "VeryLazy" },

    {
        "norcalli/nvim-colorizer.lua",
        event = "VeryLazy",
        config = function()
            require("colorizer").setup()
        end,
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        config = function()
            local noice = require("noice")
            noice.setup({
                lsp = {
                    progress = {
                        enabled = false,
                    },
                    signature = { auto_open = { enabled = false } },
                },
                notify = {
                    enabled = false,
                },
            })
        end,
        dependencies = {
            {
                "echasnovski/mini.notify",
                config = function()
                    require("mini.notify").setup({
                        lsp_progress = { enable = false },
                        window = {
                            config = {
                                anchor = "NE",
                                border = "none",
                            },
                            winblend = 50,
                        },
                    })
                    vim.notify = MiniNotify.make_notify()
                end,
            },
            {
                "j-hui/fidget.nvim",
                config = function()
                    require("fidget").setup({
                        progress = {
                            display = {
                                progress_icon = { pattern = "moon" },
                                progress_style = "moon",
                            },
                        },
                    })
                end,
            },
            "MunifTanjim/nui.nvim",
        },
    },
}
