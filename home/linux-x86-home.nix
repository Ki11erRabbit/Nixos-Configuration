{ lib, inputs, config, pkgs, channels,  ... }:

{
    home.packages = with pkgs; [
        discord
        slack
    ];

    wayland.windowManager.sway = {
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
