{ config, pkgs, ... }:

{

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
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
        ".local/bin/configure-monitors.sh" = {
            executable = true;
            text = ''
            #!/bin/sh
            wlr-randr --output HDMI-A-1 --pos 0,0 --transform 270 --output DP-1 --pos 1080,300 --adaptive-sync enabled --output DP-2 --pos 3640,577
            wlr-randr --output DP-1 --mode 2560x1440@120.029999Hz --adaptive-sync enabled 
            '';
        };
        ".local/bin/screen-toggle.sh" = {
            executable = true;
            text = ''
            #!/bin/sh
            wlopm --toggle DP-1 --toggle DP-2 --toggle HDMI-A-1
            '';
        };
        ".local/bin/setup-swayidle.sh" = {
            executable = true;
            text = ''
            #!/bin/sh
            swayidle -w \
                timeout 900 'wlopm --off DP-1 --off DP-2 --off HDMI-A-1' \
                    resume 'wlopm --on DP-1 --on DP-2 --on HDMI-A-1' \
                timeout 1800 '/home/ki11errabbit/.local/bin/lockscreen.sh' \
                    resume 'wlopm --on DP-1 --on DP-2 --on HDMI-A-1' \
                before-sleep '/home/ki11errabbit/.local/bin/lockscreen.sh' &
            '';
        };
        ".local/bin/wallpaper-wayland.sh" = {
            executable = true;
            text = ''
            #!/bin/sh
            case $1 in
                start) while true; do
                        /home/ki11errabbit/.local/bin/wallpaper-wayland.sh

                        sleep 300
                    done
                    ;;
                *);;
            esac


            widepapers="$HOME/Pictures/Wallpapers/Widepapers/"
            widepapers_list="$HOME/widepapers_list.txt"
            tallpapers="$HOME/Pictures/Wallpapers/Tallpapers/"
            tallpapers_list="$HOME/tallpapers_list.txt"

            # $1 label
            # $2 wallpaper list
            # $3 wallpaper dir
            function select_wallpaper () {
                if [[ $(stat --printf="%s" "$2") == "0" ]]; then
                    find "$3" -name "*.png" -or -name "*.jpeg" -or -name "*.jpg" -or -name "*.webm" -or -name "*.mp4" | shuf > "$2"
                    file=$(cat $2 | head -n 1)
                else 
                    file=$(cat $2 | head -n 1)
                fi
                exec 19<> "$2"
                tail -n +2 "$2" >&19 
                exec 19>&-
                echo "$1: $file" >> $HOME/wallpaper.log
                echo "$file"

            }


            file1=$(select_wallpaper "wide1" $widepapers_list $widepapers)
            file2=$(select_wallpaper "wide2" $widepapers_list $widepapers)
            file3=$(select_wallpaper "tall" $tallpapers_list $tallpapers)


            # $1 display
            # $2 file
            function apply_wallpaper () {
                case $2 in
                    *.png|*.jpeg|*.jpg)
                        swaybg -o $1 -i "$2" -m fill  &
                        ;;
                    *.webm|*.mp4)
                        mpvpaper -o "no-audio loop" $1 "$2" &
                        ;;
                esac
            }

            pkill swaybg
            pkill mpvpaper
            pkill .mpvpaper-wrapp
            apply_wallpaper "DP-1" "$file1"
            apply_wallpaper "DP-2" "$file2"
            apply_wallpaper "HDMI-A-1" "$file3"
            '';
        };
        ".local/bin/lockscreen.sh" = {
            executable = true;
            text = ''
            #!/bin/sh

            widepapers="$HOME/Pictures/Wallpapers/Widepapers/"
            widepapers_list="$HOME/widepapers_list_lockscreen.txt"
            tallpapers="$HOME/Pictures/Wallpapers/Tallpapers/"
            tallpapers_list="$HOME/tallpapers_list_lockscreen.txt"

            # $1 label
            # $2 wallpaper list
            # $3 wallpaper dir
            # $4 display
            function select_wallpaper () {
                if [[ $(stat --printf="%s" "$2") == "0" ]]; then
                    find "$3" -name "*.png" -or -name "*.jpeg" -or -name "*.jpg" | shuf -o "$2"
                    file=$(cat $2 | head -n 1)
                else 
                    file=$(cat $2 | head -n 1)
                fi
                exec 19<> "$2"
                tail -n +2 "$2" >&19 
                exec 19>&-
                echo "$1: $file" >> $HOME/lockscreen.log
                echo "$4:$file"

            }


            file1=$(select_wallpaper "wide1" "$widepapers_list" "$widepapers" DP-1)
            file2=$(select_wallpaper "wide2" "$widepapers_list" "$widepapers" DP-2)
            file3=$(select_wallpaper "tall" "$tallpapers_list" "$tallpapers" HDMI-A-1)

            swaylock -ef -i "$file1" -i "$file2" -i "$file3"
            '';
        };
        ".local/bin/setup-keyboard.sh" = {
            executable = true;
            text = ''
            #!/bin/sh
            '';
        };
        ".local/bin/setup-wallpaper.sh" = {
            executable = true;
            text = ''
            #!/bin/sh
            /home/ki11errabbit/.local/bin/wallpaper-wayland.sh start &
            '';
        };
        ".config/fnott/fnott.ini".text = ''
            # -*- conf -*-

            # For documentation on these options, see `man fnott.ini`

            # Global values
             output=DP-2
            # min-width=0
            # max-width=400
            # max-height=200
            # stacking-order=bottom-up
             anchor=top-left
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
                   "output": "DP-1",
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
                   "modules-left": ["dwl/tags", "dwl/window", "river/tags", "river/mode", "river/window"],
                   "output": "DP-2",
                   // The empty 'DP-2' argument used in the following "exec": fields works for single-monitor setups
                   // For multi-monitor setups, see https://github.com/Alexays/Waybar/wiki/Configuration
                   //     and enter the monitor id (like "eDP-1") as the first argument to waybar-dwl.sh
                   "modules-right": ["tray", "custom/kernel", "custom/pipewire","clock"],
                "dwl/tags": {
                    "num-tags": 9,
                },
                "dwl/window": {
                    "format": "{layout} {title}",
                },
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
                   "modules-left": ["dwl/tags", "dwl/window", "river/tags", "river/mode", "river/window"],
                   "output": "HDMI-A-1",
                   // The empty 'HDMI-A-1' argument used in the following "exec": fields works for single-monitor setups
                   // For multi-monitor setups, see https://github.com/Alexays/Waybar/wiki/Configuration
                   //     and enter the monitor id (like "eHDMI-A-1") as the first argument to waybar-dwl.sh
                   "modules-right": ["custom/kernel", "custom/pipewire","clock"],
                "dwl/tags": {
                    "num-tags": 9,
                },
                "dwl/window": {
                    "format": "{layout} {title}",
                },
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
        ".config/waybar/style.css".text = ''
            * {
                all: unset;
                font-family: "LiterationMono Nerd Font", "monospace";
            }

            window#waybar {
              background-color: #282c34;
              color: #bbc2cf;
              padding-left:10px;
              padding-right:10px;
              /*border-radius: 10px;*/
              /*border: 2px solid #51afef;*/
            }

            #tray menu {
              background-color: #282c34;
              color: #bbc2cf;
              padding-left:10px;
              padding-right:10px;
              /*border-radius: 10px;*/
              /*border: 2px solid #51afef;*/
            }

            #tray menu button:hover {
                color: #444b59;
                background-color: #51afef;
            }

            #clock {
              margin-left: 3px;
              padding-left: 4px;
            }

            #custom-sysmenu {
              margin-left: 3px;
              margin-right: 3px;
                padding-left: 4px;
                padding-right: 4px;
            }
            #custom-kernel {
                padding-left: 4px;
                padding-right: 4px;
              margin-left: 3px;
              margin-right: 3px;
            }

            #custom-dwl_layout {
              color: #bbc2cf;
             }

             #custom-dwl_title {
                 color: #444b59;
                 background-color: #51afef;
                 padding-left: 2px;
                 padding-right: 2px;
             }

             #custom-dwl_tag {
                 color: #bbc2cf;
             }

             #custom-dwl_tag:hover {
                 color: #444b59;
                 background-color: #bbc2cf;
             }
             #custom-dwl_tag.selected {
                 color: #444b59;
                 background-color: #51afef;
             }
             #custom-dwl_tag.selected.active:hover {
                 border-top: 1px solid #51afef;
                 background-color: #c678dd;
                 color: #444b59;
             }

             #custom-dwl_tag.urgent {
                 background-color: #ff6c6b;
             }

             #custom-dwl_tag.active {
                 border-top: 1px solid #c678dd;
             }
             #custom-dwl_tag.active:hover {
                 border-top: 1px solid #c678dd;
             }
             
            #tags button {
               color: #bbc2cf;
                padding-left: 4px;
                padding-right: 4px;
            }

            #tags button:hover {
                color: #444b59;
                background-color: #51afef;
            }

            #tags button.occupied {
                  color: #444b59;
                  background-color: #bbc2cf;
            }


            #tags button.focused {
                  color: #444b59;
                  background-color: #51afef;
            }


            #tags button:hover {
                color: #444b59;
                background-color: #51afef;
            }

            #mode {
              margin-left: 3px;
              padding-left: 4px;
            margin-right: 3px;
            padding-right: 4px;

            }

            #window {
              background-color: #282c34;
              color: #bbc2cf;
              padding-left:10px;
              padding-right:10px;
            }

            #window.focused {
              color: #282c34;
              background-color: #51afef;
              padding-left:10px;
              padding-right:10px;
            }
        '';
    };

    nixpkgs.config.packageOverrides = pkgs: {
        steam = pkgs.steam.override {
            extraPkgs = pkgs: with pkgs; [
                xorg.libXcursor
                xorg.libXi
                xorg.libXinerama
                xorg.libXScrnSaver
                libpng
                libpulseaudio
                libvorbis
                stdenv.cc.cc.lib
                libkrb5
                keyutils
            ];
        };
    };

    home.packages = with pkgs; [
        zoom-us
        pcsx2
        rpcs3
        lutris
        gnome-boxes
        freecad
        librecad
        #kicad
        r2modman
        prismlauncher
        burpsuite
        blender
        arduino-ide
    ];
    
}
