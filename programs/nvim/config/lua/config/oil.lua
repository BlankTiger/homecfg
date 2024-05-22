local status_ok, oil = pcall(require, "oil")
if not status_ok then
    return
end

oil.setup({
    keymaps = {
        ["<C-t>"] = false,
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-j>"] = false,
        ["<C-k>"] = false,
        ["-"] = false,
        ["<leader>r"] = "actions.refresh",
        ["<BS>"] = "actions.parent",
    },
    view_options = {
        show_hidden = true,
    },
})
