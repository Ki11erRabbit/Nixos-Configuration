{ config, pkgs, ... }:
{
    services.desktopManager.cosmic.enable = true;
    
    services.udev.extraRules = ''
        # for kmonad to work
        KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '';
    security.sudo = {
        enable = true;
        extraRules = [{
            commands = [{
                command = "${pkgs.haskellPackages.kmonad}/bin/kmonad";
                options = [ "NOPASSWD" ];
                }
                {
                command = "/run/current-system/sw/bin/kmonad";
                options = [ "NOPASSWD" ];
                }
                {
                command = "${pkgs.procps}/bin/pkill kmonad";
                options = [ "NOPASSWD" ];
                }
                {
                command = "/run/current-system/sw/bin/pkill /run/current-system/sw/bin/kmonad";
                options = [ "NOPASSWD" ];
                }
                {
                command = "${pkgs.procps}/bin/pkill ${pkgs.haskellPackages.kmonad}/bin/kmonad";
                options = [ "NOPASSWD" ];
                }
                ];
            groups = [ "wheel" ];
        }];
    };
}

