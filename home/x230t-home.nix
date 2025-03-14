{ config, pkgs, ... }:

{
    home.file = {
        ".local/bin/configure-monitors.sh" = {
            executable = true;
            text = ''
            #!/bin/sh
            echo "normal" > /tmp/screen-orientation
            '';
        };
        ".local/bin/rotate-screen.sh" = {
            executable = true;
            text = ''
            #!/bin/sh
            orientation=$(cat /tmp/screen-orientation)
            rotateRiver() {
                case $orientation in
                    normal) wlr-randr --output LVDS-1 --transform 270; echo "270" > /tmp/screen-orientation ;;
                    270) wlr-randr --output LVDS-1 --transform 180; echo "180" > /tmp/screen-orientation ;;
                    180) wlr-randr --output LVDS-1 --transform 90; echo "90" > /tmp/screen-orientation ;;
                    90) wlr-randr --output LVDS-1 --transform normal; echo "normal" > /tmp/screen-orientation ;;
                esac
            }
            rotatePlasma() {
                case $orientation in
                    normal) kscreen-doctor output.1.rotation.right; echo "270" > /tmp/screen-orientation ;;
                    270) kscreen-doctor output.1.rotation.inverted; echo "180" > /tmp/screen-orientation ;;
                    180) kscreen-doctor output.1.rotation.left; echo "90" > /tmp/screen-orientation ;;
                    90) kscreen-doctor output.1.rotation.normal; echo "normal" > /tmp/screen-orientation ;;
                    *) kscreen-doctor output.1.rotation.right; echo "270" > /tmp/screen-orientation ;;
                esac
            }
            case $XDG_CURRENT_DESKTOP in 
                River) rotateRiver ;;
                KDE) rotatePlasma ;;
                *) rotateRiver ;;
            esac
            '';
        };
        ".local/bin/screen-toggle.sh" = {
            executable = true;
            text = ''
            #!/bin/sh
            wlopm --toggle LVDS-1
            '';
        };
        ".local/bin/setup-swayidle.sh" = {
            executable = true;
            text = ''
            #!/bin/sh
            swayidle -w \
                timeout 900 'wlopm --off LVDS-1' \
                    resume 'wlopm --on LVDS-1' \
                timeout 1000 '/home/ki11errabbit/.local/bin/lockscreen.sh' \
                    resume 'wlopm --on LVDS-1' \
                before-sleep '/home/ki11errabbit/.local/bin/lockscreen.sh' &
            '';
        };
        ".local/bin/lockscreen.sh" = {
            executable = true;
            text = ''
            #!/bin/sh


            swaylock -ef -i "LVDS-1:/home/ki11errabbit/Pictures/Wallpapers/2588341_tistan01_thinkpad-wallpaper-2.png"
            '';
        };
        ".config/fnott/fnott.ini".text = ''
            # -*- conf -*-

            # For documentation on these options, see `man fnott.ini`

            # Global values
             output=LVDS-1
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
             background=282c34ff

             border-color=51afefff
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

            # [low]
            # background=2b2b2bff
            # title-color=888888ff
            # summary-color=888888ff
            # body-color=888888ff

            # [normal]

            # [critical]
            # background=6c3333ff


        '';
        ".config/waybar/config".text = ''
             [ {
                   "modules-left": ["dwl/tags", "dwl/window", "river/tags", "river/mode", "river/window"],
                   "output": "LVDS-1",
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
                "tray": {
                        "icon-size": 21,
                        "spacing": 5
                    },
                "battery": {
                        "format": "{icon}  {capacity}",
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

              {
                   "modules-left": ["river/tags", "river/mode", "river/window"],
                   "output": "DP-2",
                   // The empty 'DP-2' argument used in the following "exec": fields works for single-monitor setups
                   // For multi-monitor setups, see https://github.com/Alexays/Waybar/wiki/Configuration
                   //     and enter the monitor id (like "eDP-1") as the first argument to waybar-dwl.sh
                   "modules-right": ["tray", "custom/kernel", "custom/pipewire","clock"],
                "river/tags": {
                    "num-tags": 9,
                },
                "tray": {
                        "icon-size": 21,
                        "spacing": 5
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
              {
                   "modules-left": ["river/tags", "river/mode", "river/window"],
                   "output": "HDMI-A-1",
                   // The empty 'HDMI-A-1' argument used in the following "exec": fields works for single-monitor setups
                   // For multi-monitor setups, see https://github.com/Alexays/Waybar/wiki/Configuration
                   //     and enter the monitor id (like "eHDMI-A-1") as the first argument to waybar-dwl.sh
                   "modules-right": ["custom/kernel", "custom/pipewire","clock"],
                "river/tags": {
                    "num-tags": 9,
                },
                "tray": {
                        "icon-size": 21,
                        "spacing": 5
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
                 }

                 ]
        '';
    };
}
