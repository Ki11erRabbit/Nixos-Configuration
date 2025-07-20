{ config, pkgs, unstable, ... }:

{
    programs.maomaowm = {
        enable = true;
    }; 
    
    environment.systemPackages = with pkgs; [
    ];

}
