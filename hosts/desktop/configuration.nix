{ config, pkgs, ... }:

{

    networking.hostName = "nix-desktop"; # Define your hostname.

    networking = {
        nameservers = [ "192.168.254.12" "192.168.254.13" "192.168.0.121" ];
        };

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
}
