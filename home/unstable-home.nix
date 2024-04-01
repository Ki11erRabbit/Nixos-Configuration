
{ config, pkgs, channels, unstable,  ... }:

{

    home.packages = with pkgs; [
        koka
    ];
}
