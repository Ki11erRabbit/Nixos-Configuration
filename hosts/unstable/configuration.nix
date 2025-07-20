{ config, unstable, ... }:

{
    programs.maomaowm = {
        enable = true;
    }; 
    
    environment.systemPackages = with unstable; [
    ];

}
