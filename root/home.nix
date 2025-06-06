{ config, pkgs, ... }:

{
    
    home.stateVersion = "25.05"; # Please read the comment before changing.
    home.file = {
        ".config/kmonad/ibm-thinkpad-travel.kbd" = {
            text = ''
                (defcfg
                    input (device-file "/dev/input/by-id/usb-Lite-On_Tech_IBM_USB_Travel_Keyboard_with_Ultra_Nav-event-kbd")
                    output (uinput-sink "IBM Thinkpad Travel Keyboard")
                    cmp-seq ralt
                    cmp-seq-delay 5
                    fallthrough true
                    allow-cmd false
                )

                (defalias 
                    srch KeySearch
                    vido KeySwitchVideoMode
                    cfg  KeyConfig
                    lnch KeyScale
                    cctl (layer-toggle colemakctl)
                    csft (layer-toggle colemakshift)
                    qctl (layer-toggle qwertyctl)
                    qsft (layer-toggle qwertyshift)
                    swchq (layer-switch qwerty)
                    swchc (layer-switch colemak)
                    fwd   KeyForward
                    bck   KeyBack
                    modcaps (tap-hold 200 caps lalt)
                    modbksp (tap-hold 200 bspc lalt)
                    numlock (tap-macro (layer-switch numpad) nlck )
                )


                (defsrc
                  esc            vold volu mute                ssrq slck pp    ins  home pgup
                  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12   del  end  pgdn
                  grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc  
                  tab  q    w    e    r    t    y    u    i    o    p    [    ]    \     
                  caps a    s    d    f    g    h    j    k    l    ;    '    ret        
                  lsft z    x    c    v    b    n    m    ,    .    /    rsft                 
                  wkup lctl lalt           spc                 ralt rctl wkup up   wkup       
                                                                         left down rght  
                )

                (deflayer colemak
                  esc            vold volu mute                ssrq slck pp    ins  home pgup
                  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12   del  end  pgdn
                  grv  1    2    3    4    5    6    7    8    9    0    -    =    caps  
                  tab  q    w    f    p    b    j    l    u    u    ;    [    ]    \     
                  @modbksp a    r    s    t    g    m    n    e    i    o    '    ret        
                  lsft x    c    d    v    z    k    h    ,    .    /    rsft                 
                  _    @cctl lmet           spc                 ralt @cctl @bck up   @fwd       
                                                                         left down rght  
                )

                (deflayer colemakctl
                  C-esc            C-vold C-volu C-mute                C-ssrq C-slck C-pp    C-ins  C-home C-pgup
                  C-f1   C-f2   C-f3   C-f4   C-f5   C-f6   C-f7   C-f8   C-f9   C-f10  C-f11  C-f12   C-del  C-end  C-pgdn
                  C-grv  C-1    C-2    C-3    C-4    C-5    C-6    C-7    C-8    C-9    C-0    C--    C-=    C-caps  
                  C-tab  C-q    C-w    C-f    C-p    C-b    C-j    C-l    C-u    C-y    C-;    C-[    C-]    C-\     
                  C-@modbksp C-a    C-r    C-s    C-t    C-g    C-m    C-n    C-e    C-i    C-o    C-'    C-ret        
                  C-lsft C-x    C-c    C-d    C-v    C-z    C-k    C-h    C-,    C-.    C-/    C-rsft                 
                  _    _     C-lmet           @swchq                 C-ralt _     C-@bck C-up   C-@fwd       
                                                                         C-left C-down C-rght  
                )
                (deflayer colemakshift
                  S-esc            S-vold S-volu S-mute                S-ssrq @numlock S-pp    S-ins  S-home S-pgup
                  S-f1   S-f2   S-f3   S-f4   S-f5   S-f6   S-f7   S-f8   S-f9   S-f10  S-f11  S-f12   S-del  S-end  S-pgdn
                  S-grv  S-1    S-2    S-3    S-4    S-5    S-6    S-7    S-8    S-9    S-0    S--    S-=    S-caps  
                  S-tab  S-q    S-w    S-f    S-p    S-b    S-j    S-l    S-u    S-y    S-;    S-[    S-]    S-\     
                  S-@modbksp S-a    S-r    S-s    S-t    S-g    S-m    S-n    S-e    S-i    S-o    S-'    S-ret        
                  _      S-x    S-c    S-d    S-v    S-z    S-k    S-h    S-,    S-.    S-/    _                 
                  _    lctl     S-lmet           S-spc                 S-ralt rctl  S-@bck S-up   S-@fwd       
                                                                         S-left S-down S-rght  
                )


                (deflayer qwerty
                  esc            vold volu mute                ssrq slck pp    ins  home pgup
                  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12   del  end  pgdn
                  grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc  
                  tab  q    w    e    r    t    y    u    i    o    p    [    ]    \     
                  @modcaps a    s    d    f    g    h    j    k    l    ;    '    ret        
                  lsft z    x    c    v    b    n    m    ,    .    /    rsft                 
                  _    @qctl lmet           spc                 ralt @qctl @bck up   @fwd       
                                                                         left down rght  
                )

                (deflayer qwertyctl
                  C-esc            C-vold C-volu C-mute                C-ssrq C-slck C-pp    C-ins  C-home C-pgup
                  C-f1   C-f2   C-f3   C-f4   C-f5   C-f6   C-f7   C-f8   C-f9   C-f10  C-f11  C-f12   C-del  C-end  C-pgdn
                  C-grv  C-1    C-2    C-3    C-4    C-5    C-6    C-7    C-8    C-9    C-0    C--    C-=    C-bspc  
                  C-tab  C-q    C-w    C-e    C-r    C-t    C-y    C-u    C-i    C-o    C-p    C-[    C-]    C-\     
                  C-@modcaps C-a    C-s    C-d    C-f    C-g    C-h    C-j    C-k    C-l    C-;    C-'    C-ret        
                  C-lsft C-z    C-x    C-c    C-v    C-b    C-n    C-m    C-,    C-.    C-/    C-rsft                 
                  _    _     C-lmet           @swchc                 C-ralt _     C-@bck C-up   C-@fwd       
                                                                         C-left C-down C-rght  
                )

                (deflayer qwertyshift
                  S-esc            S-vold S-volu S-mute                S-ssrq @numlock S-pp    S-ins  S-home S-pgup
                  S-f1   S-f2   S-f3   S-f4   S-f5   S-f6   S-f7   S-f8   S-f9   S-f10  S-f11  S-f12   S-del  S-end  S-pgdn
                  S-grv  S-1    S-2    S-3    S-4    S-5    S-6    S-7    S-8    S-9    S-0    S--    S-=    S-bspc  
                  S-tab  S-q    S-w    S-e    S-r    S-t    S-y    S-u    S-i    S-o    S-p    S-[    S-]    S-\     
                  S-@modcaps S-a    S-s    S-d    S-f    S-g    S-h    S-j    S-k    S-l    S-;    S-'    S-ret        
                  _      S-z    S-x    S-c    S-v    S-b    S-n    S-m    S-,    S-.    S-/    _                 
                  _    lctl  S-lmet           @swchc                 S-ralt rctl  S-@bck S-up   S-@fwd       
                                                                         S-left S-down S-rght  
                )

                (deflayer numpad
                  _              _    _    _                   _    _    _    _    _    _
                  _    _    _    _    _    _    _    _    _    _    _    _     _    _    _
                  _    _    _    _    _    _    _    kp7  kp8  kp9  kp/  _    _    _  
                  _    _    _    _    _    _    _    kp4  kp5  kp6  kp*  _    _    _     
                  _    _    _    _    _    _    _    kp1  kp2  kp3  kp-  _    _          
                  _    _    _    _    _    _    _    kp0  _    kp.  kp+  _                 
                  _    _    _              _                   _    _    _    _    _       
                                                                         _    _    _  
                )
                '';
            };
            ".config/kmonad/unicomp-model-m.kbd" = {
                text = ''
                    (defcfg
                        input (device-file "/dev/input/by-id/usb-Unicomp_Inc_Ruffian6_x_Kbrd_v3_xx-event-kbd")
                        output (uinput-sink "Unicomp New Model M Keyboard")
                        cmp-seq ralt
                        cmp-seq-delay 5
                        fallthrough true
                        allow-cmd false
                    )

                    (defalias 
                        srch KeySearch
                        vido KeySwitchVideoMode
                        cfg  KeyConfig
                        lnch KeyScale
                        cctl (layer-toggle colemakctl)
                        qctl (layer-toggle qwertyctl)
                        swchq (layer-switch qwerty)
                        swchc (layer-switch colemak)

                    )


                    (defsrc
                      esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12        ssrq slck pause
                      grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc  ins  home pgup  nlck kp/  kp*  kp-
                      tab  q    w    e    r    t    y    u    i    o    p    [    ]    \     del  end  pgdn  kp7  kp8  kp9  kp+
                      caps a    s    d    f    g    h    j    k    l    ;    '    ret                        kp4  kp5  kp6
                      lsft z    x    c    v    b    n    m    ,    .    /    rsft                 up         kp1  kp2  kp3  kprt
                      lctl lmet lalt           spc            ralt rmet cmp  rctl            left down rght  kp0  kp.
                    )

                    (deflayer colemak
                      esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12        ssrq slck pause
                      grv  1    2    3    4    5    6    7    8    9    0    -    =    caps  ins  home pgup  nlck kp/  kp*  kp-
                      tab  q    w    f    p    b    j    l    u    y    ;    [    ]    \     del  end  pgdn  kp7  kp8  kp9  kp+
                      bspc a    r    s    t    g    m    n    e    i    o    '    ret                        kp4  kp5  kp6
                      lsft x    c    d    v    z    k    h    ,    .    /    rsft                 up         kp1  kp2  kp3  kprt
                      @cctl lmet lalt           spc            ralt rmet @ctl @cctl            left down rght  kp0  kp.
                    )

                    (deflayer colemakctl
                      C-esc  C-f1   C-f2   C-f3   C-f4   C-f5   C-f6   C-f7   C-f8   C-f9   C-f10  C-f11  C-f12        C-ssrq C-slck C-pause
                      C-grv  C-1    C-2    C-3    C-4    C-5    C-6    C-7    C-8    C-9    C-0    C--    C-=    C-caps  C-ins  C-home C-pgup  C-nlck C-kp/  C-kp*  C-kp-
                      C-tab  C-q    C-w    C-f    C-p    C-b    C-j    C-l    C-u    C-y    C-;    C-[    C-]    C-\     C-del  C-end  C-pgdn  C-kp7  C-kp8  C-kp9  C-kp+
                      C-bspc C-a    C-r    C-s    C-t    C-g    C-m    C-n    C-e    C-i    C-o    C-'    C-ret                                C-kp4  C-kp5  C-kp6
                      C-lsft C-x    C-c    C-d    C-v    C-z    C-k    C-h    C-,    C-.    C-/    C-rsft                         C-up         C-kp1  C-kp2  C-kp3  C-kprt
                      _    C-lmet C-lalt           @swchq         C-ralt C-rmet @ctlctl _                                     C-left C-down C-rght C-kp0  C-kp.
                    )

                    (defalias ctl (layer-toggle control))

                    (deflayer control
                      _    mute vold volu prev pp   next brdn brup _    _    _    _          _    _    _
                      _    _    _    _    _    _    _    _    _    _    _    _    _    _     _    _    _     _    _    _    _
                      _    _    _    _    _    _    _    _    _    _    _    _    _    _     _    _    _     _    _    _    _
                      _    _    _    _    _    _    _    _    _    _    _    _    _                          _    _    _
                      _    _    _    _    _    _    _    _    _    _    _    _                    _          _    _    _    _
                      _    _    _              _              _    _    _    _               _    _    _     _    _   
                    )
                    (defalias ctlctl (layer-toggle controlctl))

                    (deflayer controlctl
                      _    C-mute C-vold C-volu C-prev C-pp   C-next C-brdn C-brup _    _    _    _          _    _    _
                      _    _    _    _    _    _    _    _    _    _    _    _    _    _     _    _    _     _    _    _    _
                      _    _    _    _    _    _    _    _    _    _    _    _    _    _     _    _    _     _    _    _    _
                      _    _    _    _    _    _    _    _    _    _    _    _    _                          _    _    _
                      _    _    _    _    _    _    _    _    _    _    _    _                    _          _    _    _    _
                      _    _    _              _              _    _    _    _               _    _    _     _    _   
                    )

                    (deflayer qwerty
                      esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12        ssrq slck pause
                      grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc  ins  home pgup  nlck kp/  kp*  kp-
                      tab  q    w    e    r    t    y    u    i    o    p    [    ]    \     del  end  pgdn  kp7  kp8  kp9  kp+
                      caps a    s    d    f    g    h    j    k    l    ;    '    ret                        kp4  kp5  kp6
                      lsft z    x    c    v    b    n    m    ,    .    /    rsft                 up         kp1  kp2  kp3  kprt
                      @qctl lmet lalt           spc            ralt rmet cmp  @qctl            left down rght  kp0  kp.
                    )

                    (deflayer qwertyctl
                      C-esc  C-f1   C-f2   C-f3   C-f4   C-f5   C-f6   C-f7   C-f8   C-f9   C-f10  C-f11  C-f12        C-ssrq C-slck C-pause
                      C-grv  C-1    C-2    C-3    C-4    C-5    C-6    C-7    C-8    C-9    C-0    C--    C-=    C-caps  C-ins  C-home C-pgup  C-nlck C-kp/  C-kp*  C-kp-
                      C-tab  C-q    C-w    C-e    C-r    C-t    C-y    C-u    C-i    C-o    C-p    C-[    C-]    C-\     C-del  C-end  C-pgdn  C-kp7  C-kp8  C-kp9  C-kp+
                      C-bspc C-a    C-s    C-d    C-f    C-g    C-h    C-j    C-k    C-l    C-o    C-'    C-ret                                C-kp4  C-kp5  C-kp6
                      C-lsft C-z    C-x    C-c    C-v    C-b    C-n    C-m    C-,    C-.    C-/    C-rsft                         C-up         C-kp1  C-kp2  C-kp3  C-kprt
                      _    C-lmet C-lalt           @swchc         C-ralt C-rmet @ctlctl _                                     C-left C-down C-rght C-kp0  C-kp.
                    )

                    (deflayer name
                      _    _    _    _    _    _    _    _    _    _    _    _    _          _    _    _
                      _    _    _    _    _    _    _    _    _    _    _    _    _    _     _    _    _     _    _    _    _
                      _    _    _    _    _    _    _    _    _    _    _    _    _    _     _    _    _     _    _    _    _
                      _    _    _    _    _    _    _    _    _    _    _    _    _                          _    _    _
                      _    _    _    _    _    _    _    _    _    _    _    _                    _          _    _    _    _
                      _    _    _              _              _    _    _    _               _    _    _     _    _   
                    )
                '';
            };
        };
    programs.home-manager.enable = true;
}
