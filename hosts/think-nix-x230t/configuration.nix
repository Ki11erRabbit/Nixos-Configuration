{ config, pkgs, ... }:
{
    hardware.opentabletdriver.enable = true;
    hardware.opentabletdriver.daemon.enable = true;
    services.fprintd = {
        enable = true;
    };

    environment.systemPackages = with pkgs; [
        fprintd
    ];

    security.pam.services.sddm.text = ''
        auth    [success=1 new_authtok_reqd=1 default=ignore] pam_unix.so try_first_pass likeauth nullok
        auth    sufficient  pam_fprintd.so
    '';
}

