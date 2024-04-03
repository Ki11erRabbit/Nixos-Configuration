
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
		        X230) kmonad /home/ki11errabbit/.config/kmonad/x230t.kbd ;;
		        T430s) kmonad /home/ki11errabbit/.config/kmonad/t430s-mod.kbd ;;
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
}
