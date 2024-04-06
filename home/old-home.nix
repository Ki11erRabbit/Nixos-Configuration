{ config, pkgs, oldpkgs,  ... }:

{
    home.packages = with pkgs; [
        oldpkgs.pcloud

    ];
}
