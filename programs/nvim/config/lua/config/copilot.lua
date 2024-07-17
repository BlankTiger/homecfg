local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
    return
end

copilot.setup({
    suggestion = { enabled = false, debounce = 0 },
    panel = { enabled = false },
    suggestion = {
        auto_trigger = true,
        debounce = 0,
        keymap = {
            accept = "<S-Tab>",
        },
    },
})
