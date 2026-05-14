-- Hyprland Lua Config
-- Converted from hyprland.conf (hyprlang) to hyprland.lua (Lua)
-- Refer to the wiki for more information: https://wiki.hypr.land/Configuring/Start/

------------------
---- PROGRAMS ----
------------------

local terminal    = "alacritty"
local fileManager = "pcmanfm"
local browser     = "flatpak run app.zen_browser.zen"
local menu        = "hyprlauncher"
local mainMod     = "SUPER"

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE",          "24")
hl.env("HYPRCURSOR_SIZE",       "24")
hl.env("QT_QPA_PLATFORMTHEME",  "hyprqt6engine")
hl.env("GTK_THEME",             "Adwaita-dark")

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
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

-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
for i = 1, 5 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "DP-1" })
end
for i = 6, 10 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "DP-3" })
end

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- See https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        border_size        = 2,
        gaps_in            = 3,
        gaps_out           = 10,
        col = {
            active_border   = { colors = { "rgba(29593aee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
            nogroup_border          = "rgba(ff0000ff)",
            nogroup_border_active   = "rgba(00ff00ff)",
        },
        layout             = "dwindle",
        no_focus_fallback  = true,
        resize_on_border   = true,
        extend_border_grab_area = 15,
        hover_icon_on_border    = true,
        allow_tearing      = false,
        resize_corner      = 0,
    },

    decoration = {
        rounding         = 10,
        rounding_power   = 4,
        active_opacity   = 1.0,
        inactive_opacity = 0.8,
        fullscreen_opacity = 1.0,
        dim_inactive     = false,
        dim_strength     = 0.8,
        dim_special      = 0.5,
        dim_around       = 0.2,
        border_part_of_window = false,

        blur = {
            enabled = false,
        },

        shadow = {
            enabled      = true,
            range        = 20,
            render_power = 4,
            color        = "rgba(1a1a1aee)",
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

--------------------
---- ANIMATIONS ----
--------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
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
hl.animation({ leaf = "layersIn",       enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade"    })
hl.animation({ leaf = "layersOut",      enabled = true, speed = 1.5,  bezier = "linear",       style = "fade"    })
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

-- See https://wiki.hypr.land/Configuring/Basics/Binds/

-- Applications
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))

-- Session
hl.bind(mainMod .. " + C",         hl.dsp.window.close())
hl.bind(mainMod .. " + M",         hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))

-- Window management
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + G", hl.dsp.layout("swapwithmaster"))

-- Launcher
hl.bind("ALT + SPACE", hl.dsp.exec_cmd(menu))

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
    hl.bind(mainMod .. " + " .. key,                hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,        hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Mouse window controls
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshots (hyprshot)
hl.bind("SHIFT + Print",                  hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(mainMod .. " + SHIFT + Print",    hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(mainMod .. " + SHIFT + CTRL + Print", hl.dsp.exec_cmd("hyprshot -m region"))

-- Volume
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    { locked = true, repeating = true })

-- Brightness
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Media
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),    { locked = true })
