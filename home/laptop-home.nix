
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
        ".local/bin/configure-monitors.sh".text = ''
            #!/bin/sh
        '';
        ".local/bin/screen-toggle.sh".text = ''
            #!/bin/sh
            wlopm --toggle eDP-1
        '';
        .local/bin/setup-swayidle.sh".text = ''
            #!/bin/sh
            swayidle -w \
                timeout 900 'wlopm --off eDP-1' \
                    resume 'wlopm --on eDP-1' \
                timeout 1000 '/home/ki11errabbit/.local/bin/lockscreen.sh' \
                    resume 'wlopm --on eDP-1' \
                before-sleep '/home/ki11errabbit/.local/bin/lockscreen.sh' &
        '';
        ".local/bin/lockscreen.sh".text = ''
            #!/bin/sh


            swaylock -ef -i "eDP-1:/home/ki11errabbit/Pictures/Wallpapers/2588341_tistan01_thinkpad-wallpaper-2.png"
        '';
        .local/bin/setup-keyboard.sh".text = ''
            #!/bin/sh
            model=$(sudo /run/current-system/sw/bin/dmidecode | grep Version | head -n 2 | tail -n 1 | awk '{print $3}')


            case $model in
                T440p) kmonad /home/ki11errabbit/.config/kmonad/t44p.kbd ;;
            esac
        '';
        ".local/bin/setup-wallpaper.sh".text = ''
            #!/bin/sh
            swaybg -i /home/ki11errabbit/Pictures/Wallpapers/2588341_tistan01_thinkpad-wallpaper-2.png &
        '';
        .config/fnott/fnott.ini = ''
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
    };
}
