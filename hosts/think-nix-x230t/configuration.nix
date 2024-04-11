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

    /*security.pam.services.sudo.text = ''
        account required pam_unix.so

        auth sufficient pam_unix.so likeauth try_first_pass nullok
        auth sufficient ${fprintd-clients}/lib/security/pam_fprintd.so
        auth required pam_deny.so

        password sufficient pam_unix.so nullok sha512
        
        session required pam_env.so conffile=/etc/pam/environment readenv=0
        session required pam_unix.so
    '';*/
}

