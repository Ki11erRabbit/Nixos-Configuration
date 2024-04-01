{ config, pkgs, ... }:
{
    hardware.opentabledriver.enable = true;
    hardware.opentabletdriver.daemon.enable = true;
}

