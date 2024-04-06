{ config, pkgs, ... }:

pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
        libressl
    ];
}
    
