{ config, unstable, ... }:

{
    programs.mango = {
        enable = true;
    }; 
    
    environment.systemPackages = with unstable; [
    ];

}
