-- Input configuration

hl.config({
    input = {
        accel_profile = "flat",
        kb_layout = "pl",
        repeat_delay = 200,
        repeat_rate = 40,

        touchpad = {
            natural_scroll = false,
            disable_while_typing = true,
            clickfinger_behavior = true,
            scroll_factor = 0.5,
        },

        special_fallthrough = true,
        follow_mouse = 1,
        force_no_accel = 1,
    },
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down",       action = "close" })
hl.gesture({ fingers = 3, direction = "up",         action = "fullscreen" })
hl.gesture({ fingers = 3, direction = "left",       action = "float" })
