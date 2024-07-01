{ config, pkgs, pterodactyl, wings, ... }:

{

    networking.hostName = "server-nas"; # Define your hostname.

    # Configure keymap in X11
    services.xserver = {
        xkb.layout = "us";
        xkb.variant = "";
    };
    
    environment.systemPackages = with pkgs; [
        pterodactyl.pterodactyl
        ptetodactyl.panel
        wings.wings
        jellyfin
        jellyfin-web
        jellyfin-ffmpeg
    ];
    
    services.jellyfin = {
        enable = true;
        openFirewall = true;
        }
    
}
