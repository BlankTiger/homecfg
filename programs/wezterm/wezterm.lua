local wezterm = require("wezterm")

local config = {
    window_decorations = "NONE",
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    enable_tab_bar = false,
    font = wezterm.font("Iosevka Nerd Font"),
    font_size = 13.5,
    color_scheme = "Tokyo Night",
}

return config
