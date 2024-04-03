{ config, pkgs, ... }:

{

    home.file = {
        # # Building this configuration will create a copy of 'dotfiles/screenrc' in
        # # the Nix store. Activating the configuration will then make '~/.screenrc' a
        # # symlink to the Nix store copy.
        # ".screenrc".source = dotfiles/screenrc;

        # # You can also set the file content immediately.
        # ".gradle/gradle.properties".text = ''
        #   org.gradle.console=verbose
        #   org.gradle.daemon.idletimeout=3600000
        # '';
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
                timeout 1000 '/home/ki11errabbit/.local/bin/lockscreen.sh' \
                    resume 'wlopm --on eDP-1' \
                before-sleep '/home/ki11errabbit/.local/bin/lockscreen.sh' &
            '';
        };
        ".local/bin/lockscreen.sh" = {
            executable = true;
            text = ''
            #!/bin/sh


            swaylock -ef -i "eDP-1:/home/ki11errabbit/Pictures/Wallpapers/2588341_tistan01_thinkpad-wallpaper-2.png"
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
                   "modules-left": ["river/tags", "river/mode", "river/window"],
                   "output": "eDP-1",
                   // The empty 'DP-1' argument used in the following "exec": fields works for single-monitor setups
                   // For multi-monitor setups, see https://github.com/Alexays/Waybar/wiki/Configuration
                   //     and enter the monitor id (like "eDP-1") as the first argument to waybar-dwl.sh
                   "modules-right": ["tray", "battery", "custom/kernel", "custom/pipewire","clock"],
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
