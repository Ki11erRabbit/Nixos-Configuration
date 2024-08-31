{ config, pkgs, channels,  ... }:

{
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "ki11errabbit";
    home.homeDirectory = "/home/ki11errabbit";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "23.11"; # Please read the comment before changing.
    nixpkgs.config.allowUnfree = true;

    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = with pkgs; [
        firefox
        thunderbird
        libsForQt5.breeze-qt5
        libsForQt5.breeze-gtk
        libsForQt5.breeze-icons
        libsForQt5.ark
        font-manager
        discord
        dolphin
        signal-desktop
        alacritty
        wlr-randr
        river
        waybar
        bemenu
        swaybg
        mpvpaper
        neovide
        sway-contrib.grimshot
        wl-clipboard
        pamixer
        swayidle
        keepassxc
        eza
        slack
        slurp
        libsForQt5.bismuth
        obs-studio
        libreoffice-qt
        yazi
        libsForQt5.kdeconnect-kde
        neofetch
        lua-language-server
        universal-ctags
        vscode
        haskellPackages.lsp
        rust-analyzer
        python310Packages.python-lsp-server
        gopls
        libclang
        jdt-language-server
        yaml-language-server
        twitter-color-emoji
        zig
        zls
        idris2
        emacs
        stack
        cabal-install
        ghc
        go
        python3
        racket
        luajit
        wl-color-picker
        google-chrome
        yarn
        nodejs
        fzf
        ripgrep
        bat
        dash
        swayimg
        libsForQt5.okular
        squeak
        mpv
        transmission-remote-gtk
        pharo
        hunspell
        hunspellDicts.en_US
        libsForQt5.ghostwriter
        transmission-qt
        usbutils
        gparted
        gamescope
        barrier
        fnott
        stow
        haskellPackages.kmonad
        networkmanagerapplet
        appimage-run

        stow
        fnott
        wdisplays
        xournalpp
        gimp
        powershell
        godot_4
        trash-cli
        zoxide
        delta
        du-dust
        fd
        hexyl
        procs
        pavucontrol
        jellyfin-media-player
        wlroots
        wayland
        gfortran
        wmctrl
        jdk21
        erlang
        audacious
        helix
        kakoune
        guile
        # # Adds the 'hello' command to your environment. It prints a friendly
        # # "Hello, world!" when run.
        # pkgs.hello

        # # It is sometimes useful to fine-tune packages, for example, by applying
        # # overrides. You can do that directly here, just don't forget the
        # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
        # # fonts?
        # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

        # # You can also create simple shell scripts directly inside your
        # # configuration. For example, this adds a command 'my-hello' to your
        # # environment:
        # (pkgs.writeShellScriptBin "my-hello" ''
        #   echo "Hello, ${config.home.username}!"
        # '')
    ];

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
        ".local/bin/nix-config.sh" = {
            executable = true;
            text = ''
            #!/bin/sh

            items="system
            hardware
            home"

            item=$(echo "$items" | bemenu -pfi "NixOS Config")


            case $item in
                system) neovide /etc/nixos/configuration.nix;;
                hardware) neovide /etc/nixos/hardware-configuration.nix;;
                home) neovide /home/ki11errabbit/.config/home-manager/home.nix;;
                *) exit 1;;
            esac
        '';
        };
        ".config/kmonad/t440p.kbd".text = ''
            (defcfg
                input (device-file "/dev/input/by-path/platform-i8042-serio-0-event-kbd")
                output (uinput-sink "T440p Keyboard")
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
                fn (layer-toggle function)

            )



            (defsrc
                esc  mute vold volu f20  brdn brup KeySwitchVideoMode wlan  KeyConfig  KeySearch KeyScale file   home  end   ins   del
                grv  1    2    3    4    5    6    7    8    9    0    -    =     bspc
                tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
                caps a    s    d    f    g    h    j    k    l    ;    '    ret
                lsft z    x    c    v    b    n    m    ,    .    /    rsft
                lctl wkup lmet lalt      spc            ralt ssrq rctl pgup up   pgdn
                                                                       left down rght
            )

            (deflayer colemak
                esc   mute  vold  volu  f20   brdn brup @vido wlan  @cfg  @srch @lnch file   home  end   ins   del
                grv   1     2     3     4     5    6    7     8     9     0     -     =      caps
                tab   q     w     f     p     b    j    l     u     y     ;     [     ]     \
                bspc  a     r     s     t     g    m    n     e     i     o     '     ret
                lsft  x     c     d     v     z    k    h     ,     .     /     rsft
                @cctl @fn   lalt  lmet        spc             ralt  ssrq  @cctl pgup  up    pgdn
                                                                                left  down  rght
            )
            (deflayer colemakctl
                C-esc   C-mute  C-vold  C-volu  C-f20   C-brdn C-brup C-@vido C-wlan  C-@cfg  C-@srch C-@lnch C-file   C-home  C-end   C-ins   C-del
                C-grv   C-1     C-2     C-3     C-4     C-5    C-6    C-7     C-8     C-9     C-0     C--     C-=      C-caps
                C-tab   C-q     C-w     C-f     C-p     C-b    C-j    C-l     C-u     C-y     C-;     C-[     C-]      C-\
                C-bspc  C-a     C-r     C-s     C-t     C-g    C-m    C-n     C-e     C-i     C-o     C-'     C-ret
                C-lsft  C-x     C-c     C-d     C-v     C-z    C-k    C-h     C-,     C-.     C-/     C-rsft
                _       _       C-lalt  C-lmet          @swchq                C-ralt  C-ssrq  C-rctl  C-pgup  C-up    C-pgdn
                                                                                                      C-left  C-down  C-rght
            )

            (deflayer qwerty
                esc   mute  vold  volu  f20   brdn brup @vido wlan  @cfg  @srch @lnch file   home  end   ins   del
                grv   1     2     3     4     5    6    7     8     9     0     -     =      bspc
                tab   q     w     e     r     t    y    u     i     o     p     [     ]      \
                caps  a     s     d     f     g    h    j     k     l     ;     '     ret
                lsft  z     x     c     v     b    n    m     ,     .     /     rsft
                @qctl @fn   lalt  lmet        spc             ralt  ssrq  @qctl pgup  up    pgdn
                                                                                left  down  rght
            )

            (deflayer qwertyctl
                C-esc   C-mute  C-vold  C-volu  C-f20   C-brdn C-brup C-@vido C-wlan  C-@cfg  C-@srch C-@lnch C-file   C-home  C-end   C-ins   C-del
                C-grv   C-1     C-2     C-3     C-4     C-5    C-6    C-7     C-8     C-9     C-0     C--     C-=      C-caps
                C-tab   C-q     C-w     C-e     C-r     C-t    C-y    C-u     C-i     C-o     C-p     C-[     C-]      C-\
                C-bspc  C-a     C-s     C-d     C-f     C-g    C-h    C-j     C-k     C-l     C-;     C-'     C-ret
                C-lsft  C-z     C-x     C-c     C-v     C-b    C-n    C-m     C-,     C-.     C-/     C-rsft
                _       _       C-lalt  C-lmet          @swchc                C-ralt  C-ssrq  C-rctl  C-pgup  C-up    C-pgdn
                                                                                                      C-left  C-down  C-rght
            )

            (deflayer function
                _    f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12   _    _    _    _  
                _    _    _    _    _    _    _    _    _    _    _    _    _     _   
                _    _    _    _    _    _    _    _    _    _    _    _    _    _
                _    _    _    _    _    _    _    _    _    _    _    _    _  
                _    _    _    _    _    _    _    _    _    _    _    _   
                _    _    _    _         _              _    _    _    _    _    _   
                                                                       _    _    _   
            )
        '';
        ".config/kmonad/x230t.kbd".text = ''
            (defcfg
                input (device-file "/dev/input/by-path/platform-i8042-serio-0-event-kbd")
                output (uinput-sink "x230t Keyboard")
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
                fn (layer-toggle function)
                lock KeyCloseCd
                webcam KeySport
                tnkv KeyBookmarks

            )



            (defsrc
                esc  mute volu vold f20 KeyBookmarks         ssrq slck KeyPause ins   del  home pgup 
                     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12            end  pgdn
                grv  1    2    3    4    5    6    7    8    9    0    -    =     bspc
                tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
                caps a    s    d    f    g    h    j    k    l    ;    '    ret
                lsft z    x    c    v    b    n    m    ,    .    /    rsft
                lctl wkup lmet lalt      spc            ralt KeyMenu rctl KeyBack up   KeyForward
                                                                       left down rght
            )

            (deflayer colemak
                esc  mute volu vold f20 @tnkv                ssrq slck KeyPause ins   del  home pgup 
                     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12            end  pgdn
                grv  1    2    3    4    5    6    7    8    9    0    -    =     caps
                tab  q    w    f    p    b    j    l    u    y    ;    [    ]    \
                bspc a    r    s    t    g    m    n    e    i    o    '    ret
                lsft x    c    d    v    z    k    h    ,    .    /    rsft
                @cctl @fn lalt lmet      spc            ralt ssrq @cctl KeyBack up   KeyForward
                                                                       left down rght
            )
            (deflayer colemakctl
                C-esc  C-mute C-volu C-vold C-f20 C-@tnkv                C-ssrq C-slck C-KeyPause C-ins   C-del  C-home C-pgup 
                       C-f1   C-f2   C-f3   C-f4   C-f5   C-f6   C-f7   C-f8   C-f9   C-f10  C-f11  C-f12            C-end  C-pgdn
                C-grv  C-1    C-2    C-3    C-4    C-5    C-6    C-7    C-8    C-9    C-0    C--    C-=     C-caps
                C-tab  C-q    C-w    C-f    C-p    C-b    C-j    C-l    C-u    C-y    C-;    C-[    C-]    C-\
                C-bspc C-a    C-r    C-s    C-t    C-g    C-m    C-n    C-e    C-i    C-o    C-'    C-ret
                C-lsft C-x    C-c    C-d    C-v    C-z    C-k    C-h    C-,    C-.    C-/    C-rsft
                _  _   C-lalt C-lmet      @swchq            C-ralt C-ssrq   _ C-KeyBack C-up   C-KeyForward
                                                                       C-left C-down C-rght
            )

            (deflayer qwerty
                esc  mute volu vold f20 @tnkv                ssrq slck KeyPause ins   del  home pgup 
                     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12            end  pgdn
                grv  1    2    3    4    5    6    7    8    9    0    -    =     bspc
                tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
                caps a    s    d    f    g    h    j    k    l    ;    '    ret
                lsft z    x    c    v    b    n    m    ,    .    /    rsft
                @qctl @fn lalt lmet      spc            ralt ssrq @qctl KeyBack up   KeyForward
                                                                       left down rght
            )

            (deflayer qwertyctl
                C-esc  C-mute C-volu C-vold C-f20 C-@tnkv                C-ssrq C-slck C-KeyPause C-ins   C-del  C-home C-pgup 
                        C-f1    C-f2    C-f3    C-f4    C-f5   C-f6   C-f7    C-f8    C-f9    C-f10   C-f11   C-f12            C-end  C-pgdn
                C-grv   C-1     C-2     C-3     C-4     C-5    C-6    C-7     C-8     C-9     C-0     C--     C-=      C-caps
                C-tab   C-q     C-w     C-e     C-r     C-t    C-y    C-u     C-i     C-o     C-p     C-[     C-]      C-\
                C-bspc  C-a     C-s     C-d     C-f     C-g    C-h    C-j     C-k     C-l     C-;     C-'     C-ret
                C-lsft  C-z     C-x     C-c     C-v     C-b    C-n    C-m     C-,     C-.     C-/     C-rsft
                _       _       C-lalt  C-lmet          @swchc                C-ralt  C-ssrq  C-rctl  C-KeyBack  C-up    C-KeyForward
                                                                                                      C-left  C-down  C-rght
            )

            (deflayer function
                _    _    _    _    _   _                    ssrq _    _  _     _    brup pgup 
                     _    @lock  _  zzz  wlan @webcam @vido _   _    prev _  _          brdn _  
                _    _    _    _    _    _    _    _    _    _    _    _    _     _   
                _    _    _    _    _    _    _    _    _    _    _    _    _    _
                _    _    _    _    _    _    _    _    _    _    _    _    _  
                _    _    _    _    _    _    _    _    _    _    _    _   
                _    _    _    _         @srch          _    _    _    _    KeyStop    _   
                                                                       prev pp   next
            )
        '';
        ".config/kmonad/t430s-mod.kbd".text = ''
            (defcfg
                input (device-file "/dev/input/by-path/platform-i8042-serio-0-event-kbd")
                output (uinput-sink "Classic Thinkpad Keyboard")
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
                fn (layer-toggle function)
                lock KeyCloseCd
                webcam KeySport
                tnkv KeyBookmarks

            )



            (defsrc
                esc  mute volu vold f20 KeyBookmarks         ssrq slck KeyPause ins   del  home pgup 
                     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12            end  pgdn
                grv  1    2    3    4    5    6    7    8    9    0    -    =     bspc
                tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
                caps a    s    d    f    g    h    j    k    l    ;    '    ret
                lsft z    x    c    v    b    n    m    ,    .    /    rsft
                lctl wkup lmet lalt      spc            ralt KeyMenu rctl KeyBack up   KeyForward
                                                                       left down rght
            )

            (deflayer colemak
                esc  mute volu vold f20 @tnkv                ssrq slck KeyPause ins   del  home pgup 
                     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12            end  pgdn
                grv  1    2    3    4    5    6    7    8    9    0    -    =     caps
                tab  q    w    f    p    b    j    l    u    y    ;    [    ]    \
                bspc a    r    s    t    g    m    n    e    i    o    '    ret
                lsft x    c    d    v    z    k    h    ,    .    /    rsft
                @cctl @fn lalt lmet      spc            ralt ssrq @cctl KeyBack up   KeyForward
                                                                       left down rght
            )
            (deflayer colemakctl
                C-esc  C-mute C-volu C-vold C-f20 C-@tnkv                C-ssrq C-slck C-KeyPause C-ins   C-del  C-home C-pgup 
                       C-f1   C-f2   C-f3   C-f4   C-f5   C-f6   C-f7   C-f8   C-f9   C-f10  C-f11  C-f12            C-end  C-pgdn
                C-grv  C-1    C-2    C-3    C-4    C-5    C-6    C-7    C-8    C-9    C-0    C--    C-=     C-caps
                C-tab  C-q    C-w    C-f    C-p    C-b    C-j    C-l    C-u    C-y    C-;    C-[    C-]    C-\
                C-bspc C-a    C-r    C-s    C-t    C-g    C-m    C-n    C-e    C-i    C-o    C-'    C-ret
                C-lsft C-x    C-c    C-d    C-v    C-z    C-k    C-h    C-,    C-.    C-/    C-rsft
                _  _   C-lalt C-lmet      @swchq            C-ralt C-ssrq   _ C-KeyBack C-up   C-KeyForward
                                                                       C-left C-down C-rght
            )

            (deflayer qwerty
                esc  mute volu vold f20 @tnkv                ssrq slck KeyPause ins   del  home pgup 
                     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12            end  pgdn
                grv  1    2    3    4    5    6    7    8    9    0    -    =     bspc
                tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
                caps a    s    d    f    g    h    j    k    l    ;    '    ret
                lsft z    x    c    v    b    n    m    ,    .    /    rsft
                @qctl @fn lalt lmet      spc            ralt ssrq @qctl KeyBack up   KeyForward
                                                                       left down rght
            )

            (deflayer qwertyctl
                C-esc  C-mute C-volu C-vold C-f20 C-@tnkv                C-ssrq C-slck C-KeyPause C-ins   C-del  C-home C-pgup 
                        C-f1    C-f2    C-f3    C-f4    C-f5   C-f6   C-f7    C-f8    C-f9    C-f10   C-f11   C-f12            C-end  C-pgdn
                C-grv   C-1     C-2     C-3     C-4     C-5    C-6    C-7     C-8     C-9     C-0     C--     C-=      C-caps
                C-tab   C-q     C-w     C-e     C-r     C-t    C-y    C-u     C-i     C-o     C-p     C-[     C-]      C-\
                C-bspc  C-a     C-s     C-d     C-f     C-g    C-h    C-j     C-k     C-l     C-;     C-'     C-ret
                C-lsft  C-z     C-x     C-c     C-v     C-b    C-n    C-m     C-,     C-.     C-/     C-rsft
                _       _       C-lalt  C-lmet          @swchc                C-ralt  C-ssrq  C-rctl  C-KeyBack  C-up    C-KeyForward
                                                                                                      C-left  C-down  C-rght
            )

            (deflayer function
                _    _    _    _    _   _                    ssrq _    _  _     _    brup pgup 
                     _    @lock  _  zzz  wlan @webcam @vido _   _    prev _  _          brdn _  
                _    _    _    _    _    _    _    _    _    _    _    _    _     _   
                _    _    _    _    _    _    _    _    _    _    _    _    _    _
                _    _    _    _    _    _    _    _    _    _    _    _    _  
                _    _    _    _    _    _    _    _    _    _    _    _   
                _    _    _    _         @srch          _    _    _    _    KeyStop    _   
                                                                       prev pp   next
            )
        '';
        ".config/kmonad/classic_thinkpad.kbd".text = ''
            (defcfg
                input (device-file "")
                output (uinput-sink "Classic Thinkpad Keyboard")
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
                fn (layer-toggle function)
                lock KeyCloseCd
                webcam KeySport
                tnkv KeyBookmarks

            )



            (defsrc
                esc  mute volu vold f20 KeyBookmarks         ssrq sclk KeyPause ins   del  home pgup 
                     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12            end  pgdn
                grv  1    2    3    4    5    6    7    8    9    0    -    =     bspc
                tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
                caps a    s    d    f    g    h    j    k    l    ;    '    ret
                lsft z    x    c    v    b    n    m    ,    .    /    rsft
                lctl wkup lmet lalt      spc            ralt KeyMenu rctl KeyBack up   KeyForward
                                                                       left down rght
            )

            (deflayer colemak
                esc  mute volu vold f20 @tnkv                ssrq sclk KeyPause ins   del  home pgup 
                     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12            end  pgdn
                grv  1    2    3    4    5    6    7    8    9    0    -    =     caps
                tab  q    w    f    p    b    j    l    u    y    ;    [    ]    \
                bspc a    r    s    t    g    m    n    e    i    o    '    ret
                lsft x    c    d    v    z    k    h    ,    .    /    rsft
                @cctl @fn lalt lmet      spc            ralt ssrq @cctl KeyBack up   KeyForward
                                                                       left down rght
            )
            (deflayer colemakctl
                C-esc  C-mute C-volu C-vold C-f20 C-@tnkv                C-ssrq C-sclk C-KeyPause C-ins   C-del  C-home C-pgup 
                       C-f1   C-f2   C-f3   C-f4   C-f5   C-f6   C-f7   C-f8   C-f9   C-f10  C-f11  C-f12            C-end  C-pgdn
                C-grv  C-1    C-2    C-3    C-4    C-5    C-6    C-7    C-8    C-9    C-0    C--    C-=     C-caps
                C-tab  C-q    C-w    C-f    C-p    C-b    C-j    C-l    C-u    C-y    C-;    C-[    C-]    C-\
                C-bspc C-a    C-r    C-s    C-t    C-g    C-m    C-n    C-e    C-i    C-o    C-'    C-ret
                C-lsft C-x    C-c    C-d    C-v    C-z    C-k    C-h    C-,    C-.    C-/    C-rsft
                _  _   C-lalt C-lmet      @swchq            C-ralt C-ssrq   _ C-KeyBack C-up   C-KeyForward
                                                                       C-left C-down C-rght
            )

            (deflayer qwerty
                esc  mute volu vold f20 @tnkv                ssrq sclk KeyPause ins   del  home pgup 
                     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12            end  pgdn
                grv  1    2    3    4    5    6    7    8    9    0    -    =     bspc
                tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
                caps a    s    d    f    g    h    j    k    l    ;    '    ret
                lsft z    x    c    v    b    n    m    ,    .    /    rsft
                @cctl @fn lalt lmet      spc            ralt ssrq @cctl KeyBack up   KeyForward
                                                                       left down rght
            )

            (deflayer qwertyctl
                C-esc  C-mute C-volu C-vold C-f20 C-@tnkv                C-ssrq C-sclk C-KeyPause C-ins   C-del  C-home C-pgup 
                        C-f1    C-f2    C-f3    C-f4    C-f5   C-f6   C-f7    C-f8    C-f9    C-f10   C-f11   C-f12            C-end  C-pgdn
                C-grv   C-1     C-2     C-3     C-4     C-5    C-6    C-7     C-8     C-9     C-0     C--     C-=      C-caps
                C-tab   C-q     C-w     C-e     C-r     C-t    C-y    C-u     C-i     C-o     C-p     C-[     C-]      C-\
                C-bspc  C-a     C-s     C-d     C-f     C-g    C-h    C-j     C-k     C-l     C-;     C-'     C-ret
                C-lsft  C-z     C-x     C-c     C-v     C-b    C-n    C-m     C-,     C-.     C-/     C-rsft
                _       _       C-lalt  C-lmet          @swchc                C-ralt  C-ssrq  C-rctl  C-KeyBack  C-up    C-KeyForward
                                                                                                      C-left  C-down  C-rght
            )

            (deflayer function
                _    _    _    _    _   _                    ssrq _    _  _     _    brup pgup 
                     _    @lock  _  zzz  wlan _    @vido _   _    prev _  _          brdn _  
                _    _    _    _    _    _    _    _    _    _    _    _    _     _   
                _    _    _    _    _    _    _    _    _    _    _    _    _    _
                _    _    _    _    _    _    _    _    _    _    _    _    _  
                _    _    _    _    _    _    _    _    _    _    _    _   
                _    _    _    _         @srch          _    _    _    _    KeyStop    _   
                                                                       prev pp   next
            )
        '';
        ".config/river/init" = {
            executable = true;
            text = ''
            #!/bin/sh

            # This is the example configuration file for river.
            #
            # If you wish to edit this, you will probably want to copy it to
            # $XDG_CONFIG_HOME/river/init or $HOME/.config/river/init first.
            #
            # See the river(1), riverctl(1), and rivertile(1) man pages for complete
            # documentation.

            # Note: the "Super" modifier is also known as Logo, GUI, Windows, Mod4, etc.

            export PATH="$HOME/.cargo/bin:$PATH"


            # Super+Return to start an instance of foot (https://codeberg.org/dnkl/foot)
            riverctl map normal Super Return spawn alacritty

            riverctl map normal Super+Shift Return spawn 'emacsclient -c'

            # Super+D to start an instance of bemenu
            riverctl map normal Super D spawn bemenu-run


            riverctl map normal Super S spawn 'grimshot save area'
            riverctl map normal Super+Shift S spawn 'grimshot copy area'
            riverctl map normal None Print spawn 'grimshot save screen'
            riverctl map normal Shift Print spawn 'grimshot copy screen'

            riverctl map normal Super R spawn dolphin
            riverctl map normal None XF86Explorer spawn 'dolphin'
            
            riverctl map normal None XF86RotateWindows spawn '/home/ki11errabbit/.local/bin/rotate-screen.sh'

            riverctl map normal Super+Shift W spawn '/home/ki11errabbit/.local/bin/screen-toggle.sh'

            riverctl map normal None XF86RotateWindows spawn '/home/ki11errabbit/.local/bin/rotate-screen.sh'
            riverctl map normal None XF86AudioMicMute spawn 'amixer set Capture toggle'

            riverctl map normal None XF86Tools spawn '/home/ki11errabbit/.local/bin/nix-config.sh'

            riverctl map normal None XF86Search spawn 'bemenu-run'
            riverctl map normal None XF86WLAN spawn 'alacritty -e nmtui'
            riverctl map normal None XF86Display spawn 'wdisplays'

            # Super+Q to close the focused view
            riverctl map normal Super Q close

            # Super+Shift+E to exit river
            riverctl map normal Super+Shift Q exit

            # Super+J and Super+K to focus the next/previous view in the layout stack
            riverctl map normal Super N focus-view next
            riverctl map normal Super E focus-view previous

            # Super+Shift+J and Super+Shift+K to swap the focused view with the next/previous
            # view in the layout stack
            riverctl map normal Super+Shift N swap next
            riverctl map normal Super+Shift E swap previous

            # Super+Period and Super+Comma to focus the next/previous output
            riverctl map normal Super Period focus-output next
            riverctl map normal Super Comma focus-output previous

            # Super+Shift+{Period,Comma} to send the focused view to the next/previous output
            riverctl map normal Super+Shift Period send-to-output next
            riverctl map normal Super+Shift Comma send-to-output previous

            # Super+Return to bump the focused view to the top of the layout stack
            riverctl map normal Super+Control Return zoom

            # Super+H and Super+L to decrease/increase the main ratio of rivertile(1)
            riverctl map normal Super M send-layout-cmd rivertile "main-ratio -0.05"
            riverctl map normal Super I send-layout-cmd rivertile "main-ratio +0.05"

            # Super+Shift+H and Super+Shift+L to increment/decrement the main count of rivertile(1)
            riverctl map normal Super+Shift M send-layout-cmd rivertile "main-count +1"
            riverctl map normal Super+Shift I send-layout-cmd rivertile "main-count -1"

            # Super+Alt+{H,J,K,L} to move views
            riverctl map normal Super+Alt M move left 100
            riverctl map normal Super+Alt N move down 100
            riverctl map normal Super+Alt E move up 100
            riverctl map normal Super+Alt I move right 100

            # Super+Alt+Control+{H,J,K,L} to snap views to screen edges
            riverctl map normal Super+Alt+Control M snap left
            riverctl map normal Super+Alt+Control N snap down
            riverctl map normal Super+Alt+Control E snap up
            riverctl map normal Super+Alt+Control I snap right

            # Super+Alt+Shift+{H,J,K,L} to resize views
            riverctl map normal Super+Alt+Shift M resize horizontal -100
            riverctl map normal Super+Alt+Shift N resize vertical 100
            riverctl map normal Super+Alt+Shift E resize vertical -100
            riverctl map normal Super+Alt+Shift I resize horizontal 100

            riverctl map normal Super L spawn '/home/ki11errabbit/.cargo/bin/flow cycle-tags previous'
            riverctl map normal Super U spawn '/home/ki11errabbit/.cargo/bin/flow cycle-tags next'

            # Super + Left Mouse Button to move views
            riverctl map-pointer normal Super BTN_LEFT move-view

            # Super + Right Mouse Button to resize views
            riverctl map-pointer normal Super BTN_RIGHT resize-view

            # Super + Middle Mouse Button to toggle float
            riverctl map-pointer normal Super BTN_MIDDLE toggle-float

            for i in $(seq 1 9)
            do
                tags=$((1 << ($i - 1)))

                # Super+[1-9] to focus tag [0-8]
                riverctl map normal Super $i set-focused-tags $tags

                # Super+Shift+[1-9] to tag focused view with tag [0-8]
                riverctl map normal Super+Shift $i set-view-tags $tags

                # Super+Ctrl+[1-9] to toggle focus of tag [0-8]
                riverctl map normal Super+Control $i toggle-focused-tags $tags

                # Super+Shift+Ctrl+[1-9] to toggle tag [0-8] of focused view
                riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
            done

            # Super+0 to focus all tags
            # Super+Shift+0 to tag focused view with all tags
            all_tags=$(((1 << 32) - 1))
            riverctl map normal Super 0 set-focused-tags $all_tags
            riverctl map normal Super+Shift 0 set-view-tags $all_tags

            # Super+Space to toggle float
            riverctl map normal Super+Shift F toggle-float

            # Super+F to toggle fullscreen
            riverctl map normal Super F toggle-fullscreen

            # Super+{Up,Right,Down,Left} to change layout orientation
            riverctl map normal Super Up    send-layout-cmd rivertile "main-location top"
            riverctl map normal Super Right send-layout-cmd rivertile "main-location right"
            riverctl map normal Super Down  send-layout-cmd rivertile "main-location bottom"
            riverctl map normal Super Left  send-layout-cmd rivertile "main-location left"

            # Declare a passthrough mode. This mode has only a single mapping to return to
            # normal mode. This makes it useful for testing a nested wayland compositor
            riverctl declare-mode passthrough

            # Super+F11 to enter passthrough mode
            riverctl map normal Super F11 enter-mode passthrough

            # Super+F11 to return to normal mode
            riverctl map passthrough Super F11 enter-mode normal

            # Various media key mapping examples for both normal and locked mode which do
            # not have a modifier
            for mode in normal locked
            do
                # Eject the optical drive (well if you still have one that is)
                riverctl map $mode None XF86Eject spawn 'eject -T'

                # Control pulse audio volume with pamixer (https://github.com/cdemoulins/pamixer)
                riverctl map $mode None XF86AudioRaiseVolume  spawn 'pamixer -i 5 && pkill -RTMIN+8 waybar'
                riverctl map $mode None XF86AudioLowerVolume  spawn 'pamixer -d 5 && pkill -RTMIN+8 waybar'
                riverctl map $mode None XF86AudioMute         spawn 'pamixer --toggle-mute && pkill -RTMIN+8 waybar'

                # Control MPRIS aware media players with playerctl (https://github.com/altdesktop/playerctl)
                riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
                riverctl map $mode None XF86AudioPlay  spawn 'playerctl play-pause'
                riverctl map $mode None XF86AudioPrev  spawn 'playerctl previous'
                riverctl map $mode None XF86AudioNext  spawn 'playerctl next'

                # Control screen backlight brightness with light (https://github.com/haikarainen/light)
                riverctl map $mode None XF86MonBrightnessUp   spawn 'light -A 5'
                riverctl map $mode None XF86MonBrightnessDown spawn 'light -U 5'
            done

            # Set background and border color
            #riverctl background-color 0x002b36
            riverctl background-color 0x282c34
            riverctl border-color-focused 0x51afef
            riverctl border-color-unfocused 0x282c34

            # Set keyboard repeat rate
            riverctl set-repeat 50 300

            # Make certain views start floating
            riverctl float-filter-add app-id float
            riverctl float-filter-add title "popup title with spaces"

            # Set app-ids and titles of views which should use client side decorations
            riverctl csd-filter-add app-id "gedit"

            # Set the default layout generator to be rivertile and start it.
            # River will send the process group of the init executable SIGTERM on exit.
            riverctl default-layout rivertile
            rivertile -view-padding 6 -outer-padding 6 &


            waybar &
            fnott &

            riverctl focus-follows-cursor always
            riverctl xcursor-theme Posy_Cursor 32

            /home/ki11errabbit/.local/bin/configure-monitors.sh &

            /home/ki11errabbit/.local/bin/setup-wallpaper.sh &

            /home/ki11errabbit/.local/bin/setup-swayidle.sh &

            /home/ki11errabbit/.local/bin/setup-keyboard.sh &

            dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=river &
            dbus-daemon --session --address="unix:path=$XDG_RUNTIME_DIR/bus" &

            nm-applet &
            blueman-applet &
            kdeconnect-indicator &
        '';
        };
        ".config/waybar/scripts/pipewire.sh" = {
            executable = true;
            text = ''
            #!/bin/sh


            [ $(pamixer --get-mute) = true ] && echo "🔇 " && exit

            vol="$(pamixer --get-volume)"

            if [ "$vol" -gt "99" ]; then
                icon="🔊"
            elif [ "$vol" -gt "70" ]; then
                icon="🔊 "
            elif [ "$vol" -gt "30" ]; then
                icon="🔉 "
            elif [ "$vol" -gt "9" ]; then
                icon="🔉 "
            elif [ "$vol" -gt "0" ]; then
                icon="🔈  "
            else
                    echo " 🔇  $vol%" && exit
            fi

            echo "$icon$vol%"
        '';
        };
        ".config/waybar/scripts/weather.sh" = {
            executable = true;
            text = ''
            #!/bin/sh

            # Displays todays precipication chance (☔) and daily low (🥶) and high (🌞).
            # Usually intended for the statusbar.

            # If we have internet, get a weather report from wttr.in and store it locally.
            # You could set up a shell alias to view the full file in a pager in the
            # terminal if desired. This function will only be run once a day when needed.
            weatherreport="'$'{XDG_DATA_HOME:-$HOME/.local/dashare'}/weatherreport"
            getforecast() { curl -sf "wttr.in/$LOCATION" > "$weatherreport" || exit 1 ;}
            currweather=$(curl -sf "wttr.in/$LOCATION?format=%c%t+%h\n")
            # | sed 's/ //')
            #weather_option=$(cat ~/.dwm/blocks-scripts/helper-scripts/weather_option)
            if [ -z $WEATHER_OPTION ]; then
                export WEATHER_OPTION=0
            fi
            # Some very particular and terse stream manipulation. We get the maximum
            # precipitation chance and the daily high and low from the downloaded file and
            # display them with coresponding emojis.
            showweather() { printf "%s" "$(sed '16q;d' "$weatherreport" |
                grep -wo "[0-9]*%" | sort -rn | sed "s/^/☔/g;1q" | tr -d '\n')"
            sed '13q;d' "$weatherreport" | grep -o "m\\([-+]\\)*[0-9]\\+" | sed 's/+//g' | sort -n -t 'm' -k 2n | sed -e 1b -e '$!d' | tr '\n|m' ' ' | awk '{print " 🥶" $1 "°","🌞" $2 "°"}' ;}


            # The test if our forcecast is updated to the day. If it isn't download a new
            # weather report from wttr.in with the above function.
            [ "$(stat -c %y "$weatherreport" 2>/dev/null | cut -d' ' -f1)" = "$(date '+%Y-%m-%d')" ] ||
                getforecast

            case $1 in
                1) getforecast
                   echo "$(showweather) "
                   export WEATHER_OPTION=0 #echo 0 > /tmp/weather_option
                   ;;
                0) echo "$currweather ";;
            esac

            #echo 0 > ~/.dwm/blocks-scripts/helper-scripts/weather_option
        '';
        };
    };


    programs.git = {
        enable = true;
        userName = "Alec Davis";
        userEmail = "unlikelytitan@gmail.com";
    };

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
        history.size = 1500;
        history.save = 1000;
        history.path = "${config.xdg.dataHome}/.histfile";
        autocd = true;
    
        shellAliases = {
            cd = "z";
            home = "cd";
            root = "cd /";
            bat = "bat --style plain";
            batf = "bat --style full";
            ls = "exa --icons";
            tree = "exa --tree --icons";
            cp = "cp -iv";
            mv = "mv -iv";
            rm = "trash -v";
            grep = "grep --color=auto";
        };
        localVariables = {
            PROMPT = "❬%F{13}%n%f❭ %f%F{13}図書館に%f %F{12}%d\n%f ";
        };

        sessionVariables = {
            BEMENU_OPTS = "--tb #282c34 --tf #51afef --nb #282c34 --nf #bbc2cf --sb #51afef --sf #444b59 --fb #282c34 --ff #bbc2cf --hb #51afef --hf #444b59 --ab #282c34 --af #bbc2cf";
            PATH = "$PATH:/home/ki11errabbit/.cabal/bin:/home/ki11errabbit/.local/bin:$PATH:/home/ki11errabbit/.local/share/flatpak/exports/bin:/var/lib/flatpak/exports/bin:/home/ki11errabbit/.cargo/bin";
        };

        initExtra = ''
        setopt globdots
        function ya() {
            local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
            yazi "$@" --cwd-file="$tmp"
            if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
                cd -- "$cwd"
            fi
            rm -f -- "$tmp"
        }


        function neovim() {
            local tmp="/tmp/nvim_cwd"
            nvim "$@" 
            cwd="$(cat -- "$tmp")"
            cd -- "$cwd"
            rm -f -- "$tmp"
        }

        # >>> conda initialize >>>
        # !! Contents within this block are managed by 'conda init' !!
        __conda_setup="$('/home/ki11errabbit/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
        if [ $? -eq 0 ]; then
            eval "$__conda_setup"
        else
            if [ -f "/home/ki11errabbit/miniconda3/etc/profile.d/conda.sh" ]; then
                . "/home/ki11errabbit/miniconda3/etc/profile.d/conda.sh"
            else
                export PATH="/home/ki11errabbit/miniconda3/bin:$PATH"
            fi
        fi
        unset __conda_setup
        # <<< conda initialize <<<
        eval "$(zoxide init zsh)"
        '';

    };

    programs.alacritty = {
        enable = true;
        settings = {
            colors = {
                draw_bold_text_with_bright_colors = false;
                normal = {
                    black = "0x282c34";
                    blue = "0x51afef";
                    cyan = "0x46d9ff";
                    green = "0x98be65";
                    magenta = "0xc678dd";
                    red = "0xff6c6b";
                    white = "0xbbc2cf";
                    yellow = "0xecbe7b";
                };
                bright = {
                    black = "0x47505e";
                    blue = "0x5db3ef";
                    cyan = "0x51dbff";
                    green = "0x9bbe6e";
                    magenta = "0xc882dd";
                    red = "0xff7877";
                    white = "0xc4c8cf";
                    yellow = "0xecc286";
                };
                primary = {
                    background = "0x282c34";
                    foreground = "0xbbc2cf";
                };

            };
            cursor = {
                style = {
                    blinking = "On";
                    shape = "Beam";
                };
            };
            font = {
                size = 11;
                normal = {
                    family = "monospace";
                    style = "Text";
                };
                bold = {
                    family = "monospace";
                    style = "Bold";
                };
                bold_italic = {
                    family = "monospace";
                    style = "Bold Italic";
                };
                italic = {
                    family = "monospace";
                    style = "Text Italic";
                };

            };
            key_bindings = [{
                action = "SpawnNewInstance";
                key = "Return";
                mods = "Control|Shift";
            }];
            keybindings = [{
                action = "SpawnNewInstance";
                key = "Return";
                mods = "Control|Shift";
            }];
            scrolling.history = 50000;
            window.padding = {
                x = 0;
                y = 0;
            };
        };
    };

    services.kdeconnect.indicator = true;

    services.emacs = {
        enable = true;
        package = pkgs.emacs;
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. If you don't want to manage your shell through Home
    # Manager then you have to manually source 'hm-session-vars.sh' located at
    # either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/ki11errabbit/etc/profile.d/hm-session-vars.sh
    #
    home.sessionVariables = {
        # EDITOR = "emacs";
    };

    programs.home-manager.enable = true;
}

