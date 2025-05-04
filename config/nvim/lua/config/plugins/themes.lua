return {

    -- {
    --     "seandewar/paragon.vim",
    --     lazy = false,
    --     priority = 1000,
    -- },

    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                transparent = true, -- Enable this to disable setting the background color
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = false },
                    keywords = { italic = false },
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark", -- style for sidebars, see below
                    floats = "dark", -- style for floating windows
                },
                on_highlights = function(hl, c)
                    local prompt = "#2d3149"
                    hl.TelescopeNormal = {
                        bg = "#000000",
                        fg = c.fg_dark,
                    }
                    hl.TelescopeBorder = {
                        bg = "#000000",
                        fg = c.fg_dark,
                    }
                    hl.TelescopePromptNormal = {
                        bg = "#000000",
                    }
                    hl.TelescopePromptBorder = {
                        bg = "#000000",
                        fg = c.fg_dark,
                    }
                    hl.TelescopePromptTitle = {
                        bg = "#000000",
                        fg = c.fg_dark,
                    }
                    hl.TelescopePreviewTitle = {
                        bg = "#000000",
                        fg = c.fg_dark,
                    }
                    hl.TelescopeResultsTitle = {
                        bg = "#000000",
                        fg = c.fg_dark,
                    }
                end,
            })
        end,
    },
}
