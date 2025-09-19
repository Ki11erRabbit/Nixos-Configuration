{ config, pkgs, ... }:

{

    home.homeDirectory = "/home/ki11errabbit";
    home.packages = with pkgs; [
        iterm2
        coqPackages.vscoq-language-server
    ];
    
    programs.zsh = {
        sessionVariables = {
        };

    };
}

