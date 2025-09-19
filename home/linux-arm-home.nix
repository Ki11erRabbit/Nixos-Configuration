{ lib, inputs, config, pkgs, channels,  ... }:
{

    home.packages = with pkgs; [
        vesktop
    ];
    
    wayland.windowManager.sway = {
        enable = true;
        package = pkgs.swayfx;
        checkConfig = false;
        config = rec {
            modifier = "Mod4";
            terminal = "foot";
            keybindings = {
                "${modifier}+Return" = "exec ${terminal}";
            };
        };
        extraConfig = ''
        '';

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

    programs.foot = {
        enable = true;
        #enableZshIntegration = true;
        settings = {
            main = {
                font = "JetbrainsMonoNerdFont:size=11";
            };
            colors = {
                cursor="eff1f5 dc8a78";
                foreground="4c4f69";
                background="eff1f5";

                regular0="5c5f77";
                regular1="d20f39";
                regular2="40a02b";
                regular3="df8e1d";
                regular4="1e66f5";
                regular5="ea76cb";
                regular6="179299";
                regular7="acb0be";

                bright0="6c6f85";
                bright1="d20f39";
                bright2="40a02b";
                bright3="df8e1d";
                bright4="1e66f5";
                bright5="ea76cb";
                bright6="179299";
                bright7="bcc0cc";

                "16"="fe640b";
                "17"="dc8a78";

                selection-foreground="4c4f69";
                selection-background="ccced7";

                search-box-no-match="dce0e8 d20f39";
                search-box-match="4c4f69 ccd0da";

                jump-labels="dce0e8 fe640b";
                urls="1e66f5";
            };
        };
    };
}
