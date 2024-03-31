{ config, pkgs, ... }:

{
    
    services.udev.extraRules = ''
        ACTION=="add", ATTRS{idVendor}=="2dc8", ATTRS{idProduct}=="3106", RUN+="/sbin/modprobe xpad", RUN+="${pkgs.stdenv.shell} -c 'echo 2dc8 3106 > /sys/bus/usb/drivers/xpad/new_id'"

        KERNEL=="input*", ATTRS{idVendor}=="17f6", ATTRS{idProduct}=="0822", RUN+="${pkgs.systemd}/bin/systemctl start --no-block unicomp-model-m.service"
    
        KERNEL=="input*", ATTRS{idVendor}=="04b3", ATTRS{idProduct}=="301e", RUN+="${pkgs.systemd}/bin/systemctl start --no-block ibm-thinkpad-travel.service"
    '';

    systemd.services.unicomp-model-m = {
        path = with pkgs; [
            haskellPackages.kmonad
        ];
        serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.haskellPackages.kmonad}/bin/kmonad /root/.config/kmonad/unicomp-model-m.kbd";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
        };
      
    };
    systemd.services.ibm-thinkpad-travel = {
        path = with pkgs; [
            haskellPackages.kmonad
        ];
        serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.haskellPackages.kmonad}/bin/kmonad /root/.config/kmonad/ibm-thinkpad-travel.kbd";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
        };
      
    };

    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        jetbrains-mono
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
    system.stateVersion = "23.11"; # Did you read the comment?

    system.autoUpgrade.enable  = true;
}
