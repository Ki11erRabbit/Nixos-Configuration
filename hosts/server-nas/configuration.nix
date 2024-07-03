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
    
    
    services.nginx = {
        enable = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
        virtualHosts."pterodactyl.killerrabbit.xyz" = {
            forceSSL = true;
            serverName = "pterodactyl.killerrabbit.xyz";
            sslCertificate = "/etc/letsencrypt/live/pterodactyl.killerrabbit.xyz/fullchain.pem";
            sslCertificateKey = "/etc/letsencrypt/live/pterodactyl.killerrabbit.xyz/privkey.pem";
            extraConfig = ''
                access_log /var/log/nginx/pterodactyl.app-access.log;
                error_log  /var/log/nginx/pterodactyl.app-error.log error;
                
                client_max_body_size 100m;
                client_body_timeout 120s;

                sendfile off;
            '';
            locations."/" = {
                proxyPass = "https://172.0.0.1:443";
                extraConfig = ''
                    client_max_body_size 50m;

                    proxy_set_header X-Real-IP $remote_addr;
                    proxy_set_header Host $host;
                    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                    proxy_set_header X-Forwarded-Proto $scheme;
                    proxy_redirect off;
                    proxy_buffering off;
                '';
            };
        };
        virtualHosts."jellyfin.killerrabbit.xyz" = {
            forceSSL = true;
            serverName = "jellyfin.killerrabbit.xyz";
            sslCertificate = "/etc/letsencrypt/live/jellyfin.killerrabbit.xyz/fullchain.pem";
            sslCertificateKey = "/etc/letsencrypt/live/jellyfin.killerrabbit.xyz/privkey.pem";
            extraConfig = ''
                client_max_body_size 20m;
                set $jellyfin jellyfin;
                resolver 192.168.254.12 valid=30s;

                #include /etc/letsencrypt/options-ssl-nginx.conf;
                #ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
                add_header Strict-Transport-Security "max-age=31536000" always;
                ssl_stapling on;
                ssl_stapling_verify on;

                # Security / XSS Mitigation Headers
                # NOTE: X-Frame-Options may cause issues with the webOS app
                add_header X-Frame-Options "SAMEORIGIN";
                add_header X-Content-Type-Options "nosniff";

                # COOP/COEP. Disable if you use external plugins/images/assets
                add_header Cross-Origin-Opener-Policy "same-origin" always;
                add_header Cross-Origin-Embedder-Policy "require-corp" always;
                add_header Cross-Origin-Resource-Policy "same-origin" always;

                # Permissions policy. May cause issues on some clients
                add_header Permissions-Policy "accelerometer=(), ambient-light-sensor=(), battery=(), bluetooth=(), camera=(), clipboard-read=(), display-capture=(), document-domain=(), encrypted-media=(), gamepad=(), geolocation=(), gyroscope=(), hid=(), idle-detection=(), interest-cohort=(), keyboard-map=(), local-fonts=(), magnetometer=(), microphone=(), payment=(), publickey-credentials-get=(), serial=(), sync-xhr=(), usb=(), xr-spatial-tracking=()" always;


                # Content Security Policy
                # See: https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP
                # Enforces https content and restricts JS/CSS to origin
                # External Javascript (such as cast_sender.js for Chromecast) must be whitelisted.
                # NOTE: The default CSP headers may cause issues with the webOS app
                #add_header Content-Security-Policy "default-src https: data: blob: http://image.tmdb.org; style-src 'self' 'unsafe-inline'; script-src 'self' 'unsafe-inline' https://www.gstatic.com https://www.youtube.com blob:; worker-src 'self' blob:; connect-src 'self'; object-src 'none'; frame-ancestors 'self'";
                
            '';
            locations."/" = {
                proxyPass = "https://127.0.0.1:8096";
                extraConfig = ''
                    #client_body_timeout 120s;

                    #proxy_set_header X-Real-IP $remote_addr;
                    #proxy_set_header Host $host;
                    #proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                    #proxy_set_header X-Forwarded-Proto $scheme;
                    #proxy_redirect off;
                    #proxy_buffering off;
                '';
            };
            locations."/socket" = {
                proxyPass = "http://127.0.0.1:8096";
                extraConfig = ''
                    proxy_http_version 1.1;
                    proxy_set_header Upgrade $http_upgrade;
                    proxy_set_header Connection "upgrade";
                    proxy_set_header Host $host;
                    proxy_set_header X-Real-IP $remote_addr;
                    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                    proxy_set_header X-Forwarded-Proto $scheme;
                    proxy_set_header X-Forwarded-Protocol $scheme;
                    proxy_set_header X-Forwarded-Host $http_host;
                '';
            };

        };
    };
}
