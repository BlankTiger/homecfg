return {
    {
        url = "https://github.com/BlankTiger/oil.nvim",
        -- "stevearc/oil.nvim",
        event = "VeryLazy",
        config = function()
            local showing_details = true
            local oil = require("oil")
            oil.setup({
                keymaps = {
                    ["<C-t>"] = false,
                    ["<C-h>"] = false,
                    ["<C-l>"] = false,
                    ["<C-j>"] = false,
                    ["<C-k>"] = false,
                    ["-"] = false,
                    ["q"] = "actions.close",
                    ["<leader>r"] = "actions.refresh",
                    ["<BS>"] = "actions.parent",
                    ["gd"] = {
                        desc = "Toggle file detail view",
                        callback = function()
                            showing_details = not showing_details
                            if showing_details then
                                oil.set_columns({ "icon", "permissions", "size", "mtime" })
                            else
                                oil.set_columns({ "icon" })
                            end
                        end,
                    },
                    ["<A-s>"] = "actions.select_vsplit",
                    ["<A-h>"] = "actions.select_split",
                    ["<A-t>"] = "actions.select_tab",
                },
                view_options = {
                    show_hidden = true,
                },
            })
            oil.set_columns({ "icon", "permissions", "size", "mtime" })
        end,
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
}
