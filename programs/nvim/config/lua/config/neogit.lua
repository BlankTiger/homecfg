local status_ok, neogit = pcall(require, "neogit")
if not status_ok then
    return
end

neogit.setup({
    console_timeout = 10000,
    auto_show_console = true,
    disable_line_numbers = false,
    mappings = {
        status = {
            ["<c-s>"] = "VSplitOpen",
            ["<c-h>"] = "SplitOpen",
            ["R"] = "ShowRefs",
            ["y"] = false,
        },
    },
})
