{ lib, config, pkgs, ... }:

{

    home.homeDirectory = "/Users/ki11errabbit";
    home.packages = with pkgs; [
        iterm2
        coqPackages.vscoq-language-server
    ];
    
    home.activation.makeTrampolineApps = lib.hm.dag.entryAfter [ "writeBoundary" ] (
        builtins.readFile ./make-app-trampolines.sh
    );

    programs.zsh = {
        sessionVariables = {
        };

    };
}

