return {
    {
        -- url = "https://github.com/BlankTiger/oil.nvim",
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local showing_details = false
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
            if showing_details then
                oil.set_columns({ "icon", "permissions", "size", "mtime" })
            end

            vim.keymap.set("n", "-", function()
                local curr_buf = vim.api.nvim_get_current_buf()
                local buf_name = vim.api.nvim_buf_get_name(curr_buf)
                -- check if oil is in buf_name
                local is_open = buf_name:find("oil://") ~= nil
                if is_open then
                    oil.close()
                else
                    oil.open()
                end
            end)
        end,
    },
}
