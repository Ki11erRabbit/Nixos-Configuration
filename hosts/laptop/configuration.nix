{ config, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        wdisplays
        dmidecode
    ];

    programs.light.enable = true;
    
    services.thermald.enable = true;
    services.power-profiles-daemon.enable = false;
    services.tlp.enable = true;
    security.sudo = {
        enable = true;
        extraRules = [{
            commands = [{
                command = "${pkgs.dmidecode}/bin/dmidecode";
                options = [ "NOPASSWD" ];
                }
                {
                command = "/run/current-system/sw/bin/dmidecode";
                options = [ "NOPASSWD" ];
                }];
            groups = [ "wheel" ];
        }];
    };
}
