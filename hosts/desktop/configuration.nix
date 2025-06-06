{ config, pkgs, ... }:

{

    networking.hostName = "nix-desktop"; # Define your hostname.

    # Configure keymap in X11
    services.xserver = {
        xkb.layout = "us";
        xkb.variant = "";
    };
    
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
    };
    
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    
    environment.systemPackages = with pkgs; [
        qemu
        nasm
        grub2
        xorriso
        corectrl
    ];

    programs.corectrl = {
        enable = true;
    };

    services.blueman.enable = true;

    hardware.steam-hardware.enable = true;

    services.ollama = {
        enable = true;
        acceleration = "rocm";
    };

    services.postgresql = {
        enable = true;
        ensureDatabases = [ "mydatabase" ];
        authentication = pkgs.lib.mkOverride 10 ''
        #type database  DBuser  auth-method
        local all       all     trust
        '';
    };
}
