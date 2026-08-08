local mainMod = "SUPER"
local noctCall = "qs -c noctalia-shell ipc call "
local launchPrefix = "uwsm app -- " -- if you are not using UWSM, make this empty (e.g. "")

---------------------------
---- WINDOW MANAGEMENT ----
---------------------------

hl.bind(mainMod .. " + Q",       hl.dsp.window.close())
hl.bind(mainMod .. " + V",       hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D",       hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mainMod .. " + F",       hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + J",       hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + L",       hl.dsp.exec_cmd(noctCall .. " lockScreen lock"))
hl.bind(mainMod .. " + ALT + C", hl.dsp.exec_cmd(noctCall .. " sessionMenu toggle"))

-- Change focus
hl.bind(mainMod .. " + Left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + Up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + Down",  hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + Tab",           hl.dsp.window.cycle_next())

-- Move active window around current workspace
hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + Left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + Up",    hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + Down",  hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + CONTROL + SHIFT + Right", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mainMod .. " + CONTROL + SHIFT + Left",  hl.dsp.window.move({ workspace = "r-1" }))

-- Move & Resize with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

------------------
---- LAUNCHER ----
------------------

hl.bind(mainMod .. " + T",          hl.dsp.exec_cmd(TERMINAL))
hl.bind(mainMod .. " + E",          hl.dsp.exec_cmd(launchPrefix .. FILE_MANAGER))
hl.bind(mainMod .. " + C",          hl.dsp.exec_cmd(launchPrefix .. CALCULATOR))
hl.bind(mainMod .. " + W",          hl.dsp.exec_cmd(launchPrefix .. BROWSER))
hl.bind("CONTROL + SHIFT + Escape", hl.dsp.exec_cmd(launchPrefix .. TERMINAL .. " -e btop"))
hl.bind(mainMod .. " + Z",          hl.dsp.exec_cmd(noctCall .. "settings toggle"))
hl.bind(mainMod .. " + X",          hl.dsp.exec_cmd(noctCall .. "controlCenter toggle"))
hl.bind(mainMod .. " + R",          hl.dsp.exec_cmd(noctCall .. "launcher toggle"))
hl.bind(mainMod .. " + period",     hl.dsp.exec_cmd(noctCall .. "launcher emoji"))

---------------------------
---- HARDWARE CONTROLS ----
---------------------------

-- Audio
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(noctCall .. "volume increase"),   { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(noctCall .. "volume decrease"),   { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(noctCall .. "volume muteOutput"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd(noctCall .. "volume muteInput"),  { locked = true, repeating = true })

-- Media
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd(noctCall .. "media playPause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(noctCall .. "media playPause"), { locked = true })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd(noctCall .. "media next"),      { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd(noctCall .. "media previous"),  { locked = true })

-- Brightness
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(noctCall .. "brightness increase"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(noctCall .. "brightness decrease"), { repeating = true })

-------------------
---- UTILITIES ----
-------------------

-- Screen Capture
hl.bind(mainMod .. " + P",     hl.dsp.exec_cmd(noctCall .. "plugin:screen-toolkit colorPicker"))
hl.bind("Print",               hl.dsp.exec_cmd(noctCall .. "plugin:screen-toolkit annotate"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd(noctCall .. "plugin:screen-toolkit annotateWindow"))
hl.bind(mainMod .. " + Space",     hl.dsp.exec_cmd(noctCall .. "plugin:screen-toolkit toggle"))

-- Theming and Wallpaper
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(noctCall .. " wallpaper toggle"))

-- Clipboard
-- hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(noctCall .. "launcher clipboard"))

hl.bind(mainMod .. " + M", function()
    for i = 2, 10 do
        hl.monitor({ output = "DP-" .. i, disabled = true })
    end
end)

--------------------
---- WORKSPACES ----
--------------------

-- Paired workspaces: DP-1 (main) uses 1-10, DP-2 (side) uses 11-20.
-- Super+N focuses N on whichever monitor is active, and moves the other
-- monitor to its paired workspace (N on main, N+10 on side) at the same time.
-- Super+Shift+M toggles this pairing off/on.
local SIDE_MON    = "DP-2"
local SIDE_OFFSET = 10
local PAIR_COUNT  = 10
local paired_mode = true

local function pair_index(ws)
    local id = ws and ws.id or 1
    if id > SIDE_OFFSET then id = id - SIDE_OFFSET end
    if id < 1 then id = 1 end
    if id > PAIR_COUNT then id = PAIR_COUNT end
    return id
end

local function focus_pair(i)
    if not paired_mode then
        local active  = hl.get_active_monitor()
        local on_side = active and active.name == SIDE_MON
        hl.dispatch(hl.dsp.focus({ workspace = on_side and (i + SIDE_OFFSET) or i }))
        return
    end

    local was_side = hl.get_active_monitor() and hl.get_active_monitor().name == SIDE_MON
    -- Switch both monitors to their half of the pair.
    hl.dispatch(hl.dsp.focus({ workspace = i }))
    hl.dispatch(hl.dsp.focus({ workspace = i + SIDE_OFFSET }))
    -- The dispatch above left focus on the side monitor; put it back
    -- on the main monitor unless that's where the user actually was.
    if not was_side then
        hl.dispatch(hl.dsp.focus({ workspace = i }))
    end
end

hl.bind(mainMod .. " + SHIFT + M", function()
    paired_mode = not paired_mode
    -- hl.notification.create() ignores monitor scale and can render off-screen;
    -- notify-send routes through noctalia's own notification popup instead.
    hl.exec_cmd('notify-send -a Hyprland "Paired workspace switching" "'
        .. (paired_mode and "ON" or "OFF") .. '"')
end)

local function focus_pair_rel(delta)
    local i = pair_index(hl.get_active_workspace()) + delta
    if i < 1 then i = PAIR_COUNT end
    if i > PAIR_COUNT then i = 1 end
    focus_pair(i)
end

local function move_to_pair(i, follow)
    local active = hl.get_active_monitor()
    local ws     = (active and active.name == SIDE_MON) and (i + SIDE_OFFSET) or i
    hl.dispatch(hl.dsp.window.move({ workspace = ws, follow = follow }))

    if follow then
        -- follow already changed what the active monitor is showing;
        -- keep the sibling monitor in lockstep, same as pressing Super+N.
        focus_pair(i)
    end
end

for i = 1, PAIR_COUNT do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         function() focus_pair(i) end)
    hl.bind(mainMod .. " + SHIFT + " .. key, function() move_to_pair(i, true) end)
    hl.bind(mainMod .. " + ALT + " .. key,   function() move_to_pair(i, false) end)
end

hl.bind(mainMod .. " + CONTROL + Right",       function() focus_pair_rel(1) end)
hl.bind(mainMod .. " + CONTROL + Left",        function() focus_pair_rel(-1) end)
hl.bind(mainMod .. " + CONTROL + Down",        hl.dsp.focus({ workspace = "empty" }))
hl.bind(mainMod .. " + CONTROL + ALT + Right", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mainMod .. " + CONTROL + ALT + Left",  hl.dsp.window.move({ workspace = "r-1" }))

-- Scroll through paired workspaces
hl.bind(mainMod .. " + mouse_down", function() focus_pair_rel(1) end)
hl.bind(mainMod .. " + mouse_up",   function() focus_pair_rel(-1) end)

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special" }))
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special())

-----------------------
---- NOTIFICATIONS ----
-----------------------

hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(noctCall .. "notifications toggleHistory"))


local ZOOM_STEP = 0.05

local function adjust_zoom(delta)
    local zoom = hl.get_config("cursor.zoom_factor") + delta
    hl.config({ cursor = { zoom_factor = zoom } })
end

hl.bind(mainMod .. " + SHIFT + mouse_down", function() adjust_zoom( ZOOM_STEP) end)
hl.bind(mainMod .. " + SHIFT + mouse_up",   function() adjust_zoom(-ZOOM_STEP) end)
hl.bind(mainMod .. " + SHIFT + Z",          function() hl.config({ cursor = { zoom_factor = 0 } }) end)
