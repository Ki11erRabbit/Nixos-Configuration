{ config, pkgs, ... }:

{

    networking.hostName = "nix-desktop"; # Define your hostname.

    # Configure keymap in X11
    services.xserver = {
        layout = "us";
        xkbVariant = "";
    };
    
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
    };
}
