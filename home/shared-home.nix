{ inputs, config, pkgs, channels,  ... }:

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
    home.stateVersion = "25.05"; # Please read the comment before changing.
    nixpkgs.config.allowUnfree = true;

    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = with pkgs; [
        inputs.zen-browser.packages."${system}".default
        firefox
        thunderbird
        font-manager
        discord
        kdePackages.dolphin
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
        obs-studio
        libreoffice
        yazi
        kdePackages.kdeconnect-kde
        neofetch
        lua-language-server
        universal-ctags
        vscode
        haskellPackages.lsp
        rust-analyzer
        python312Packages.python-lsp-server
        gopls
        libclang
        jdt-language-server
        yaml-language-server
        twitter-color-emoji
        zig
        zls
        idris2
        emacs-pgtk
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
        transmission_4-gtk
        usbutils
        gparted
        gamescope
        barrier
        fnott
        stow
        haskellPackages.kmonad
        networkmanagerapplet
        appimage-run

        fnott
        wdisplays
        xournalpp
        gimp
        godot-mono
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
        teams-for-linux
        awscli2
        seahorse
        coq
        ocaml
        hugo
        inkscape
        librsvg
        xorg.xcursorgen
        python312Packages.libsass
        sshfs
        filezilla
        superhtml
        python312Packages.debugpy
        gdb
        tmux
        tutanota-desktop
        typescript
        bitwarden
        jetbrains.rust-rover
        imv
        cargo-generate
        pcmanfm
        ldtk
        jetbrains.clion
        jetbrains.rider
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
        ".config/kmonad/t480.kbd".text = ''
            (defcfg
                input (device-file "/dev/input/by-path/platform-i8042-serio-0-event-kbd")
                output (uinput-sink "T480s Keyboard")
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
                esc  mute vold volu f20  brdn brup KeySwitchVideoMode wlan  KeyConfig  KeyBluetooth KeyScale file   home  end   ins   del
                grv  1    2    3    4    5    6    7    8    9    0    -    =     bspc
                tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
                caps a    s    d    f    g    h    j    k    l    ;    '    ret
                lsft z    x    c    v    b    n    m    ,    .    /    rsft
                lctl wkup lmet lalt      spc            ralt ssrq rctl pgup up   pgdn
                                                                       left down rght
            )

            (deflayer colemak
                esc   mute  vold  volu  f20   brdn brup @vido wlan  @cfg  KeyBluetooth @lnch file   home  end   ins   del
                grv   1     2     3     4     5    6    7     8     9     0     -     =      caps
                tab   q     w     f     p     b    j    l     u     y     ;     [     ]     \
                bspc  a     r     s     t     g    m    n     e     i     o     '     ret
                lsft  x     c     d     v     z    k    h     ,     .     /     rsft
                @cctl @fn   lalt  lmet        spc             ralt  ssrq  @cctl pgup  up    pgdn
                                                                                left  down  rght
            )
            (deflayer colemakctl
                C-esc   C-mute  C-vold  C-volu  C-f20   C-brdn C-brup C-@vido C-wlan  C-@cfg  C-KeyBluetooth C-@lnch C-file   C-home  C-end   C-ins   C-del
                C-grv   C-1     C-2     C-3     C-4     C-5    C-6    C-7     C-8     C-9     C-0     C--     C-=      C-caps
                C-tab   C-q     C-w     C-f     C-p     C-b    C-j    C-l     C-u     C-y     C-;     C-[     C-]      C-\
                C-bspc  C-a     C-r     C-s     C-t     C-g    C-m    C-n     C-e     C-i     C-o     C-'     C-ret
                C-lsft  C-x     C-c     C-d     C-v     C-z    C-k    C-h     C-,     C-.     C-/     C-rsft
                _       _       C-lalt  C-lmet          @swchq                C-ralt  C-ssrq  C-rctl  C-pgup  C-up    C-pgdn
                                                                                                      C-left  C-down  C-rght
            )

            (deflayer qwerty
                esc   mute  vold  volu  f20   brdn brup @vido wlan  @cfg  KeyBluetooth @lnch file   home  end   ins   del
                grv   1     2     3     4     5    6    7     8     9     0     -     =      bspc
                tab   q     w     e     r     t    y    u     i     o     p     [     ]      \
                caps  a     s     d     f     g    h    j     k     l     ;     '     ret
                lsft  z     x     c     v     b    n    m     ,     .     /     rsft
                @qctl @fn   lalt  lmet        spc             ralt  ssrq  @qctl pgup  up    pgdn
                                                                                left  down  rght
            )

            (deflayer qwertyctl
                C-esc   C-mute  C-vold  C-volu  C-f20   C-brdn C-brup C-@vido C-wlan  C-@cfg  C-KeyBluetooth C-@lnch C-file   C-home  C-end   C-ins   C-del
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
        ".config/kmonad/t480s.kbd".text = ''
            (defcfg
                input (device-file "/dev/input/by-path/platform-i8042-serio-0-event-kbd")
                output (uinput-sink "T480s Keyboard")
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
                esc  mute vold volu f20  brdn brup KeySwitchVideoMode wlan  KeyConfig  KeyBluetooth KeyScale file   home  end   ins   del
                grv  1    2    3    4    5    6    7    8    9    0    -    =     bspc
                tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
                caps a    s    d    f    g    h    j    k    l    ;    '    ret
                lsft z    x    c    v    b    n    m    ,    .    /    rsft
                lctl wkup lmet lalt      spc            ralt ssrq rctl pgup up   pgdn
                                                                       left down rght
            )

            (deflayer colemak
                esc   mute  vold  volu  f20   brdn brup @vido wlan  @cfg  KeyBluetooth @lnch file   home  end   ins   del
                grv   1     2     3     4     5    6    7     8     9     0     -     =      caps
                tab   q     w     f     p     b    j    l     u     y     ;     [     ]     \
                bspc  a     r     s     t     g    m    n     e     i     o     '     ret
                lsft  x     c     d     v     z    k    h     ,     .     /     rsft
                @cctl @fn   lalt  lmet        spc             ralt  ssrq  @cctl pgup  up    pgdn
                                                                                left  down  rght
            )
            (deflayer colemakctl
                C-esc   C-mute  C-vold  C-volu  C-f20   C-brdn C-brup C-@vido C-wlan  C-@cfg  C-KeyBluetooth C-@lnch C-file   C-home  C-end   C-ins   C-del
                C-grv   C-1     C-2     C-3     C-4     C-5    C-6    C-7     C-8     C-9     C-0     C--     C-=      C-caps
                C-tab   C-q     C-w     C-f     C-p     C-b    C-j    C-l     C-u     C-y     C-;     C-[     C-]      C-\
                C-bspc  C-a     C-r     C-s     C-t     C-g    C-m    C-n     C-e     C-i     C-o     C-'     C-ret
                C-lsft  C-x     C-c     C-d     C-v     C-z    C-k    C-h     C-,     C-.     C-/     C-rsft
                _       _       C-lalt  C-lmet          @swchq                C-ralt  C-ssrq  C-rctl  C-pgup  C-up    C-pgdn
                                                                                                      C-left  C-down  C-rght
            )

            (deflayer qwerty
                esc   mute  vold  volu  f20   brdn brup @vido wlan  @cfg  KeyBluetooth @lnch file   home  end   ins   del
                grv   1     2     3     4     5    6    7     8     9     0     -     =      bspc
                tab   q     w     e     r     t    y    u     i     o     p     [     ]      \
                caps  a     s     d     f     g    h    j     k     l     ;     '     ret
                lsft  z     x     c     v     b    n    m     ,     .     /     rsft
                @qctl @fn   lalt  lmet        spc             ralt  ssrq  @qctl pgup  up    pgdn
                                                                                left  down  rght
            )

            (deflayer qwertyctl
                C-esc   C-mute  C-vold  C-volu  C-f20   C-brdn C-brup C-@vido C-wlan  C-@cfg  C-KeyBluetooth C-@lnch C-file   C-home  C-end   C-ins   C-del
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

            #dbus-daemon --session --address="unix:path=$XDG_RUNTIME_DIR/bus" &
            dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=river &

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
        ".config/waybar/style.css".text = ''
            * {
                all: unset;
                font-family: "LiterationMono Nerd Font", "monospace";
            }

            window#waybar {
              background-color: #eff1f5;
              color: #4c4f69;
              padding-left:10px;
              padding-right:10px;
            }

            #tray menu {
                background-color: #e6e9ef;
                color: #4c4f69;
                padding-left:10px;
                padding-right:10px;
            }

            #tray menu button:hover {
                color: #4c4f69;
                background-color: #dce0e8;
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
              color: #5c5f77;
             }

             #custom-dwl_title {
                 color: #5c5f69;
                 background-color: #eff1f5;
                 padding-left: 2px;
                 padding-right: 2px;
             }

            #tags button {
               color: #4c4f77;
                padding-left: 4px;
                padding-right: 4px;
            }

            #tags button:hover {
                color: #4c4f69;
                background-color: #7287fd;
            }

            #tags button.occupied {
                  color: #4c4f69;
                  background-color: #dce0e8;
            }


            #tags button.focused {
                  color: #4c4f69;
                  background-color: #ea76cb;
            }

            #tags button.occupied:hover {
                  color: #4c4f69;
                  background-color: #7287fd;
            }


            #tags button.focused:hover {
                  color: #4c4f69;
                  background-color: #7287fd;
            }
            /*
            #mode {
              margin-left: 3px;
              padding-left: 4px;
            margin-right: 3px;
            padding-right: 4px;

            }*/

            #window {
                background-color: #dce0e8;
                color: #4c4f69;
                padding-left:10px;
                padding-right:10px;
            }

            #window.focused {
                color: #4c4f69;
                background-color: #ea76cb;
                padding-left:10px;
                padding-right:10px;
            }
        '';
        
        ".config/bat/themes/Catppuccin Latte.tmTheme".text = ''
                <?xml version="1.0" encoding="UTF-8"?>
                <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
                <plist version="1.0">
                  <dict>
                    <key>name</key>
                    <string>Catppuccin Latte</string>
                    <key>semanticClass</key>
                    <string>theme.light.catppuccin-latte</string>
                    <key>uuid</key>
                    <string>96a262cd-4b2f-49f5-9125-8dd0077cbfe1</string>
                    <key>author</key>
                    <string>Catppuccin Org</string>
                    <key>colorSpaceName</key>
                    <string>sRGB</string>
                    <key>settings</key>
                    <array>
                      <dict>
                        <key>settings</key>
                        <dict>
                          <key>background</key>
                          <string>#eff1f5</string>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                          <key>caret</key>
                          <string>#dc8a78</string>
                          <key>lineHighlight</key>
                          <string>#ccd0da</string>
                          <key>misspelling</key>
                          <string>#d20f39</string>
                          <key>accent</key>
                          <string>#8839ef</string>
                          <key>selection</key>
                          <string>#7c7f934d</string>
                          <key>activeGuide</key>
                          <string>#bcc0cc</string>
                          <key>findHighlight</key>
                          <string>#a9daf0</string>
                          <key>gutterForeground</key>
                          <string>#8c8fa1</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Basic text &amp; variable names (incl. leading punctuation)</string>
                        <key>scope</key>
                        <string>text, source, variable.other.readwrite, punctuation.definition.variable</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Parentheses, Brackets, Braces</string>
                        <key>scope</key>
                        <string>punctuation</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#7c7f93</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Comments</string>
                        <key>scope</key>
                        <string>comment, punctuation.definition.comment</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#9ca0b0</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>string, punctuation.definition.string</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#40a02b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>constant.character.escape</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Booleans, constants, numbers</string>
                        <key>scope</key>
                        <string>constant.numeric, variable.other.constant, entity.name.constant, constant.language.boolean, constant.language.false, constant.language.true, keyword.other.unit.user-defined, keyword.other.unit.suffix.floating-point</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>keyword, keyword.operator.word, keyword.operator.new, variable.language.super, support.type.primitive, storage.type, storage.modifier, punctuation.definition.keyword</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>entity.name.tag.documentation</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Punctuation</string>
                        <key>scope</key>
                        <string>keyword.operator, punctuation.accessor, punctuation.definition.generic, meta.function.closure punctuation.section.parameters, punctuation.definition.tag, punctuation.separator.key-value</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>entity.name.function, meta.function-call.method, support.function, support.function.misc, variable.function</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Classes</string>
                        <key>scope</key>
                        <string>entity.name.class, entity.other.inherited-class, support.class, meta.function-call.constructor, entity.name.struct</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Enum</string>
                        <key>scope</key>
                        <string>entity.name.enum</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Enum member</string>
                        <key>scope</key>
                        <string>meta.enum variable.other.readwrite, variable.other.enummember</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Object properties</string>
                        <key>scope</key>
                        <string>meta.property.object</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Types</string>
                        <key>scope</key>
                        <string>meta.type, meta.type-alias, support.type, entity.name.type</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Decorators</string>
                        <key>scope</key>
                        <string>meta.annotation variable.function, meta.annotation variable.annotation.function, meta.annotation punctuation.definition.annotation, meta.decorator, punctuation.decorator</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>variable.parameter, meta.function.parameters</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#e64553</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Built-ins</string>
                        <key>scope</key>
                        <string>constant.language, support.function.builtin</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>entity.other.attribute-name.documentation</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Preprocessor directives</string>
                        <key>scope</key>
                        <string>keyword.control.directive, punctuation.definition.directive</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Type parameters</string>
                        <key>scope</key>
                        <string>punctuation.definition.typeparameters</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#04a5e5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Namespaces</string>
                        <key>scope</key>
                        <string>entity.name.namespace</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Property names (left hand assignments in json/yaml/css)</string>
                        <key>scope</key>
                        <string>support.type.property-name.css</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>This/Self keyword</string>
                        <key>scope</key>
                        <string>variable.language.this, variable.language.this punctuation.definition.variable</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Object properties</string>
                        <key>scope</key>
                        <string>variable.object.property</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>String template interpolation</string>
                        <key>scope</key>
                        <string>string.template variable, string variable</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>`new` as bold</string>
                        <key>scope</key>
                        <string>keyword.operator.new</string>
                        <key>settings</key>
                        <dict>
                          <key>fontStyle</key>
                          <string>bold</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>C++ extern keyword</string>
                        <key>scope</key>
                        <string>storage.modifier.specifier.extern.cpp</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>C++ scope resolution</string>
                        <key>scope</key>
                        <string>entity.name.scope-resolution.template.call.cpp, entity.name.scope-resolution.parameter.cpp, entity.name.scope-resolution.cpp, entity.name.scope-resolution.function.definition.cpp</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>C++ doc keywords</string>
                        <key>scope</key>
                        <string>storage.type.class.doxygen</string>
                        <key>settings</key>
                        <dict>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>C++ operators</string>
                        <key>scope</key>
                        <string>storage.modifier.reference.cpp</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>C# Interpolated Strings</string>
                        <key>scope</key>
                        <string>meta.interpolation.cs</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>C# xml-style docs</string>
                        <key>scope</key>
                        <string>comment.block.documentation.cs</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Classes, reflecting the className color in JSX</string>
                        <key>scope</key>
                        <string>source.css entity.other.attribute-name.class.css, entity.other.attribute-name.parent-selector.css punctuation.definition.entity.css</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Operators</string>
                        <key>scope</key>
                        <string>punctuation.separator.operator.css</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Pseudo classes</string>
                        <key>scope</key>
                        <string>source.css entity.other.attribute-name.pseudo-class</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>source.css constant.other.unicode-range</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>source.css variable.parameter.url</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#40a02b</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>CSS vendored property names</string>
                        <key>scope</key>
                        <string>support.type.vendored.property-name</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#04a5e5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Less/SCSS right-hand variables (@/$-prefixed)</string>
                        <key>scope</key>
                        <string>source.css meta.property-value variable, source.css meta.property-value variable.other.less, source.css meta.property-value variable.other.less punctuation.definition.variable.less, meta.definition.variable.scss</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#e64553</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>CSS variables (--prefixed)</string>
                        <key>scope</key>
                        <string>source.css meta.property-list variable, meta.property-list variable.other.less, meta.property-list variable.other.less punctuation.definition.variable.less</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>CSS Percentage values, styled the same as numbers</string>
                        <key>scope</key>
                        <string>keyword.other.unit.percentage.css</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>CSS Attribute selectors, styled the same as strings</string>
                        <key>scope</key>
                        <string>source.css meta.attribute-selector</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#40a02b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>JSON/YAML keys, other left-hand assignments</string>
                        <key>scope</key>
                        <string>keyword.other.definition.ini, punctuation.support.type.property-name.json, support.type.property-name.json, punctuation.support.type.property-name.toml, support.type.property-name.toml, entity.name.tag.yaml, punctuation.support.type.property-name.yaml, support.type.property-name.yaml</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>JSON/YAML constants</string>
                        <key>scope</key>
                        <string>constant.language.json, constant.language.yaml</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>YAML anchors</string>
                        <key>scope</key>
                        <string>entity.name.type.anchor.yaml, variable.other.alias.yaml</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>TOML tables / ini groups</string>
                        <key>scope</key>
                        <string>support.type.property-name.table, entity.name.section.group-title.ini</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>TOML dates</string>
                        <key>scope</key>
                        <string>constant.other.time.datetime.offset.toml</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>YAML anchor puctuation</string>
                        <key>scope</key>
                        <string>punctuation.definition.anchor.yaml, punctuation.definition.alias.yaml</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>YAML triple dashes</string>
                        <key>scope</key>
                        <string>entity.other.document.begin.yaml</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Markup Diff</string>
                        <key>scope</key>
                        <string>markup.changed.diff</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Diff</string>
                        <key>scope</key>
                        <string>meta.diff.header.from-file, meta.diff.header.to-file, punctuation.definition.from-file.diff, punctuation.definition.to-file.diff</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Diff Inserted</string>
                        <key>scope</key>
                        <string>markup.inserted.diff</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#40a02b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Diff Deleted</string>
                        <key>scope</key>
                        <string>markup.deleted.diff</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>dotenv left-hand side assignments</string>
                        <key>scope</key>
                        <string>variable.other.env</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>dotenv reference to existing env variable</string>
                        <key>scope</key>
                        <string>string.quoted variable.other.env</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>GDScript functions</string>
                        <key>scope</key>
                        <string>support.function.builtin.gdscript</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>GDScript constants</string>
                        <key>scope</key>
                        <string>constant.language.gdscript</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Comment keywords</string>
                        <key>scope</key>
                        <string>comment meta.annotation.go</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#e64553</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>go:embed, go:build, etc.</string>
                        <key>scope</key>
                        <string>comment meta.annotation.parameters.go</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Go constants (nil, true, false)</string>
                        <key>scope</key>
                        <string>constant.language.go</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>GraphQL variables</string>
                        <key>scope</key>
                        <string>variable.graphql</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>GraphQL aliases</string>
                        <key>scope</key>
                        <string>string.unquoted.alias.graphql</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#dd7878</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>GraphQL enum members</string>
                        <key>scope</key>
                        <string>constant.character.enum.graphql</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>GraphQL field in types</string>
                        <key>scope</key>
                        <string>meta.objectvalues.graphql constant.object.key.graphql string.unquoted.graphql</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#dd7878</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>HTML/XML DOCTYPE as keyword</string>
                        <key>scope</key>
                        <string>keyword.other.doctype, meta.tag.sgml.doctype punctuation.definition.tag, meta.tag.metadata.doctype entity.name.tag, meta.tag.metadata.doctype punctuation.definition.tag</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>HTML/XML-like &lt;tags/&gt;</string>
                        <key>scope</key>
                        <string>entity.name.tag</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Special characters like &amp;amp;</string>
                        <key>scope</key>
                        <string>text.html constant.character.entity, text.html constant.character.entity punctuation, constant.character.entity.xml, constant.character.entity.xml punctuation, constant.character.entity.js.jsx, constant.charactger.entity.js.jsx punctuation, constant.character.entity.tsx, constant.character.entity.tsx punctuation</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>HTML/XML tag attribute values</string>
                        <key>scope</key>
                        <string>entity.other.attribute-name</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Components</string>
                        <key>scope</key>
                        <string>support.class.component, support.class.component.jsx, support.class.component.tsx, support.class.component.vue</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Annotations</string>
                        <key>scope</key>
                        <string>punctuation.definition.annotation, storage.type.annotation</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Java enums</string>
                        <key>scope</key>
                        <string>constant.other.enum.java</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Java imports</string>
                        <key>scope</key>
                        <string>storage.modifier.import.java</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Javadoc</string>
                        <key>scope</key>
                        <string>comment.block.javadoc.java keyword.other.documentation.javadoc.java</string>
                        <key>settings</key>
                        <dict>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Exported Variable</string>
                        <key>scope</key>
                        <string>meta.export variable.other.readwrite.js</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#e64553</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>JS/TS constants &amp; properties</string>
                        <key>scope</key>
                        <string>variable.other.constant.js, variable.other.constant.ts, variable.other.property.js, variable.other.property.ts</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>JSDoc; these are mainly params, so styled as such</string>
                        <key>scope</key>
                        <string>variable.other.jsdoc, comment.block.documentation variable.other</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#e64553</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>JSDoc keywords</string>
                        <key>scope</key>
                        <string>storage.type.class.jsdoc</string>
                        <key>settings</key>
                        <dict>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>support.type.object.console.js</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Node constants as keywords (module, etc.)</string>
                        <key>scope</key>
                        <string>support.constant.node, support.type.object.module.js</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>implements as keyword</string>
                        <key>scope</key>
                        <string>storage.modifier.implements</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Builtin types</string>
                        <key>scope</key>
                        <string>constant.language.null.js, constant.language.null.ts, constant.language.undefined.js, constant.language.undefined.ts, support.type.builtin.ts</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>variable.parameter.generic</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Arrow functions</string>
                        <key>scope</key>
                        <string>keyword.declaration.function.arrow.js, storage.type.function.arrow.ts</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Decorator punctuations (decorators inherit from blue functions, instead of styleguide peach)</string>
                        <key>scope</key>
                        <string>punctuation.decorator.ts</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Extra JS/TS keywords</string>
                        <key>scope</key>
                        <string>keyword.operator.expression.in.js, keyword.operator.expression.in.ts, keyword.operator.expression.infer.ts, keyword.operator.expression.instanceof.js, keyword.operator.expression.instanceof.ts, keyword.operator.expression.is, keyword.operator.expression.keyof.ts, keyword.operator.expression.of.js, keyword.operator.expression.of.ts, keyword.operator.expression.typeof.ts</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Julia macros</string>
                        <key>scope</key>
                        <string>support.function.macro.julia</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Julia language constants (true, false)</string>
                        <key>scope</key>
                        <string>constant.language.julia</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Julia other constants (these seem to be arguments inside arrays)</string>
                        <key>scope</key>
                        <string>constant.other.symbol.julia</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#e64553</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>LaTeX preamble</string>
                        <key>scope</key>
                        <string>text.tex keyword.control.preamble</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>LaTeX be functions</string>
                        <key>scope</key>
                        <string>text.tex support.function.be</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#04a5e5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>LaTeX math</string>
                        <key>scope</key>
                        <string>constant.other.general.math.tex</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#dd7878</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Lua docstring keywords</string>
                        <key>scope</key>
                        <string>comment.line.double-dash.documentation.lua storage.type.annotation.lua</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Lua docstring variables</string>
                        <key>scope</key>
                        <string>comment.line.double-dash.documentation.lua entity.name.variable.lua, comment.line.double-dash.documentation.lua variable.lua</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>heading.1.markdown punctuation.definition.heading.markdown, heading.1.markdown, markup.heading.atx.1.mdx, markup.heading.atx.1.mdx punctuation.definition.heading.mdx, markup.heading.setext.1.markdown, markup.heading.heading-0.asciidoc</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>heading.2.markdown punctuation.definition.heading.markdown, heading.2.markdown, markup.heading.atx.2.mdx, markup.heading.atx.2.mdx punctuation.definition.heading.mdx, markup.heading.setext.2.markdown, markup.heading.heading-1.asciidoc</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>heading.3.markdown punctuation.definition.heading.markdown, heading.3.markdown, markup.heading.atx.3.mdx, markup.heading.atx.3.mdx punctuation.definition.heading.mdx, markup.heading.heading-2.asciidoc</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>heading.4.markdown punctuation.definition.heading.markdown, heading.4.markdown, markup.heading.atx.4.mdx, markup.heading.atx.4.mdx punctuation.definition.heading.mdx, markup.heading.heading-3.asciidoc</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#40a02b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>heading.5.markdown punctuation.definition.heading.markdown, heading.5.markdown, markup.heading.atx.5.mdx, markup.heading.atx.5.mdx punctuation.definition.heading.mdx, markup.heading.heading-4.asciidoc</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>heading.6.markdown punctuation.definition.heading.markdown, heading.6.markdown, markup.heading.atx.6.mdx, markup.heading.atx.6.mdx punctuation.definition.heading.mdx, markup.heading.heading-5.asciidoc</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>markup.bold</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                          <key>fontStyle</key>
                          <string>bold</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>markup.italic</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>markup.strikethrough</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#6c6f85</string>
                          <key>fontStyle</key>
                          <string>strikethrough</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Markdown auto links</string>
                        <key>scope</key>
                        <string>punctuation.definition.link, markup.underline.link</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Markdown links</string>
                        <key>scope</key>
                        <string>text.html.markdown punctuation.definition.link.title, string.other.link.title.markdown, markup.link, punctuation.definition.constant.markdown, constant.other.reference.link.markdown, markup.substitution.attribute-reference</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#7287fd</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Markdown code spans</string>
                        <key>scope</key>
                        <string>punctuation.definition.raw.markdown, markup.inline.raw.string.markdown, markup.raw.block.markdown</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#40a02b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Markdown triple backtick language identifier</string>
                        <key>scope</key>
                        <string>fenced_code.block.language</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#04a5e5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Markdown triple backticks</string>
                        <key>scope</key>
                        <string>markup.fenced_code.block punctuation.definition, markup.raw support.asciidoc</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#7c7f93</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Markdown quotes</string>
                        <key>scope</key>
                        <string>markup.quote, punctuation.definition.quote.begin</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Markdown separators</string>
                        <key>scope</key>
                        <string>meta.separator.markdown</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Markdown list bullets</string>
                        <key>scope</key>
                        <string>punctuation.definition.list.begin.markdown, markup.list.bullet</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Nix attribute names</string>
                        <key>scope</key>
                        <string>entity.other.attribute-name.multipart.nix, entity.other.attribute-name.single.nix</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Nix parameter names</string>
                        <key>scope</key>
                        <string>variable.parameter.name.nix</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Nix interpolated parameter names</string>
                        <key>scope</key>
                        <string>meta.embedded variable.parameter.name.nix</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#7287fd</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Nix paths</string>
                        <key>scope</key>
                        <string>string.unquoted.path.nix</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>PHP Attributes</string>
                        <key>scope</key>
                        <string>support.attribute.builtin, meta.attribute.php</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>PHP Parameters (needed for the leading dollar sign)</string>
                        <key>scope</key>
                        <string>meta.function.parameters.php punctuation.definition.variable.php</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#e64553</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>PHP Constants (null, __FILE__, etc.)</string>
                        <key>scope</key>
                        <string>constant.language.php</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>PHP functions</string>
                        <key>scope</key>
                        <string>text.html.php support.function</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#04a5e5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>PHPdoc keywords</string>
                        <key>scope</key>
                        <string>keyword.other.phpdoc.php</string>
                        <key>settings</key>
                        <dict>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Python argument functions reset to text, otherwise they inherit blue from function-call</string>
                        <key>scope</key>
                        <string>support.variable.magic.python, meta.function-call.arguments.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Python double underscore functions</string>
                        <key>scope</key>
                        <string>support.function.magic.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#04a5e5</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Python `self` keyword</string>
                        <key>scope</key>
                        <string>variable.parameter.function.language.special.self.python, variable.language.special.self.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>python keyword flow/logical (for ... in)</string>
                        <key>scope</key>
                        <string>keyword.control.flow.python, keyword.operator.logical.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>python storage type</string>
                        <key>scope</key>
                        <string>storage.type.function.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>python function support</string>
                        <key>scope</key>
                        <string>support.token.decorator.python, meta.function.decorator.identifier.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#04a5e5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>python function calls</string>
                        <key>scope</key>
                        <string>meta.function-call.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>python function decorators</string>
                        <key>scope</key>
                        <string>entity.name.function.decorator.python, punctuation.definition.decorator.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>python placeholder reset to normal string</string>
                        <key>scope</key>
                        <string>constant.character.format.placeholder.other.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Python exception &amp; builtins such as exit()</string>
                        <key>scope</key>
                        <string>support.type.exception.python, support.function.builtin.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>entity.name.type</string>
                        <key>scope</key>
                        <string>support.type.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>python constants (True/False)</string>
                        <key>scope</key>
                        <string>constant.language.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Arguments accessed later in the function body</string>
                        <key>scope</key>
                        <string>meta.indexed-name.python, meta.item-access.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#e64553</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Python f-strings/binary/unicode storage types</string>
                        <key>scope</key>
                        <string>storage.type.string.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#40a02b</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Python type hints</string>
                        <key>scope</key>
                        <string>meta.function.parameters.python</string>
                        <key>settings</key>
                        <dict>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Regex string begin/end in JS/TS</string>
                        <key>scope</key>
                        <string>string.regexp punctuation.definition.string.begin, string.regexp punctuation.definition.string.end</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Regex anchors (^, $)</string>
                        <key>scope</key>
                        <string>keyword.control.anchor.regexp</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Regex regular string match</string>
                        <key>scope</key>
                        <string>string.regexp.ts</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Regex group parenthesis &amp; backreference (\1, \2, \3, ...)</string>
                        <key>scope</key>
                        <string>punctuation.definition.group.regexp, keyword.other.back-reference.regexp</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#40a02b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Regex character class []</string>
                        <key>scope</key>
                        <string>punctuation.definition.character-class.regexp</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Regex character classes (\d, \w, \s)</string>
                        <key>scope</key>
                        <string>constant.other.character-class.regexp</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Regex range</string>
                        <key>scope</key>
                        <string>constant.other.character-class.range.regexp</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#dc8a78</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Regex quantifier</string>
                        <key>scope</key>
                        <string>keyword.operator.quantifier.regexp</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Regex constant/numeric</string>
                        <key>scope</key>
                        <string>constant.character.numeric.regexp</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Regex lookaheads, negative lookaheads, lookbehinds, negative lookbehinds</string>
                        <key>scope</key>
                        <string>punctuation.definition.group.no-capture.regexp, meta.assertion.look-ahead.regexp, meta.assertion.negative-look-ahead.regexp</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust attribute</string>
                        <key>scope</key>
                        <string>meta.annotation.rust, meta.annotation.rust punctuation, meta.attribute.rust, punctuation.definition.attribute.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust attribute strings</string>
                        <key>scope</key>
                        <string>meta.attribute.rust string.quoted.double.rust, meta.attribute.rust string.quoted.single.char.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust keyword</string>
                        <key>scope</key>
                        <string>entity.name.function.macro.rules.rust, storage.type.module.rust, storage.modifier.rust, storage.type.struct.rust, storage.type.enum.rust, storage.type.trait.rust, storage.type.union.rust, storage.type.impl.rust, storage.type.rust, storage.type.function.rust, storage.type.type.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust u/i32, u/i64, etc.</string>
                        <key>scope</key>
                        <string>entity.name.type.numeric.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust generic</string>
                        <key>scope</key>
                        <string>meta.generic.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust impl</string>
                        <key>scope</key>
                        <string>entity.name.impl.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust module</string>
                        <key>scope</key>
                        <string>entity.name.module.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust trait</string>
                        <key>scope</key>
                        <string>entity.name.trait.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust struct</string>
                        <key>scope</key>
                        <string>storage.type.source.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust union</string>
                        <key>scope</key>
                        <string>entity.name.union.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust enum member</string>
                        <key>scope</key>
                        <string>meta.enum.rust storage.type.source.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust macro</string>
                        <key>scope</key>
                        <string>support.macro.rust, meta.macro.rust support.function.rust, entity.name.function.macro.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust lifetime</string>
                        <key>scope</key>
                        <string>storage.modifier.lifetime.rust, entity.name.type.lifetime</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust string formatting</string>
                        <key>scope</key>
                        <string>string.quoted.double.rust constant.other.placeholder.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust return type generic</string>
                        <key>scope</key>
                        <string>meta.function.return-type.rust meta.generic.rust storage.type.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust functions</string>
                        <key>scope</key>
                        <string>meta.function.call.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust angle brackets</string>
                        <key>scope</key>
                        <string>punctuation.brackets.angle.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#04a5e5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust constants</string>
                        <key>scope</key>
                        <string>constant.other.caps.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust function parameters</string>
                        <key>scope</key>
                        <string>meta.function.definition.rust variable.other.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#e64553</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust closure variables</string>
                        <key>scope</key>
                        <string>meta.function.call.rust variable.other.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust self</string>
                        <key>scope</key>
                        <string>variable.language.self.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust metavariable names</string>
                        <key>scope</key>
                        <string>variable.other.metavariable.name.rust, meta.macro.metavariable.rust keyword.operator.macro.dollar.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Shell shebang</string>
                        <key>scope</key>
                        <string>comment.line.shebang, comment.line.shebang punctuation.definition.comment, comment.line.shebang, punctuation.definition.comment.shebang.shell, meta.shebang.shell</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Shell shebang command</string>
                        <key>scope</key>
                        <string>comment.line.shebang constant.language</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Shell interpolated command</string>
                        <key>scope</key>
                        <string>meta.function-call.arguments.shell punctuation.definition.variable.shell, meta.function-call.arguments.shell punctuation.section.interpolation, meta.function-call.arguments.shell punctuation.definition.variable.shell, meta.function-call.arguments.shell punctuation.section.interpolation</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Shell interpolated command variable</string>
                        <key>scope</key>
                        <string>meta.string meta.interpolation.parameter.shell variable.other.readwrite</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>source.shell punctuation.section.interpolation, punctuation.definition.evaluation.backticks.shell</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Shell EOF</string>
                        <key>scope</key>
                        <string>entity.name.tag.heredoc.shell</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Shell quoted variable</string>
                        <key>scope</key>
                        <string>string.quoted.double.shell variable.other.normal.shell</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>JSON Keys</string>
                        <key>scope</key>
                        <string>source.json meta.mapping.key string</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>JSON key surrounding quotes</string>
                        <key>scope</key>
                        <string>source.json meta.mapping.key punctuation.definition.string.begin, source.json meta.mapping.key punctuation.definition.string.end</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#7c7f93</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>markup.heading.synopsis.man, markup.heading.title.man, markup.heading.other.man, markup.heading.env.man</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>markup.heading.commands.man</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>markup.heading.env.man</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Man page options</string>
                        <key>scope</key>
                        <string>entity.name</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>markup.heading.1.markdown</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>markup.heading.2.markdown</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>markup.heading.markdown</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                    </array>
                  </dict>
                </plist>
        '';

        ".config/btop/themes/catppuccin_latte.theme".text = ''
            # Main background, empty for terminal default, need to be empty if you want transparent background
            theme[main_bg]="#eff1f5"

            # Main text color
            theme[main_fg]="#4c4f69"

            # Title color for boxes
            theme[title]="#4c4f69"

            # Highlight color for keyboard shortcuts
            theme[hi_fg]="#1e66f5"

            # Background color of selected item in processes box
            theme[selected_bg]="#bcc0cc"

            # Foreground color of selected item in processes box
            theme[selected_fg]="#1e66f5"

            # Color of inactive/disabled text
            theme[inactive_fg]="#8c8fa1"

            # Color of text appearing on top of graphs, i.e uptime and current network graph scaling
            theme[graph_text]="#dc8a78"

            # Background color of the percentage meters
            theme[meter_bg]="#bcc0cc"

            # Misc colors for processes box including mini cpu graphs, details memory graph and details status text
            theme[proc_misc]="#dc8a78"

            # CPU, Memory, Network, Proc box outline colors
            theme[cpu_box]="#8839ef" #Mauve
            theme[mem_box]="#40a02b" #Green
            theme[net_box]="#e64553" #Maroon
            theme[proc_box]="#1e66f5" #Blue

            # Box divider line and small boxes line color
            theme[div_line]="#9ca0b0"

            # Temperature graph color (Green -> Yellow -> Red)
            theme[temp_start]="#40a02b"
            theme[temp_mid]="#df8e1d"
            theme[temp_end]="#d20f39"

            # CPU graph colors (Teal -> Lavender)
            theme[cpu_start]="#179299"
            theme[cpu_mid]="#209fb5"
            theme[cpu_end]="#7287fd"

            # Mem/Disk free meter (Mauve -> Lavender -> Blue)
            theme[free_start]="#8839ef"
            theme[free_mid]="#7287fd"
            theme[free_end]="#1e66f5"

            # Mem/Disk cached meter (Sapphire -> Lavender)
            theme[cached_start]="#209fb5"
            theme[cached_mid]="#1e66f5"
            theme[cached_end]="#7287fd"

            # Mem/Disk available meter (Peach -> Red)
            theme[available_start]="#fe640b"
            theme[available_mid]="#e64553"
            theme[available_end]="#d20f39"

            # Mem/Disk used meter (Green -> Sky)
            theme[used_start]="#40a02b"
            theme[used_mid]="#179299"
            theme[used_end]="#04a5e5"

            # Download graph colors (Peach -> Red)
            theme[download_start]="#fe640b"
            theme[download_mid]="#e64553"
            theme[download_end]="#d20f39"

            # Upload graph colors (Green -> Sky)
            theme[upload_start]="#40a02b"
            theme[upload_mid]="#179299"
            theme[upload_end]="#04a5e5"

            # Process box color gradient for threads, mem and cpu usage (Sapphire -> Mauve)
            theme[process_start]="#209fb5"
            theme[process_mid]="#7287fd"
            theme[process_end]="#8839ef"
        '';

        ".config/btop/config".text = ''
        --theme="Catppuccin Latte"
        '';
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
            BEMENU_OPTS = "--fb '#eff1f5' --ff '#4c4f69' --nb '#eff1f5' --nf '#4c4f69' --tb '#eff1f5' --hb '#eff1f5' --tf '#d20f39' --hf '#df8e1d' --af '#4c4f69' --ab '#eff1f5'";

            PATH = "$PATH:/home/ki11errabbit/.cabal/bin:/home/ki11errabbit/.local/bin:$PATH:/home/ki11errabbit/.local/share/flatpak/exports/bin:/var/lib/flatpak/exports/bin:/home/ki11errabbit/.cargo/bin";
        };

        initContent = ''
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
                    black = "0xbcc0cc";
                    blue = "0x1e66f5";
                    cyan = "0x179299";
                    green = "0x40a02b";
                    magenta = "0xea76cb";
                    red = "0xd20f39";
                    white = "0x5c5f77";
                    yellow = "0xdf8e1d";
                };
                bright = {
                    black = "0xacb0be";
                    blue = "0x1e66f5";
                    cyan = "0x179299";
                    green = "0x40a02b";
                    magenta = "0xea76cb";
                    red = "0xd20f39";
                    white = "0x6c6f85";
                    yellow = "0xdf8e1d";
                };
                primary = {
                    background = "0xeff1f5";
                    foreground = "0x4c4f69";
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
            keyboard.bindings = [{
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
        package = pkgs.emacs-pgtk;
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

    xdg.desktopEntries = {
        run-java-jar = {
            name = "Run Java Jar";
            genericName = "Java Jar";
            exec = "java -jar %F";
            icon = "java";
            mimeType = [ "application/x-java-archive" ];
            categories = [ "Development" "Java" ];
            comment = "Run a Java JAR file";
            terminal = false;
        };
        emacsclient = {
            name = "Emacs Client";
            genericName = "Emacs Client";
            exec = "emacsclient -c -a \"emacs\" %F";
            icon = "emacs";
            categories = [ "Development" "TextEditor" "Utility" ];
            comment = "Edit text files with Emacs";
            terminal = false;
        };
        emacsdaemon = {
            name = "Emacs Daemon";
            genericName = "Emacs Daemon";
            exec = "emacs --daemon";
            icon = "emacs";
            categories = [ "Development" "TextEditor" "Utility" ];
            comment = "Start an Emacs daemon";
            terminal = false;
        };
    };

    xdg.mimeApps = {
        enable = true;
        associations.added = {
            "application/pdf" = [ "okularApplication_pdf.desktop" ];
            "application/x-extension-html" = [ "firefox.desktop" ];
            "application/x-extension-htm" = [ "firefox.desktop" ];
            "application/x-extension-xhtml" = [ "firefox.desktop" ];
            "application/x-extension-shtml" = [ "firefox.desktop" ];
            "application/x-extension-xht" = [ "firefox.desktop" ];
            "application/xhtml+xml" = [ "firefox.desktop" ];
            "application/xml" = [ "emacsclient.desktop" ];
            "text/html" = [ "firefox.desktop" ];
            "application/x-shellscript" = [ "emacsclient.desktop" ];
            "text/x-shellscript" = [ "emacsclient.desktop" ];
            "application/x-extension-txt" = [ "emacsclient.desktop" ];
            "text/plain" = [ "emacsclient.desktop" ];
            "application/x-extension-md" = [ "emacsclient.desktop" ];
            "application/x-extension-markdown" = [ "emacsclient.desktop" ];
            "application/x-extension-c" = [ "emacsclient.desktop" ];
            "application/x-extension-clj" = [ "emacsclient.desktop" ];
            "application/x-extension-cljc" = [ "emacsclient.desktop" ];
            "application/x-extension-cljscm" = [ "emacsclient.desktop" ];
            "application/x-extension-cljs" = [ "emacsclient.desktop" ];
            "application/x-extension-cpp" = [ "emacsclient.desktop" ];
            "text/english" = [ "emacsclient.desktop" ];
            "text/rust" = [ "emacsclient.desktop" ];
            "text/xml" = [ "emacsclient.desktop" ];
            "text/x-c" = [ "emacsclient.desktop" ];
            "text/x-csrc" = [ "emacsclient.desktop" ];
            "text/x-c++src" = [ "emacsclient.desktop" ];
            "text/x-emacs-lisp" = [ "emacsclient.desktop" ];
            "text/x-patch" = [ "emacsclient.desktop" ];
            "text/x-java" = [ "emacsclient.desktop" ];
            "text/x-log" = [ "emacsclient.desktop" ];
            "text/x-lua" = [ "emacsclient.desktop" ];
            "text/x-python" = [ "emacsclient.desktop" ];
            "text/x-makefile" = [ "emacsclient.desktop" ];
            "text/x-pascal" = [ "emacsclient.desktop" ];
            "text/x-chdr" = [ "emacsclient.desktop" ];
            "text/csv" = [ "libreoffice-calc.desktop" ];
            "text/x-tex" = [ "emacsclient.desktop" ];
            "text/x-c++" = [ "emacsclient.desktop" ];
            "text/x-c++hdr" = [ "emacsclient.desktop" ];
            "application/x-extension-tex" = [ "emacsclient.desktop" ];
            "application/x-extension-texinfo" = [ "emacsclient.desktop" ];
            "application/x-extension-texi" = [ "emacsclient.desktop" ];
            "application/x-extension-epub" = [ "okularApplication_epub.desktop" ];
            "audio/flac" = [ "audacious.desktop" ];
            "audio/x-flac" = [ "audacious.desktop" ];
            "audio/mpeg" = [ "audacious.desktop" ];
            "audio/x-m4a" = [ "audacious.desktop" ];
            "audio/x-wav" = [ "audacious.desktop" ];
            "audio/x-opus" = [ "audacious.desktop" ];
            "audio/ogg" = [ "audacious.desktop" ];
            "audio/x-vorbis+ogg" = [ "audacious.desktop" ];
            "audio/x-musepack" = [ "audacious.desktop" ];
            "video/mp4" = [ "mpv.desktop" ];
            "video/x-matroska" = [ "mpv.desktop" ];
            "video/x-matroska-3d" = [ "mpv.desktop" ];
            "video/webm" = [ "mpv.desktop" ];
            "video/avi" = [ "mpv.desktop" ];
            "video/x-flv" = [ "mpv.desktop" ];
            "video/quicktime" = [ "mpv.desktop" ];
            "inode/directory" = [ "pcmanfm.desktop" ];
            "x-scheme-handler/about" = [ "firefox.desktop" ];
            "x-scheme-handler/attachment" = [ "firefox.desktop" ];
            "x-scheme-handler/chrome" = [ "firefox.desktop" ];
            "x-scheme-handler/http" = [ "firefox.desktop" ];
            "x-scheme-handler/https" = [ "firefox.desktop" ];
            "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
            "x-scheme-handler/msteams" = [ "teams-for-linux.desktop" ];
            "x-scheme-handler/ror2mm" = [ "r2modman.desktop" ];
            "x-scheme-handler/sgnl" = [ "signal-desktop.desktop" ];
            "x-scheme-handler/signalcaptcha" = [ "signal-desktop.desktop" ];
            "x-scheme-handler/slack" = [ "slack.desktop" ];
            "application/zip" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-java-archive" = [ "run-java-jar.desktop" "org.gnome.FileRoller.desktop" ];
            "application/x-bittorrent" = [ "transmission-qt.desktop" ];
            "application/x-ms-dos-executable" = [ "wine.desktop" ];
            "application/x-msi" = [ "wine.desktop" ];
            "application/x-ms-shortcut" = [ "wine.desktop" ];
            "application/x-ms-wim" = [ "wine.desktop" ];
            "application/x-cd-image" = [ "org.gnome.FileRoller.desktop" ];
            "x-scheme-handler/steam" = [ "steam.desktop" ];
            "x-scheme-handler/itchio" = [ "itch.desktop" ];
            "x-scheme-handler/tel" = [ "org.kde.kdeconnect.handler.desktop" ];
            "application/x-tar" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-xz" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-bzip" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-bzip-compressed-tar" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-gzip" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-lzma" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-lzip" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-lz4" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-lz4-compressed-tar" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-krita" = [ "krita_kra.desktop" ];
        };
        defaultApplications = {
            "application/pdf" = [ "okularApplication_pdf.desktop" ];
            "application/x-extension-html" = [ "firefox.desktop" ];
            "application/x-extension-htm" = [ "firefox.desktop" ];
            "application/x-extension-xhtml" = [ "firefox.desktop" ];
            "application/x-extension-shtml" = [ "firefox.desktop" ];
            "application/x-extension-xht" = [ "firefox.desktop" ];
            "application/xhtml+xml" = [ "firefox.desktop" ];
            "application/xml" = [ "emacsclient.desktop" ];
            "text/html" = [ "firefox.desktop" ];
            "application/x-shellscript" = [ "emacsclient.desktop" ];
            "text/x-shellscript" = [ "emacsclient.desktop" ];
            "application/x-extension-txt" = [ "emacsclient.desktop" ];
            "text/plain" = [ "emacsclient.desktop" ];
            "application/x-extension-md" = [ "emacsclient.desktop" ];
            "application/x-extension-markdown" = [ "emacsclient.desktop" ];
            "application/x-extension-c" = [ "emacsclient.desktop" ];
            "application/x-extension-clj" = [ "emacsclient.desktop" ];
            "application/x-extension-cljc" = [ "emacsclient.desktop" ];
            "application/x-extension-cljscm" = [ "emacsclient.desktop" ];
            "application/x-extension-cljs" = [ "emacsclient.desktop" ];
            "application/x-extension-cpp" = [ "emacsclient.desktop" ];
            "text/english" = [ "emacsclient.desktop" ];
            "text/rust" = [ "emacsclient.desktop" ];
            "text/xml" = [ "emacsclient.desktop" ];
            "text/x-c" = [ "emacsclient.desktop" ];
            "text/x-csrc" = [ "emacsclient.desktop" ];
            "text/x-c++src" = [ "emacsclient.desktop" ];
            "text/x-emacs-lisp" = [ "emacsclient.desktop" ];
            "text/x-patch" = [ "emacsclient.desktop" ];
            "text/x-java" = [ "emacsclient.desktop" ];
            "text/x-log" = [ "emacsclient.desktop" ];
            "text/x-lua" = [ "emacsclient.desktop" ];
            "text/x-python" = [ "emacsclient.desktop" ];
            "text/x-makefile" = [ "emacsclient.desktop" ];
            "text/x-pascal" = [ "emacsclient.desktop" ];
            "text/x-chdr" = [ "emacsclient.desktop" ];
            "text/csv" = [ "libreoffice-calc.desktop" ];
            "text/x-tex" = [ "emacsclient.desktop" ];
            "text/x-c++" = [ "emacsclient.desktop" ];
            "text/x-c++hdr" = [ "emacsclient.desktop" ];
            "application/x-extension-tex" = [ "emacsclient.desktop" ];
            "application/x-extension-texinfo" = [ "emacsclient.desktop" ];
            "application/x-extension-texi" = [ "emacsclient.desktop" ];
            "application/x-extension-epub" = [ "okularApplication_epub.desktop" ];
            "audio/flac" = [ "audacious.desktop" ];
            "audio/x-flac" = [ "audacious.desktop" ];
            "audio/mpeg" = [ "audacious.desktop" ];
            "audio/x-m4a" = [ "audacious.desktop" ];
            "audio/x-wav" = [ "audacious.desktop" ];
            "audio/x-opus" = [ "audacious.desktop" ];
            "audio/ogg" = [ "audacious.desktop" ];
            "audio/x-vorbis+ogg" = [ "audacious.desktop" ];
            "audio/x-musepack" = [ "audacious.desktop" ];
            "video/mp4" = [ "mpv.desktop" ];
            "video/x-matroska" = [ "mpv.desktop" ];
            "video/x-matroska-3d" = [ "mpv.desktop" ];
            "video/webm" = [ "mpv.desktop" ];
            "video/avi" = [ "mpv.desktop" ];
            "video/x-flv" = [ "mpv.desktop" ];
            "video/quicktime" = [ "mpv.desktop" ];
            "inode/directory" = [ "pcmanfm.desktop" ];
            "x-scheme-handler/about" = [ "firefox.desktop" ];
            "x-scheme-handler/attachment" = [ "firefox.desktop" ];
            "x-scheme-handler/chrome" = [ "firefox.desktop" ];
            "x-scheme-handler/http" = [ "firefox.desktop" ];
            "x-scheme-handler/https" = [ "firefox.desktop" ];
            "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
            "x-scheme-handler/msteams" = [ "teams-for-linux.desktop" ];
            "x-scheme-handler/ror2mm" = [ "r2modman.desktop" ];
            "x-scheme-handler/sgnl" = [ "signal-desktop.desktop" ];
            "x-scheme-handler/signalcaptcha" = [ "signal-desktop.desktop" ];
            "x-scheme-handler/slack" = [ "slack.desktop" ];
            "application/zip" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-java-archive" = [ "run-java-jar.desktop" "org.gnome.FileRoller.desktop" ];
            "application/x-bittorrent" = [ "transmission-qt.desktop" ];
            "application/x-ms-dos-executable" = [ "wine.desktop" ];
            "application/x-msi" = [ "wine.desktop" ];
            "application/x-ms-shortcut" = [ "wine.desktop" ];
            "application/x-ms-wim" = [ "wine.desktop" ];
            "application/x-cd-image" = [ "org.gnome.FileRoller.desktop" ];
            "x-scheme-handler/steam" = [ "steam.desktop" ];
            "x-scheme-handler/itchio" = [ "itch.desktop" ];
            "x-scheme-handler/tel" = [ "org.kde.kdeconnect.handler.desktop" ];
            "application/x-tar" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-xz" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-bzip" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-bzip-compressed-tar" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-gzip" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-lzma" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-lzip" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-lz4" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-lz4-compressed-tar" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-krita" = [ "krita_kra.desktop" ];

        };
    };

    programs.home-manager.enable = true;
}

