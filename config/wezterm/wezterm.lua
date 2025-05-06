local wezterm = require("wezterm")

local config = {
    unix_domains = {
        {
            name = "unix",
        },
    },
    default_gui_startup_args = { "connect", "unix" },
    default_prog = { "/usr/bin/fish" },
    window_decorations = "NONE",
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    enable_tab_bar = false,
    font = wezterm.font("Berkeley Mono Condensed"),
    font_rules = {
        {
            intensity = "Normal",
            italic = true,
            font = wezterm.font("Berkeley Mono Condensed Oblique"),
        },
        {
            intensity = "Bold",
            italic = true,
            font = wezterm.font("Berkeley Mono Bold Condensed Oblique"),
        },
        {
            intensity = "Bold",
            italic = false,
            font = wezterm.font("Berkeley Mono Bold Condensed"),
        },

        {
            intensity = "Half",
            italic = false,
            font = wezterm.font("Berkeley Mono Condensed"),
        },
        {
            intensity = "Half",
            italic = true,
            font = wezterm.font("Berkeley Mono Condensed Oblique"),
        },
    },
    font_size = 14,

    cursor_blink_ease_in = "Constant",
    cursor_blink_ease_out = "Constant",

    color_scheme = "Tokyo Night",
    colors = {
        background = "#000000",
    },
}

return config
