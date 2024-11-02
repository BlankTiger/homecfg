local status_ok, oil = pcall(require, "oil")
if not status_ok then
    return
end

local showing_details = true
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
                    require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                else
                    require("oil").set_columns({ "icon" })
                end
            end,
        },
    },
    view_options = {
        show_hidden = true,
    },
})
oil.set_columns({ "icon", "permissions", "size", "mtime" })
