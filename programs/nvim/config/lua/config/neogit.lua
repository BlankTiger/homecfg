local status_ok, neogit = pcall(require, "neogit")
if not status_ok then
    return
end

neogit.setup({
    console_timeout = 10000,
    auto_show_console = true,
})
