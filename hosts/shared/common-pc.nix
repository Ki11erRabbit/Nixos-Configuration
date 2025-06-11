{ config, pkgs, lib, ... }:
let dwl-source = pkgs.fetchFromGitHub {
    owner = "Ki11erRabbit";
    repo = "dwl";
    rev = "main";
    hash = "sha256-ge7tKEVCG2hlxLTgdBvr/3zTJVCo/sJlxKXmwpdERmI=";
    };
    dwl-custom = (pkgs.callPackage "${dwl-source}/dwl.nix" {});
    patchelfFixes = pkgs.patchelfUnstable.overrideAttrs (_finalAttrs: _previousAttrs: {
        src = pkgs.fetchFromGitHub {
            owner = "Patryk27";
            repo = "patchelf";
            rev = "527926dd9d7f1468aa12f56afe6dcc976941fedb";
            sha256 = "sha256-3I089F2kgGMidR4hntxz5CKzZh5xoiUwUsUwLFUEXqE=";
        };
      });
      pcloudFixes = pkgs.pcloud.overrideAttrs (_finalAttrs:previousAttrs: {
          nativeBuildInputs = previousAttrs.nativeBuildInputs ++ [ patchelfFixes ];
      });

in {
    nix.settings.experimental-features = "nix-command flakes";

    services.fwupd.enable = true;
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    hardware.graphics.enable = true;
    
    #time.timeZone = "America/Denver";
    time.timeZone = "America/Los_Angeles";
    #services.automatic-timezoned.enable = true;
    #networking.timeServers = [ "time.cloudflare.com" "time.google.com" ];

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    environment.pathsToLink = [ "/share/zsh" ];
    environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID";

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    security.pam.services.sddm.enableGnomeKeyring = true;
    services.displayManager.sessionPackages = [
        ((pkgs.writeTextDir "share/wayland-sessions/dwl.desktop" ''
        [Desktop Entry]
        Name=dwl
        Comment=dwm for Wayland
        Exec=startdwl.sh
        Type=Application
        '')
        .overrideAttrs (_: {passthru.providedSessions = ["dwl"];}))
        ((pkgs.writeTextDir "share/wayland-sessions/wio.desktop" ''
        [Desktop Entry]
        Name=wio
        Comment=rio for Wayland
        Exec=wio
        Type=Application
        '')
        .overrideAttrs (_: {passthru.providedSessions = ["wio"];}))
    ];
    services.desktopManager.plasma6.enable = true;
    services.xserver.desktopManager.cinnamon.enable = true;

    # Enable networking
    networking.networkmanager.enable = true;

    services.printing.enable = true;
    services.seatd.enable = true;

    # Enable sound with pipewire.
    #sound.enable = true;
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        wireplumber.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        jack.enable = true;

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
    };

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.ki11errabbit = {
        isNormalUser = true;
        description = "Alec Davis";
        shell = pkgs.zsh;
        extraGroups = [ "networkmanager" "wheel" "libvirtd" "uinput" "input" "cdrom" "video" "docker" "dialout"];
        packages = with pkgs; [];
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;


    environment.systemPackages = with pkgs; [
        #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        #  wget
        neovim
        wget
        zsh
        rustup  
        wlopm  
        pamixer 
        git
        keepassxc
        eza
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
        btop
        universal-ctags
        mullvad-vpn
        gcc
        transmission_3
        usbutils
        gparted
        libnotify
        kmonad
        haskellPackages.kmonad
        gnumake
        glibc
        glibcInfo
        libcxx
        linux-manual
        man-pages
        openblas
        system76-keyboard-configurator
        cmake
        libtool
        xdotool
        nodejs
        wmctrl
        aria
        fd
        jq
        python311Packages.pandas
        python311Packages.requests
        python311Packages.sexpdata
        python311Packages.tld
        python311Packages.pyqt6 python311Packages.pyqt6-sip
        python311Packages.markdown
        gnum4
        pkg-config
        binutils
        dwl-custom
        libsecret
        slurp
        docker
        distrobox
        pcloudFixes
        wio
        libunwind
        polkit_gnome
    ];
    

    programs.zsh.enable = true;

    programs.neovim = {
        enable = true;
        defaultEditor = true;
    };
    
    programs.kdeconnect.enable = true;

    programs.river.enable = true;

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
        libressl
        openblas
        gfortran
        xorg.libX11
        libGLU
        alsa-lib
        xorg.libX11
        xorg.libXcursor
        xorg.libXext
        xorg.libXfixes
        xorg.libXi
        xorg.libXinerama
        xorg.libXrandr
        xorg.libXrender
        libglvnd
        libpulseaudio
        zlib
        wayland
        libunwind

    ];

    services.udev.extraRules = ''
        ACTION=="add", ATTRS{idVendor}=="2dc8", ATTRS{idProduct}=="3106", RUN+="/sbin/modprobe xpad", RUN+="${pkgs.stdenv.shell} -c 'echo 2dc8 3106 > /sys/bus/usb/drivers/xpad/new_id'"

        KERNEL=="input*", ATTRS{idVendor}=="17f6", ATTRS{idProduct}=="0822", RUN+="${pkgs.systemd}/bin/systemctl start --no-block unicomp-model-m.service"
    
        KERNEL=="input*", ATTRS{idVendor}=="04b3", ATTRS{idProduct}=="301e", RUN+="${pkgs.systemd}/bin/systemctl start --no-block ibm-thinkpad-travel.service"
    '';

    systemd.services.unicomp-model-m = {
        path = with pkgs; [
            haskellPackages.kmonad
        ];
        serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.kmonad}/bin/kmonad /root/.config/kmonad/unicomp-model-m.kbd";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
        };
      
    };
    systemd.services.ibm-thinkpad-travel = {
        path = with pkgs; [
            haskellPackages.kmonad
        ];
        serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.kmonad}/bin/kmonad /root/.config/kmonad/ibm-thinkpad-travel.kbd";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
        };
      
    };

    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        jetbrains-mono
        nerd-fonts.jetbrains-mono
    ];


    services.openssh.enable = true;
    services.dbus.enable = true;
    services.flatpak.enable = true;
    services.mullvad-vpn.enable = true;
    services.gnome.gnome-keyring.enable = true;
    xdg.portal.enable = true;
    #xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk];

    xdg.portal.wlr.enable = true;
    xdg.portal.wlr.settings = {
        screencast = {
            output_name = "HDMI-A-0";
            max_fps = 60;
            chooser_type = "simple";
            chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -ro";
        };
    };

    security.polkit.enable = true;
    systemd = {
        user.services.polkit-gnome-authentication-agent-1 = {
            description = "polkit-gnome-authentication-agent-1";
            wantedBy = [ "graphical-session.target" ];
            wants = [ "graphical-session.target" ];
            after = [ "graphical-session.target" ];
            serviceConfig = {
                Type = "simple";
                ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
                Restart = "on-failure";
                RestartSec = 1;
                TimeoutStopSec = 10;
            };
        };
    };
    
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 22 80 443 ];
        allowedTCPPortRanges = [ 
            { from = 1714; to = 1764; } # KDE Connect
        ];
        allowedUDPPortRanges = [ 
            { from = 1714; to = 1764; } # KDE Connect
        ];

    };
    services.mysql = {
        enable = true;
        package = pkgs.mariadb;
    };
    virtualisation.docker.enable = true;

    system.stateVersion = "25.05"; # Did you read the comment?

}
