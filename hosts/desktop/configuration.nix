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
    
    environment.systemPackages = with pkgs; [
        virt-manager
    ];
}
