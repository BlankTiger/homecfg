-- Look and feel configuration

hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 0,
        gaps_workspaces = 50,
        extend_border_grab_area = 10,
        resize_on_border = true,
        col = {
            active_border = {
                colors = { CACHYLGREEN, CACHYDGREEN },
                angle = 45,
            },
            inactive_border = CACHYGRAY,
        },
    },

    group = {
        col = {
            border_active = CACHYLBLUE,
            border_inactive = CACHYGRAY,
            border_locked_active = CACHYDBLUE,
            border_locked_inactive = CACHYGRAY,
        },
        groupbar = {
            col = {
                active = CACHYLGREEN,
                inactive = CACHYGRAY,
                locked_active = CACHYDBLUE,
                locked_inactive = CACHYGRAY,
            },
        },
    },

    decoration = {
        dim_inactive = false,
        dim_special = 0,
        dim_strength = 0.1,
        rounding = 0,
        active_opacity = 1,
        inactive_opacity = 1,
        fullscreen_opacity = 1,

        blur = {
            size = 5,
            passes = 4,
            special = true,
        },

        shadow = {
            enabled = true,
            range = 20,
            offset = "0 2",
            render_power = 4,
            color = "rgba(0000002A)",
        },
    },
})
