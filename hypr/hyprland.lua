-- ============================================================================
-- HYPRLAND KONFIGURATION (Minimalistisch · Instant · Matte Sage/Slate Theme)
-- Dokumentation aller Tastenkombinationen: ~/.config/hypr/README.md
-- ============================================================================

------------------
---- MONITORS ----
------------------
-- Interner Laptop-Bildschirm auf nativer Skalierung (1.0 = volle 1920x1080 statt 1.5x Zoom)
hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "auto",
    scale    = 1.0,
})

-- Alle weiteren angeschlossenen Bildschirme automatisch erkennen und platzieren
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1.0,
})


---------------------
---- MY PROGRAMS ----
---------------------
local terminal    = "kitty"
local menu        = "pkill -x fuzzel || fuzzel"
local browser     = "firefox"
local fileManager = "pcmanfm"
local tuiFiles    = "kitty -e yazi"
local lock        = "hyprlock"
local powermenu   = "/home/mweiss/.config/hypr/powermenu.sh"


-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_SIZE", "20")


-----------------------
---- LOOK AND FEEL ----
-----------------------
-- Minimalistisch: Keine Animationen, keine Ränder/Abstände am Rand, keine Rundungen/Schatten/Blur
-- Catppuccin Mocha Pastellfarben: Base (#1e1e2e), Surface0 (#313244), Pastel Blue (#89b4fa) & Teal (#94e2d5)
hl.config({
    general = {
        gaps_in     = 0,
        gaps_out    = 0,
        border_size = 1,

        col = {
            active_border   = "rgba(89b4faff)",
            inactive_border = "rgba(313244ff)",
        },

        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding         = 0,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = false,
        },

        blur = {
            enabled = false,
        },
    },

    animations = {
        enabled = false,
    },

    dwindle = {
        preserve_split = true,
        smart_split    = false,
    },

    master = {
        new_status = "master",
    },

    misc = {
        -- Hintergrundbilder bleiben wie gewünscht unverändert
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
        background_color        = "0x1e1e2e",
        animate_manual_resizes  = false,
        animate_mouse_windowdragging = false,
        disable_splash_rendering = true,
    },
})


---------------
---- INPUT ----
---------------
hl.config({
    input = {
        kb_layout  = "de",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll       = true,
            tap_to_click         = true,
            disable_while_typing = true,
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})


---------------------
---- KEYBINDINGS ----
---------------------
-- Siehe ~/.config/hypr/README.md für die vollständige Übersicht
local mainMod = "SUPER"

-- Programme starten & System
hl.bind(mainMod .. " + Return",         hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",              hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("kitty -e tmux new-session -A -s main"))
hl.bind(mainMod .. " + space",          hl.dsp.exec_cmd(menu))
hl.bind("ALT + space",             hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + D",         hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + R",         hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + A",         hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + B",              hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E",              hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + Y",              hl.dsp.exec_cmd(tuiFiles))
hl.bind(mainMod .. " + L",              hl.dsp.exec_cmd(lock))
hl.bind(mainMod .. " + Escape",    hl.dsp.exec_cmd(powermenu))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("killall -SIGUSR2 waybar || (pkill waybar; waybar &)"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())
hl.bind(mainMod .. " + M",         hl.dsp.exit())

-- Fenster-Aktionen
hl.bind(mainMod .. " + C",         hl.dsp.window.close())
hl.bind(mainMod .. " + W",         hl.dsp.window.close())
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + V",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P",         hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T",         hl.dsp.layout("togglesplit"))

-- Fokus zwischen Fenstern wechseln (SUPER + Pfeiltasten)
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Fenster verschieben / tauschen (SUPER + SHIFT + Pfeiltasten)
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

-- Fenstergröße anpassen (SUPER + CTRL + Pfeiltasten)
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 40,  y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.resize({ x = 0,  y = -40, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.resize({ x = 0,  y = 40,  relative = true }), { repeating = true })

-- Bildschirme / Workspaces wechseln mit STRG + ALT + Pfeiltasten (Links / Rechts)
hl.bind("CTRL + ALT + left",          hl.dsp.focus({ workspace = "r-1" }))
hl.bind("CTRL + ALT + right",         hl.dsp.focus({ workspace = "r+1" }))
hl.bind("CTRL + ALT + SHIFT + left",  hl.dsp.window.move({ workspace = "r-1" }))
hl.bind("CTRL + ALT + SHIFT + right", hl.dsp.window.move({ workspace = "r+1" }))

-- Hilfsfunktion: Wechselt nur dann zu Bildschirm / Workspace <num>, wenn dieser tatsächlich existiert ("sofern da")
local function focus_existing_screen(num)
    for _, ws in ipairs(hl.get_workspaces()) do
        if ws.id == num or ws.name == tostring(num) then
            hl.dispatch(hl.dsp.focus({ workspace = num }))
            return
        end
    end
    local monitors = hl.get_monitors()
    if monitors and monitors[num] then
        hl.dispatch(hl.dsp.focus({ monitor = monitors[num].name }))
    end
end

-- Workspaces / Bildschirme über Zahlen (1-10)
for i = 1, 10 do
    local key = i % 10
    -- STRG + ALT + <num>: Wechselt zu Bildschirm/Workspace <num>, sofern dieser bereits vorhanden ist
    hl.bind("CTRL + ALT + " .. key, function()
        focus_existing_screen(i)
    end)
    -- SUPER + <num>: Wechselt direkt zu Workspace <num> (oder legt ihn neu an)
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Unbegrenzte / Dynamische Workspaces (Infinity Workspaces)
hl.bind(mainMod .. " + period",         hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + comma",          hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + Next",           hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + Prior",          hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + N",              hl.dsp.focus({ workspace = "empty" }))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mainMod .. " + SHIFT + comma",  hl.dsp.window.move({ workspace = "r-1" }))
hl.bind(mainMod .. " + SHIFT + N",      hl.dsp.window.move({ workspace = "empty" }))

-- Mausrad durch Workspaces (unbegrenzt)
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "r-1" }))

-- Scratchpad (Special Workspace)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Fenster mit Maus verschieben / skalieren (SUPER + Linksklick / Rechtsklick)
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshots (Bereich oder ganzer Bildschirm direkt in die Zwischenablage & ~/Downloads)
hl.bind("Print",                    hl.dsp.exec_cmd("sh -c 'grim - | tee ~/Downloads/screenshot-$(date +%Y%m%d-%H%M%S).png | wl-copy'"))
hl.bind(mainMod .. " + SHIFT + P",  hl.dsp.exec_cmd("sh -c 'grim -g \"$(slurp)\" - | tee ~/Downloads/screenshot-$(date +%Y%m%d-%H%M%S).png | wl-copy'"))

-- Multimedia & Helligkeit (Laptop-Funktionstasten)
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),        { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),       { locked = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),     { locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                    { locked = true, repeating = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})
