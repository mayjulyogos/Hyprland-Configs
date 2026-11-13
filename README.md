# Hyprland-Configs

## Installation
```bash
sudo pacman -S hyprland
```

## Dependencies
```bash
sudo pacman -S kitty \
    hyprpolkitagent \
    xdg-desktop-portal-hyprland \
    ttf-font-awesome \
    ttf-jetbrains-mono-nerd \
    noto-fonts \
    noto-fonts-cjk \
    noto-fonts-emoji \
    nautilus \
    polkit-gnome \
    gnome-logs

fc-cache -fv
```

<br>

---

<br>

## Key-Bindings
- Press `Win + Q` to open your `default_terminal` ( Using `kitty` by defualt)
- Press `Win + R` to open `App Launcher` ( Uisng `Walker` )
- Press `Win + C` to terminate an `Application`
- Press `Win + M` to exit `Hyprland`
- Press `Win + L` to perform `Lock Screen` ( Using `Hyprlock` with customized `key-bindings` )
- Press `Crtl + Space` to switch `Language Input` ( Using `Fctix 5` )
- Press `Win + Shift + S` to toggle screenshot ( Using `Grim` )

<br>

---

<br>

## Walker (App Launcher)
- Install dependencies
```bash
yay -S walker-bin elephant-bin
yay -S elephant-providerlist-bin elephant-desktopapplicaations-bin
```
- Add `elephant` to your `Autostart` section in `Hyprland.lua`
```bash
-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/configuring/core/autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function () 
   hl.exec_cmd("nm-applet")
   hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
   hl.exec_cmd("walker")
   hl.exec_cmd("elephant")
end)
```
- Configs your `Kye-Bindings` change your default launcher from `Hyprlauncher` to `Walker`
- Comment out your default `Hyprlauncher` key-bindings and config the key-binding to  launch `Walker`
```bash
---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/configuring/core/binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
-- hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

...

-- Walker
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("walker"))
```

<br>

---

<br>

## Turn on Dark Mode
```bash
# Turns on Dark Mode system wide
# If gsettings is not found: Install glib2 (sudo pacman -S glib2)
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```

<br>

---

<br>

## Wallpaper
- Hyprpaper
```bash
sudo pacman -S hyprpaper
```
### Configure hyprpaper config file
```bash
nano /home/arch/.config/hypr/hyprpaper.conf
```
- Paste these following lines into the `hyprpaper.conf` file
- You may replace `/home/arch/Pictures/wallpaper.jpg` with your own wallpaper path
```bash
reload = /home/arch/Pictures/wallpaper.jpg

wallpaper {
    monitor = eDP-1
    path = /home/arch/Pictures/wallpaper.jpg
}
```
- If you got two display you may need to add one more `wallpaper { ... }` with the monitor name changed
```bash
reload = /home/arch/Pictures/wallpaper.jpg

wallpaper {
    monitor = eDP-1
    path = /home/arch/Pictures/wallpaper.jpg
}

wallpaper {
    monitor = DP-1
    path = /home/arch/Pictures/wallpaper.jpg
}
```

<br>

### Configure the Autostart part in hyprland.lua
```bash
nano /home/arch/.config/hypr/hyprland.lua
```
- Replace the lines in your `Hyprland.lua` under `---- AUTOSTART ----` Section with these following lines
- By adding in `hl.exec_cmd("hyprpaper")`, `Hyprpaper` will be launched automatically each time you start up `Hyprland`
```bash
-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/configuring/core/autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function ()
   hl.exec_cmd("nm-applet")
   hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
   hl.exec_cmd("walker")
   hl.exec_cmd("elephant")
   hl.exec_cmd("hyprpaper")
end)
```
- Prese `Ctrl + O` to save and `Ctrl + X` to exit

<br>

- Reload `Hyprland` to apply changes
```bash
hyprctl reload
```

<br>

---

<br>

## Kitty Configs
- Create `Kitty` config
```bash
mkdir /home/arch/.config/kitty
```
- Create `Kitty.conf`
```bash
nano kitty.conf
```
- `Font size`, `Font Family`, `Scroll back Limits`, `Background Opacity` and `Background Color`
```bash
font_size 14

font_family      JetBrainsMono Nerd Font
bold_font        auto
italic_font      auto
bold_italic_font auto

scrollback_lines 16384000

window_padding_width 10

confirm_os_window_close 0

background_opacity 0.5

background #000000



# Map CJK Unified Ideographs to your preferred Chinese font
symbol_map U+4E00-U+9FFF PingFang SC Bold
symbol_map U+3400-U+4DBF PingFang SC Bold
symbol_map U+20000-U+2A6DF PingFang SC Bold
```

<br>

---

<br>

## Ghostty
- Installation
```bash
sudo pacman -Syu ghostty

# 1. Create the ghostty configuration folder
mkdir -p ~/.config/ghostty

# 2. Open and create the config file as your normal user
nano ~/.config/ghostty/config
```
- Configs
```bash
# --- Font ---
font-family = "JetBrains Mono"
font-size = 15
font-variation = wght=600

# --- Appearance & Window ---
foreground = #ffffff
background = #000000
selection-foreground = #000000
selection-background = #ffffff

# Liquid Glass Visuals
# background-opacity = 0.75
# background-blur-radius = 50

window-padding-x = 10
window-padding-y = 10
window-decoration = false
maximize = true

# --- Cursor ---
cursor-style = block
cursor-style-blink = true

# --- Mouse & Scroll ---
scrollback-limit = 100000000
mouse-hide-while-typing = true

# --- Keybindings ---
keybind = ctrl+d=new_split:right
keybind = ctrl+shift+d=new_split:down
keybind = ctrl+t=new_tab
keybind = ctrl+w=close_surface

# --- Enable xterm-256color ---
term = xterm-256color
```

<br>

---

<br>

## Brightness
- Install brightnessctl
```bash
sudo pacman -S brightnessctl
```
- Reload Hyprland
```bash
hyprctl reload
```

<br>

---

<br>

## Graphical Volume Control
```bash
sudo pacman -S pavucontrol
```

<br>

---

<br>

# Battery Info
- Ensure `upower` Daemon is Running
```bash
# Check UPower Status
systemctl status upower.service

# Enable and Start UPower
sudo systemctl enable --now upower.service
```

<br>

---

<br>

## Hyprlock
- Installation
```bash
sudo pacman -S hyprlock
```
- Create `Hyprlock` config file
```bash
nano ~/.config/hypr/hyprlock.conf
```
- Paste these following lines into the config file
```bash
background {
    monitor =
    path = /home/arch/Pictures/annie-spratt-d8FjB1_8xHQ-unsplash.jpg
    color = rgba(0, 0, 0, 0.0)

    # Glass Blur Configuration
    blur_passes = 3           # More passes create a smoother, heavier glass effect
    blur_size = 8             # Higher size increases the blur radius
    noise = 0.015             # Adds a subtle grain texture common in frosted glass
    contrast = 1.0            # High contrast keeps colors vivid behind the glass
    brightness = 0.8          # Lower brightness mimics tinted or frosted glass
    vibrancy = 0.2            # Enhances colors pushing through the blur
    vibrancy_darkness = 0.0
}

# Time
label {
    monitor =
    text = $TIME
    color = rgb(205, 214, 244) # Text color
    font_size = 90
    font_family = JetBrainsMono Nerd Font Bold
    position = 0, 200
    halign = center
    valign = center
}

# Date
label {
    monitor =
    text = cmd[update:43200000] echo "$(date +"%A, %d %B")"
    color = rgb(1bac, 207, 246)
    font_size = 24
    font_family = JetBrainsMono Nerd Font
    position = 0, 100
    halign = center
    valign = center
}

# Password-Input
input-field {
    monitor =
    size = 250, 60
    outline_thickness = 3
    dots_size = 0.2
    dots_spacing = 0.2
    dots_center = true

    # Border color
    outer_color = rgb(137, 180, 250)
    inner_color = rgb(49, 50, 68)
    font_color = rgb(205, 214, 244)

    fade_on_empty = false
    placeholder_text = <i>Input Password...</i> # Prompt Text
    hide_input = false

    position = 0, -100
    halign = center
    valign = center
}
```
- Add `Hyprlock` key-bindings to your `hyprland.lua`
- Add these following lines under `---- KEYBINDINGS ----` 
```bash
-- Hyprlock
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
```

<br>

---

<br>

## Suspend Function
- Add `keybindings-config` into `hyprland.lua`
```bash
---------------------
---- KEYBINDINGS ----
---------------------

...

-- Suspend/Sleep the laptop
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("systemctl suspend && hyprlock"))
```

<br>

---

<br>

## Fctix 5
- For Chinese Input
```bash
sudo pacman -S fcitx5 fcitx5-configtool fcitx5-chinese-addons fcitx5-gtk fcitx5-qt
```
- Add environment variables to `hyprland.lua`
- Fcitx5 prefers using `Wayland's native input method protocol` instead of forcing applications through these `older input modules`. Having them set can occasionally cause `input glitches` or `warning popups`.
- So it is recommended to commend out these following environments variable
```bash
-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Fcitx5 Framework Input Rules
-- hl.env("IMMODULE", "fcitx")
-- hl.env("XMODIFIERS", "@im=fcitx")
-- hl.env("GTK_IM_MODULE", "fcitx")
-- hl.env("QT_IM_MODULE", "fcitx")
-- hl.env("SDL_IM_MODULE", "fcitx")
-- hl.env("GLFW_IM_MODULE", "ibus") -- Fallback for specific GLFW windows
```
- Add Autostart Fctix5 Deamon
```bash
-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/configuring/core/autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function () 
   hl.exec_cmd("nm-applet")
   hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
   hl.exec_cmd("walker")
   hl.exec_cmd("elephant")
   hl.exec_cmd("hyprpaper")
   hl.exec_cmd("fcitx5 -d")
end)
```

### Steps to add Chinese input
- Launch Fcitx 5 Configuration
- Search for `Chinese Pinyin` using the Search bar under `Available Input Methods:`
- Add the Pinyin input method by pressing the `left arrow` button
- Now the `Pinyin` will shows up at the left side panel bellow your `English` Input
- You may press on the settings button to change how many candidates will shows each time
- You may also navigate to `Addons`
- Press the `Configure` button next of `Classic User Interface`
- You may change your `Font Type and Font Size`
- You may also change the theme to `dark or light`

<br>

---

<br>

## Display Configs
- Changing the `resolution` and `refresh-rate`
```bash
------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/configuring/core/monitors/
-- hyprland.lua
-- Native Hyprland Lua monitor and switch configurations

-- 1. Default Monitor Layouts (Keep laptop screen enabled by default)
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@180",
    position = "auto",
    scale    = "1",
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "preferred",
    position = "auto-right",
    scale = "1"
})

hl.monitor({
    output = "DP-1",
    mode = "2560x1440@144",
    position = "auto-right",
    scale = "1",
    transform = 2
})
```

<br>

---

<br>

## Screenshot function
### Grim
- Install Dependencies
```bash
sudo pacman -S grim slurp wl-clipboard libnotify
```
- Paste these following lines into `Hyprland.lua` file under `---- KEYBINDINGS ----` section
```bash
-- Screenshot
-- Super + Shift + S: Region capture to clipboard
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("sh -c 'grim -g \"$(slurp)\" - | wl-copy'"))
-- Shift + Print: Full screen capture saved to ~/Pictures
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("sh -c 'grim ~/Pictures/$(date +%Y-%m-%d_%H-%M-%S).png'"))
```

<br>

---

<br>

## Resolve lid switch via native lua eval ( Lid Switching Handling)
- Add these following lines in `hyprland.lua` under your `---- Monitor ----` section to switch on and off your laptop lid automatically
```bash
-- 2. Lid Switch Handling (Dynamic Laptop Screen Control)

-- Trigger when the switch is turning on (Lid Closed) -> Turn off eDP-1
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd('hyprctl eval "hl.monitor({ output = \\"eDP-1\\", disabled = true })"'), { locked = true })

-- Trigger when the switch is turning off (Lid Opened) -> Restore eDP-1
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd('hyprctl eval "hl.monitor({ output = \\"eDP-1\\", disabled = false, mode = \\"preferred\\", position = \\"auto\\", scale = 1 })"'), { locked = true })
```

<br>

### Further Explainations
```text
Standard layout commands throw an unknown request error in newer Hyprland versions, and the inline Lua functions get stuck in the compositor loop. Executing a shell-level hyprctl eval using a native hardware keybind forces the compositor to dynamically update its display state instantly.
```

<br>

---

<br>

## Bluetooth Configs
- `Overskride` and `Bluez`
```bash
yay -S overskride-bin

sudo systemctl enable --now bluetooth
sudo systemctl start bluetooth

sudo pacman -S bluez
```

<br>

---

<br>

## Quickshell (Optional)
- Installation
```bash
sudo pacman -S quickshell
# or
yay -S quickshell
```
- Add `quickshell` to your `---- AUTOSTART ----` section in `hyprland.lua`
```bash
-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/configuring/core/autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function () 
   hl.exec_cmd("nm-applet")
   hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
   hl.exec_cmd("walker")
   hl.exec_cmd("elephant")
   hl.exec_cmd("hyprpaper")
   hl.exec_cmd("fcitx5 -d")
   hl.exec_cmd("quickshell")
end)
```
- Create the `quickshell` folder and `shell.qml`
- This is an example `quickshell` configs which just include a simple `clock` function
```bash
cd /home/arch/.config

mkdir quickshell
cd quickshell

nano shell.qml
```
- `Quickshell` Configs
```bash
import Quickshell
import Quickshell.Io
import QtQuick

PanelWindow {
  id: root

  anchors.top: true
  anchors.left: true
  anchors.right: true

  implicitHeight: 45
  color: "transparent"

  // Dynamically change the exclusive zone: 
  // Reserves 45px when shown, but drops to 0px when hidden to remove the gap.
  exclusiveZone: root.shouldShow ? 45 : 0

  // Invisible trigger zone spanning the top edge of the screen
  MouseArea {
    id: edgeTrigger
    anchors.fill: parent
    hoverEnabled: true
    acceptedButtons: Qt.NoButton
  }

  // Show if either the top edge or the pill itself is hovered
  readonly property bool shouldShow: edgeTrigger.containsMouse || pill.hovered

  Rectangle {
    id: pill
    property bool hovered: mouse.containsMouse

    anchors.horizontalCenter: parent.horizontalCenter
    
    // Slide up out of bounds when hidden (-40), slide down when shown (5)
    y: root.shouldShow ? 5 : -40

    width: hovered ? 180 : 150
    height: 30
    radius: height / 2
    color: hovered ? "#6f9bf3" : "#1b1b1b"

    Behavior on y {
      NumberAnimation { duration: 250; easing.type: Easing.OutBack }
    }

    Behavior on width {
      NumberAnimation { duration: 250; easing.type: Easing.OutBack }
    }

    Behavior on color {
      ColorAnimation { duration: 250; easing.type: Easing.OutBack }
    }

    Text {
      id: clock
      anchors.centerIn: parent
      color: mouse.containsMouse ? "#000000" : "#ffffff"
      font.weight: 700
      font.pixelSize: 14

      Behavior on color {
        ColorAnimation { duration: 250; easing.type: Easing.OutBack }
      }
    }

    MouseArea {
      id: mouse
      anchors.fill: parent
      hoverEnabled: true
    }

    Process {
      id: dateProc
      command: ["date", "+%I:%M %p"]
      running: true

      stdout: StdioCollector {
        onStreamFinished: clock.text = this.text.trim()
      }
    }

    Timer {
      interval: 1000
      running: true
      repeat: true
      onTriggered: dateProc.running = true
    }
  }
}
```

<br>

---

<br>

## Final Hyprland Config
- **Gaps:** Set `gaps_in` and `gaps_out` to `0` for a seamless, gapless layout.
- **Mouse Sensitivity:** Adjusted sensitivity to `0.5` for smoother cursor control.    
- **Autostart:** Un-commented the autostart commands to launch applications automatically on boot.
- **Font Configuration:** Added font settings (feel free to customize the font family and size to your preference).
- For me I didn't like the concept of any type of `taskbar` just like `quickshell`. Therefor, I will not be using `quickshell` as my top bar. The `quickshell-workflow` which previously showed is just a `reference` for those who will going to use `Quickshell`
```bash
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- AUTOGENERATED HYPRLAND CONFIG.                        --
-- EDIT THIS CONFIG ACCORDING TO THE WIKI INSTRUCTIONS.  --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --


-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/configuring/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/configuring/core/monitors/
-- hyprland.lua
-- Native Hyprland Lua monitor and switch configurations

-- 1. Default Monitor Layouts (Keep laptop screen enabled by default)
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@180",
    position = "auto",
    scale    = "1",
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "preferred",
    position = "auto-right",
    scale = "1"
})

hl.monitor({
    output = "DP-1",
    mode = "2560x1440@144",
    position = "auto-right",
    scale = "1",
    transform = 2
})

-- 2. Lid Switch Handling (Dynamic Laptop Screen Control)

-- Trigger when the switch is turning on (Lid Closed)
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd('hyprctl eval "hl.monitor({ output = \\"eDP-1\\", disabled = true })"'), { locked = true })

-- Trigger when the switch is turning off (Lid Opened)
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd('hyprctl eval "hl.monitor({ output = \\"eDP-1\\", disabled = false, mode = \\"preferred\\", position = \\"auto\\", scale = 1 })"'), { locked = true })



---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "nautilus"
local menu = "hyprlauncher"


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/configuring/core/autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function ()
   hl.exec_cmd("nm-applet")
   hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
   hl.exec_cmd("walker")
   hl.exec_cmd("elephant")
   hl.exec_cmd("hyprpaper")
   hl.exec_cmd("fcitx5 -d")
   hl.exec_cmd("flatpak run com.github.wwmm.easyeffects --gapplication-service")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/configuring/core/environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Fcitx5 Framework Input Rules
-- hl.env("IMMODULE", "fcitx")
-- hl.env("XMODIFIERS", "@im=fcitx")
-- hl.env("GTK_IM_MODULE", "fcitx")
-- hl.env("QT_IM_MODULE", "fcitx")
-- hl.env("SDL_IM_MODULE", "fcitx")
-- hl.env("GLFW_IM_MODULE", "ibus") -- Fallback for specific GLFW windows



-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/configuring/core/advanced-configuration/permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/configuring/core/config-options/
hl.config({
    general = {
        gaps_in  = 0,
        gaps_out = 0,

        border_size = 0,

        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/configuring/extra/tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        -- rounding       = 2,
        -- rounding_power = 10,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = True,
    },

    misc = {
        -- Combines your Nerd Font for English/symbols with a Chinese fallback font
        font_family = "JetBrainsMono Nerd Font, Noto Sans CJK SC",

        -- Optional: background splash text font
        splash_font_family = "JetBrainsMono Nerd Font",
    },

    group = {
        groupbar = {
            -- Tab and group titles font
            font_family = "JetBrainsMono Nerd Font",
            font_size = 12,
        }
    }
})

-- Font Configs for System-Wide (GTK / Application Apps)
hl.exec_cmd("gsettings set org.gnome.desktop.interface font-name 'PingFang SC Bold 12'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font, PingFang SC Bold 12'")

-- Default curves and animations, see https://wiki.hypr.land/configuring/core/animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 238.1191, damping = 24.21279333 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

-- Ref https://wiki.hypr.land/configuring/core/rules/workspace-rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/configuring/layouts/dwindle-layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/configuring/layouts/master-layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/configuring/layouts/scrolling-layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
        font_family = "JetBrainsMono Nerd Font"
    },
})


----------------
---- LAYERS ----
----------------

hl.config({
    layers = {
        allow_new_top_layers_over_existing_fullscreen = true, -- Set to false to make newly mapped top layers render below existing covering fullscreen window
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0.5, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/configuring/core/devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/configuring/core/binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("ghostty"))
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
-- hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Hyprlock
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- Screenshot
-- Grim
-- Super + Shift + S: Region capture to clipboard
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("sh -c 'grim -g \"$(slurp)\" - | wl-copy'"))
-- Shift + Print: Full screen capture saved to ~/Pictures
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("sh -c 'grim ~/Pictures/$(date +%Y-%m-%d_%H-%M-%S).png'"))

-- Walker
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("walker"))

-- Suspend/Sleep the laptop
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("systemctl suspend && hyprlock"))

-- Toggle Fullscreen
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())



--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/configuring/core/rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
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

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})
```
