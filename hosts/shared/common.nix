{ config, pkgs, ... }:

{
    nix.settings.experimental-features = "nix-command flakes";

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    
    time.timeZone = "America/Denver";

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

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma5.enable = true;

    # Enable networking
    networking.networkmanager.enable = true;

    services.printing.enable = true;

    # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
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
        extraGroups = [ "networkmanager" "wheel" "libvirtd" "uinput" "input" "cdrom" "video" ];
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
        transmission
        usbutils
        gparted
        libnotify
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
        python311Packages.pyqt6-webengine python311Packages.epc python311Packages.lxml # for eaf
        python311Packages.qrcode # eaf-file-browser
        python311Packages.pysocks # eaf-browser
        python311Packages.pymupdf # eaf-pdf-viewer
        python311Packages.pypinyin # eaf-file-manager
        python311Packages.psutil # eaf-system-monitor
        python311Packages.retry # eaf-markdown-previewer
        python311Packages.markdown
        gnum4
        pkg-config
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
            ExecStart = "${pkgs.haskellPackages.kmonad}/bin/kmonad /root/.config/kmonad/unicomp-model-m.kbd";
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
            ExecStart = "${pkgs.haskellPackages.kmonad}/bin/kmonad /root/.config/kmonad/ibm-thinkpad-travel.kbd";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
        };
      
    };

    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        jetbrains-mono
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];


    services.openssh.enable = true;
    services.dbus.enable = true;
    services.flatpak.enable = true;
    services.mullvad-vpn.enable = true;
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk];

    security.polkit.enable = true;
    systemd = {
        user.services.polkit-gnome-authentication-agent-1 = {
            description = "polkit-gnome-authentication-agent-1";
            # wantedBy = [ "graphical-session.target" ];
            # wants = [ "graphical-session.target" ];
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

    system.stateVersion = "24.05"; # Did you read the comment?

}
