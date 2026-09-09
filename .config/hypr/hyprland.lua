-- Hyprland Lua Config
-- Unified Rosé Pine & Modern Wayland Daemon Stack

-----------------------------
---- ROSÉ PINE CONSTANTS ----
-----------------------------
-- Base Palette: https://rosepinetheme.com/palette/
local rp = {
    base    = "rgba(191724ee)",
    surface = "rgba(1f1d2eee)",
    overlay = "rgba(26233aee)",
    muted   = "rgba(6e6a86aa)",
    subtle  = "rgba(908caaaa)",
    text    = "rgba(e0def4ff)",
    love    = "rgba(eb6f92ff)",
    gold    = "rgba(f6c177ff)",
    rose    = "rgba(ebbcbaff)",
    pine    = "rgba(31748fff)",
    foam    = "rgba(9ccfd8ff)",
    iris    = "rgba(c4a7e7ff)",
}

------------------
---- PROGRAMS ----
------------------

local terminal    = "kitty"
local fileManager = "pcmanfm"
local browser     = "flatpak run app.zen_browser.zen"
local menu        = "rofi -show drun -theme-str 'window {width: 25%;} listview {lines: 8;}'"
local clipPicker  = "cliphist list | rofi -dmenu -p 'Clipboard' | cliphist decode | wl-copy"
local mainMod     = "SUPER"

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    -- Theme hints
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")

    -- Wayland systemd environment bridge
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- Clipboard history daemons (text + images)
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- Notification Center
    hl.exec_cmd("swaync")

	-- Hyprland daemons
    hl.exec_cmd("hypridle")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("hyprsunset")

    -- Status Bar
    hl.exec_cmd("waybar")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE",         "24")
hl.env("HYPRCURSOR_SIZE",       "24")
hl.env("QT_QPA_PLATFORMTHEME",  "hyprqt6engine")
hl.env("GTK_THEME",             "Adwaita-dark")

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "DP-1",
    mode     = "highres",
    position = "auto",
    scale    = "auto",
})

hl.monitor({
    output   = "DP-3",
    mode     = "highres",
    position = "auto",
    scale    = "auto",
})

--------------------
---- WORKSPACES ----
--------------------

for i = 1, 5 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "DP-1" })
end
for i = 6, 10 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "DP-3" })
end

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        border_size         = 1,
        gaps_in             = 4,
        gaps_out            = 8,
        col = {
            -- Crisp Rosé to Iris gradient on active focus; subdued Muted on inactive
            active_border   = { colors = { rp.rose, rp.iris }, angle = 45 },
            inactive_border = rp.muted,
            nogroup_border          = rp.love,
            nogroup_border_active   = rp.pine,
        },
        layout              = "dwindle",
        no_focus_fallback   = true,
        resize_on_border    = true,
        extend_border_grab_area = 15,
        hover_icon_on_border    = true,
        allow_tearing       = false,
        resize_corner       = 0,
    },

    decoration = {
        rounding            = 3,
        rounding_power      = 4,

        active_opacity      = 1.0,
        inactive_opacity    = 0.95,
        fullscreen_opacity  = 1.0,
        dim_inactive        = false,
        dim_strength        = 0.8,
        dim_special         = 0.5,
        dim_around          = 0.2,
        border_part_of_window = false,

        blur = {
            enabled = true,
            size = 5,
            passes = 2,
            new_optimizations = true,
            xray = false,
        },

        shadow = {
            enabled      = true,
            range        = 16,
            render_power = 3,
            color        = rp.base,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper  = -1,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
    },

    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad = {
            natural_scroll = true,
        },
    },
})

---------------------
---- LAYER RULES ----
---------------------

-- Blur surfaces for shell overlays while keeping app windows opaque
hl.layer_rule({
	name = "blur-waybar",
	match = { namespace = "waybar" },
	blur = true,
})
-- hl.layer_rule({
-- 	name = "waybar-ignorezero",
-- 	match = { namespace = "waybar" },
-- 	ignorezero = true,
-- })
hl.layer_rule({
	name = "rofi-blur",
	match = { namespace = "rofi" },
	blur = true,
})
-- hl.layer_rule({
-- 	name = "rofi-ignorezero",
-- 	match = { namespace = "rofi" },
-- 	ignorezero = true,
-- })
hl.layer_rule({
	name = "swaync-control-center-blur",
	match = { namespace = "swaync-control-center" },
	blur = true,
})
hl.layer_rule({
	name = "swaync-notification-window-blur",
	match = { namespace = "swaync-notification-window" },
	blur = true,
})
-- hl.layer_rule({
-- 	name = "swaync-control-center-ignorezero",
-- 	match = { namespace = "swaync-control-center" },
-- 	ignorezero = true,
-- })
-- hl.layer_rule({
-- 	name = "swaync-notification-window-ignorezero",
-- 	match = { namespace = "swaync-notification-window" },
-- 	ignorezero = true,
-- })

--------------------
---- ANIMATIONS ----
--------------------

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1.0}  } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

hl.animation({ leaf = "global",         enabled = true, speed = 10,   bezier = "default"      })
hl.animation({ leaf = "windows",        enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",      enabled = true, speed = 1.5,  bezier = "easeOutQuint", style = "popin 0%" })
hl.animation({ leaf = "windowsOut",     enabled = true, speed = 1.2,  bezier = "almostLinear", style = "popin 0%" })
hl.animation({ leaf = "layers",         enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",       enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade"     })
hl.animation({ leaf = "layersOut",      enabled = true, speed = 1.5,  bezier = "linear",       style = "fade"     })
hl.animation({ leaf = "fade",           enabled = true, speed = 3.03, bezier = "quick"         })
hl.animation({ leaf = "fadeIn",         enabled = true, speed = 1.73, bezier = "almostLinear"  })
hl.animation({ leaf = "fadeOut",        enabled = true, speed = 1.46, bezier = "almostLinear"  })
hl.animation({ leaf = "fadeLayersIn",   enabled = true, speed = 1.79, bezier = "almostLinear"  })
hl.animation({ leaf = "fadeLayersOut",  enabled = true, speed = 1.39, bezier = "almostLinear"  })
hl.animation({ leaf = "border",         enabled = true, speed = 5.39, bezier = "easeOutQuint"  })
hl.animation({ leaf = "workspaces",     enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",   enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut",  enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-----------------
---- DEVICES ----
-----------------

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

-- Applications
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))

-- Launchers & Controls
hl.bind("ALT + SPACE",     hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(clipPicker))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- Session
hl.bind(mainMod .. " + C",         hl.dsp.window.close())
hl.bind(mainMod .. " + M",         hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))

-- Window management
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P",         hl.dsp.window.pseudo())
hl.bind(mainMod .. " + G",         hl.dsp.layout("swapwithmaster"))

-- Focus movement (vim-style)
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left"  }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up"    }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down"  }))

-- Resize (fine)
hl.bind("ALT + H", hl.dsp.window.resize({ x = -10, y = 0   }), { repeating = true })
hl.bind("ALT + L", hl.dsp.window.resize({ x =  10, y = 0   }), { repeating = true })
hl.bind("ALT + K", hl.dsp.window.resize({ x = 0,   y = -10 }), { repeating = true })
hl.bind("ALT + J", hl.dsp.window.resize({ x = 0,   y =  10 }), { repeating = true })

-- Resize (coarse)
hl.bind(mainMod .. " + ALT + H", hl.dsp.window.resize({ x = -50, y = 0   }), { repeating = true })
hl.bind(mainMod .. " + ALT + L", hl.dsp.window.resize({ x =  50, y = 0   }), { repeating = true })
hl.bind(mainMod .. " + ALT + K", hl.dsp.window.resize({ x = 0,   y = -50 }), { repeating = true })
hl.bind(mainMod .. " + ALT + J", hl.dsp.window.resize({ x = 0,   y =  50 }), { repeating = true })

-- Workspaces: switch and move (1-10, key 0 = workspace 10)
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Mouse window controls
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshots (hyprshot)
hl.bind("SHIFT + Print",                     hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(mainMod .. " + SHIFT + Print",        hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(mainMod .. " + SHIFT + CTRL + Print", hl.dsp.exec_cmd("hyprshot -m region"))

-- Volume (wpctl)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    { locked = true, repeating = true })

-- Brightness (brightnessctl)
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Media (playerctl)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),    { locked = true })
