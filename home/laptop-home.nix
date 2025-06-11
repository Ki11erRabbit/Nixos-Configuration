
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
        ".local/bin/setup-keyboard.sh" = {
            executable = true;
            text = ''
            #!/bin/sh
            model=$(sudo /run/current-system/sw/bin/dmidecode | grep 'Version: ThinkPad' | awk '{print $3}')


            case $model in
                T440p) kmonad /home/ki11errabbit/.config/kmonad/t44p.kbd ;;
                T480s) kmonad /home/ki11errabbit/.config/kmonad/t480s.kbd || sudo /run/current-system/sw/bin/kmonad /home/ki11errabbit/.config/kmonad/t480s.kbd ;;
                T480) kmonad /home/ki11errabbit/.config/kmonad/t480.kbd || sudo /run/current-system/sw/bin/kmonad /home/ki11errabbit/.config/kmonad/t480.kbd ;;
		        X230) kmonad /home/ki11errabbit/.config/kmonad/x230t.kbd ;;
		        T430s) kmonad /home/ki11errabbit/.config/kmonad/t430s-mod.kbd || sudo /run/current-system/sw/bin/kmonad /home/ki11errabbit/.config/kmonad/t430s-mod.kbd ;;
            esac
            '';
        };
        ".local/bin/setup-wallpaper.sh" = {
            executable = true;
            text = ''
            #!/bin/sh
            swaybg -i /home/ki11errabbit/Pictures/Wallpapers/2588341_tistan01_thinkpad-wallpaper-2.png &
            '';
        };
    };
}
