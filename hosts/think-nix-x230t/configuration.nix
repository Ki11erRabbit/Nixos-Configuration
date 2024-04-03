{ config, pkgs, ... }:
{
    hardware.opentabletdriver.enable = true;
    hardware.opentabletdriver.daemon.enable = true;
    
    services.xserver.desktopManager.plasma5.enable = true;
}

