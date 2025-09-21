
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
    };

    wayland.windowManager.mango = {
        enable = true;
        settings = ''
shadows=1
layer_shadows=1
gappoh=5
appov=10
borderpx=2

xkb_rules_layout=us
xkb_rules_variant=colemak_dh

tap_to_click=0
trackpad_natural_scrolling=1

rootcolor=0xeff1f5ff
bordercolor=0x9ca0b0ff
focuscolor=0xea76cbff
urgentcolor=0xd20f39ff
scratchpadcolor=0x9ca0b0ff
globalcolor=0x9ca0b0ff
coverlayercolor=0x9ca0b0ff

windowrule=isterm:1,appid:Alacritty
windowrule=isterm:1,appid:Foot
windowrule=isterm:1,appid:foot
windowrule=isterm:1,appid:FootClient

monitorrule=eDP-1,0.55,1,tile,0,1.5,1,0,3456,2160,0

exec-once=waybar
exec-once=fnott
exec-once=configure-monitors.sh
exec-once=setup-wallpaper.sh
exec-once=setup-swayidle.sh
exec-once=setup-keyboard.sh
exec-once=nm-applet
exec-once=blueman-applet
exec-once=kdeconnect-indicator

bind=SUPER,q,killclient
bind=SUPER,Return,spawn,foot
bind=SUPER,d,spawn,bemenu-run
bind=SUPER,r,spawn,nemo
bind=SUPER,s,spawn,grimshot save area
bind=SUPER+SHIFT,s,spawn,grimshot copy area
bind=SUPER+SHIFT,Return,spawn,emacsclient -c -a 'emacs'

bind=SUPER,n,focusstack,next
bind=SUPER,e,focusstack,prev
bind=SUPER+SHIFT,n,exchange_client,down
bind=SUPER+SHIFT,e,exchange_client,up
bind=SUPER+SHIFT,m,exchange_client,left
bind=SUPER+SHIFT,i,exchange_client,right
bind=SUPER+CTRL,n,focusdir,down
bind=SUPER+CTRL,e,focusdir,up
bind=SUPER+CTRL,m,focusdir,left
bind=SUPER+CTRL,i,focusdir,right
bind=SUPER+CTRL,Return,zoom

bind=SUPER,1,view,1
bind=SUPER,2,view,2
bind=SUPER,3,view,3
bind=SUPER,4,view,4
bind=SUPER,5,view,5
bind=SUPER,6,view,6
bind=SUPER,7,view,7
bind=SUPER,8,view,8
bind=SUPER,9,view,9

bind=SUPER+SHIFT,1,tag,1
bind=SUPER+SHIFT,2,tag,2
bind=SUPER+SHIFT,3,tag,3
bind=SUPER+SHIFT,4,tag,4
bind=SUPER+SHIFT,5,tag,5
bind=SUPER+SHIFT,6,tag,6
bind=SUPER+SHIFT,7,tag,7
bind=SUPER+SHIFT,8,tag,8
bind=SUPER+SHIFT,9,tag,9

bind=SUPER,comma,focusmon,left
bind=SUPER,period,focusmon,right
bind=SUPER+SHIFT,code:59,tagmon,left
bind=SUPER+SHIFT,code:60,tagmon,right

bind=SUPER,f,togglefullscreen
bind=SUPER+ALT,m,incnmaster,+1
bind=SUPER+ALT,i,incnmaster,-1

bind=SUPER+SHIFT,q,quit
bind=SUPER+CTRL,r,reload

bind=SUPER,t,setlayout,tile
bind=SUPER,a,setlayout,spiral
bind=SUPER,c,setlayout,scroller
bind=SUPER+ALT,t,setlayout,vertical_tile
bind=SUPER+ALT,a,setlayout,vertical_spiral
bind=SUPER+ALT,c,setlayout,vertical_scroller

bind=NONE,code:123,spawn,pamixer -i 3
bind=NONE,code:122,spawn,pamixer -d 3
bind=NONE,code:121,spawn,pamixer --toggle-mute

mousebind=SUPER,btn_left,moveresize,curmove
mousebind=SUPER,btn_right,moveresize,curresize

gesturebind=none,left,3,focusmon,left
gesturebind=none,right,3,focusmon,right
gesturebind=none,up,3,focusstack,next
gesturebind=none,down,3,focusstack,prev

env=QT_QA_PLATFORM,qt6ct
env=XDG_CURRENT_DESKTOP,sway
        '';
        autostart_sh = ''
        '';
    };
}
