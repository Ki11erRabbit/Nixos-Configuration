{ lib, inputs, config, pkgs, channels,  ... }:

{

    wayland.windowManager.sway = {
        enable = true;
        package = pkgs.swayfx;
        checkConfig = false;
        config = rec {
            modifier = "Mod4";
            terminal = "alacritty";
            keybindings = {
                "${modifier}+Return" = "exec ${terminal}";
            };
        };
        extraConfig = ''
        '';

    };
}
