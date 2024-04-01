{ config, pkgs, ... }:

{
    home.file = {
        ".config/kmonad/ibm-thinkpad-travel.kbd" = {
            text = import ./ibm-thinkpad-travel.kbd;
        };
        ".config/kmonad/unicomp-model-m.kbd" = {
            text = import ./unicomp-model-m.kbd;
        };
}
