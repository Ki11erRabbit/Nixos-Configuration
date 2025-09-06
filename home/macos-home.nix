{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        iterm2
        coqPackages.vscoq-language-server
    ];
    
}

