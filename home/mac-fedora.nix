{ config, pkgs, ... }:

{

    /*wayland.windowManager.sway = {
        config.workspaceOutputAssign = [
            { workspace = "1"; output = "eDP-1"; }
            { workspace = "2"; output = "eDP-1"; }
            { workspace = "3"; output = "eDP-1"; }
            { workspace = "4"; output = "eDP-1"; }
            { workspace = "5"; output = "eDP-1"; }
            { workspace = "6"; output = "eDP-1"; }
            { workspace = "7"; output = "eDP-1"; }
            { workspace = "8"; output = "eDP-1"; }
            { workspace = "9"; output = "eDP-1"; }
            { workspace = "10"; output = "eDP-1"; }
        ];
    };*/

    home.file = {
        ".local/bin/configure-monitors.sh" = {
            executable = true;
            text = ''
            #!/bin/sh
            '';
        };
        ".local/bin/rotate-screen.sh" = {
            executable = true;
            text = ''
            #!/bin/sh
            '';
        };
        ".local/bin/screen-toggle.sh" = {
            executable = true;
            text = ''
            #!/bin/sh
            wlopm --toggle eDP-1
            '';
        };
        ".local/bin/setup-swayidle.sh" = {
            executable = true;
            text = ''
            #!/bin/sh
            swayidle -w \
                timeout 900 'wlopm --off eDP-1' \
                    resume 'wlopm --on eDP-1' \
                timeout 1800 '/home/ki11errabbit/.local/bin/lockscreen.sh' \
                    resume 'wlopm --on eDP-1' \
                before-sleep '/home/ki11errabbit/.local/bin/lockscreen.sh' &
            '';
        };
        ".local/bin/lockscreen.sh" = {
            executable = true;
            text = ''
            #!/bin/sh


            swaylock -ef -i "eDP-1:/home/ki11errabbit/Pictures/Wallpapers/asahi_logomark_white.png
            '';
        };
        ".local/bin/setup-wallpaper.sh" = {
            executable = true;
            text = ''
            #!/bin/sh
            swaybg -i /home/ki11errabbit/Pictures/Wallpapers/asahi_logomark_white.png &
            '';
        };
        ".config/fnott/fnott.ini".text = ''
            # -*- conf -*-

            # For documentation on these options, see `man fnott.ini`

            # Global values
             output=eDP-1
            # min-width=0
            # max-width=400
            # max-height=200
            # stacking-order=bottom-up
             anchor=top-right
             edge-margin-vertical=30
             edge-margin-horizontal=10
            # notification-margin=10
            # icon-theme=hicolor
            # max-icon-size=32
            # selection-helper=dmenu
            # play-sound=aplay '$'{filename'}
            # layer=top


            # Default values, may be overridden in 'urgency' specific sections
            border-size=2

            padding-vertical=20
            padding-horizontal=20

            title-font=sans serif
            # title-color=ffffffff
            # title-format=<i>%a%A</i>

            summary-font=sans serif:size=8
            # summary-color=ffffffff
            # summary-format=<b>%s</b>\n

            body-font=sans serif:size=10
            # body-color=ffffffff
            # body-format=%b

            # progress-bar-height=20
            # progress-bar-color=ffffffff

            # sound-file=

            # Timeout values are in seconds. 0 to disable
            # max-timeout=0
            default-timeout=5

            title-color=6c6f85ff
            summary-color=4c4f69ff
            body-color=4c4f69ff
            background=eff1f5ff
            border-color=ea76cbff
            progress-bar-color=9ca0b0ff

            [critical]
            border-color=fe640bff
        '';
        ".config/waybar/config".text = ''
             [ {
                   // "modules-left": ["dwl/tags", "dwl/window", "river/tags", "river/mode", "river/window"],
                    "modules-left": ["dwl/tags", "dwl/window"],
                   "output": "eDP-1",
                   // The empty 'DP-1' argument used in the following "exec": fields works for single-monitor setups
                   // For multi-monitor setups, see https://github.com/Alexays/Waybar/wiki/Configuration
                   //     and enter the monitor id (like "eDP-1") as the first argument to waybar-dwl.sh
                   "modules-right": ["tray", "battery", "custom/kernel", "custom/pipewire","clock"],
                "dwl/tags": {
                    "num-tags": 9,
                },
                "dwl/window": {
                    "format": "{layout} {title}",
                },
                "river/tags": {
                    "num-tags": 9,
                },
                "river/mode": {
                    "format": "{}",
                },
                "river/window": {
                    "format": "{}",
                },
                "sway/workspaces": {
                    "persistent-workspaces": {
                        "11": "eDP-1",
                        "12": "eDP-1",
                        "13": "eDP-1",
                        "14": "eDP-1",
                        "15": "eDP-1",
                        "16": "eDP-1",
                        "17": "eDP-1",
                        "18": "eDP-1",
                        "19": "eDP-1",
                        "20": "eDP-1",
                    }
                },
                "sway/mode": {
                    "format": "{mode}"
                },
                "tray": {
                        "icon-size": 21,
                        "spacing": 5
                    },
                "battery": {
                    "bat": "macsmc-battery",
                        "format": "internal: {icon}  {capacity}",
                        "format-icons": ["", "", "", "", ""]
                    },
                "clock": {
                    "interval": 1,
                    "format": "{:%I:%M%p %b %d, %Y}",
                  },
                "custom/pipewire": {
                    "tooltip": false,
                    "max-length": 12,
                    "signal": 8,
                    "restart-interval": 0,
                    "exec": "$HOME/.config/waybar/scripts/pipewire.sh",
                    "on-click": "pavucontrol &"
                },
                "custom/weather": {
                    "format": "{}",
                    "tooltip": false,
                    "max-length": 6,
                    "signal": 9,
                    "interval":3600,
                    "exec": "$HOME/.config/waybar/scripts/weather.sh 0",
                    "on-click": "$HOME/.config/waybar/scripts/weather.sh 1"
                },
                "custom/kernel": {
                    "format": "{icon} {}",
                    "format-icons": "🐧",
                    "tooltip": false,
                    "interval":"once",
                    "exec": "uname -r",
                },
                 },
                 ]
        '';
    };
}

