
{ config, pkgs, channels, unstable,  ... }:

{
    home.packages = with pkgs; [
        unstable.koka
        unstable.atlauncher
    ];
}
