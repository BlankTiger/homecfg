local status_ok, mini_surround = pcall(require, "mini.surround")
if not status_ok then
    return
end

mini_surround.setup({
    mappings = {
        add = "Ys",
        delete = "ds",
        replace = "cs",
        find = "", -- Find surrounding (to the right)
        find_left = "", -- Find surrounding (to the left)
        highlight = "", -- Highlight surrounding
        update_n_lines = "", -- Update `n_lines`
    },
})
