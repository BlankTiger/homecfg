-- Montior wiki https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "auto",
    scale    = "2",
})

hl.monitor({
    output   = "DP-6",
    mode     = "preferred",
    position = "auto-left",
    scale    = "1",
})

hl.monitor({
    output   = "DP-4",
    mode     = "preferred",
    position = "auto-left",
    scale    = "1",
})

hl.monitor({
    output   = "DP-2",
    mode     = "1920x1200@60Hz",
    position = "auto-left",
    scale    = "1",
})

hl.monitor({
    output   = "DP-1",
    mode     = "3840x2160@240.08Hz",
    -- mode     = "3840x2160@144.05Hz",
    position = "auto-right",
    scale    = "1.5",
})

hl.monitor({
    output   = "HDMI-A-2",
    mode     = "3840x2160@120.00Hz",
    position = "auto-right",
    scale    = "1.5",
})

-- Paired workspaces: DP-1 (main, 4K) owns 1-10, DP-2 (side, 1080p) owns 11-20.
-- Keybinds.lua switches both monitors together on Super+N.
local MAIN_MON    = "DP-1"
local SIDE_MON    = "DP-2"
local SIDE_OFFSET = 10

for i = 1, 10 do
    hl.workspace_rule({
        workspace  = tostring(i),
        monitor    = MAIN_MON,
        default    = (i == 1),
        persistent = true,
    })
    hl.workspace_rule({
        workspace  = tostring(i + SIDE_OFFSET),
        monitor    = SIDE_MON,
        default    = (i == 1),
        persistent = true,
    })
end
