{ config, pkgs, pterodactyl, wings, ... }:
let self = rec {
};
in
{

    networking.hostName = "server-nas"; # Define your hostname.

    # Configure keymap in X11
    services.xserver = {
        xkb.layout = "us";
        xkb.variant = "";
    };
    
    environment.systemPackages = with pkgs; [
        
        certbot-full
    	docker
        jellyfin
        jellyfin-web
        jellyfin-ffmpeg
    ];
    
    services.jellyfin = {
        enable = true;
        openFirewall = true;
    };
    services.mysql = {
        enable = true;
        package = pkgs.mariadb;
    };
    
    virtualisation.docker.enable = true;
    users.extraGroups.docker.members = [ "ki11errabbit" ];
    
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 22 80 443];
    };
    
    services.openssh = {
        settings.X11Forwarding = true;
    };
    
    services.nginx = {
        enable = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
        virtualHosts."pterodactyl.killerrabbit.xyz" = {
            locations."/" = {
                proxyPass = "https://127.0.0.1";
            };
        };
        virtualHosts."jellyfin.killerrabbit.xyz" = {
            locations."/" = {
                proxyPass = "http://127.0.0.1:8096";
                proxyWebsockets = true;
            };
        };
    };
}
