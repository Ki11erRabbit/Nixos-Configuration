{ config, pkgs, ... }:

{

    home.packages = with pkgs; [
        iterm2
        maccy
    ];
    
}

