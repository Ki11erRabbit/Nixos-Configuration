{ lib, inputs, config, pkgs, channels,  ... }:
{

    xdg.mimeApps = {
        enable = true;
        associations.added = {
            "application/x-extension-html" = [ "firefox.desktop" ];
            "application/x-extension-htm" = [ "firefox.desktop" ];
            "application/x-extension-xhtml" = [ "firefox.desktop" ];
            "application/x-extension-shtml" = [ "firefox.desktop" ];
            "application/x-extension-xht" = [ "firefox.desktop" ];
            "application/xhtml+xml" = [ "firefox.desktop" ];
            "text/html" = [ "firefox.desktop" ];
            "x-scheme-handler/about" = [ "firefox.desktop" ];
            "x-scheme-handler/attachment" = [ "firefox.desktop" ];
            "x-scheme-handler/chrome" = [ "firefox.desktop" ];
            "x-scheme-handler/http" = [ "firefox.desktop" ];
            "x-scheme-handler/https" = [ "firefox.desktop" ];
        };
        defaultApplications = {
            "application/x-extension-html" = [ "firefox.desktop" ];
            "application/x-extension-htm" = [ "firefox.desktop" ];
            "application/x-extension-xhtml" = [ "firefox.desktop" ];
            "application/x-extension-shtml" = [ "firefox.desktop" ];
            "application/x-extension-xht" = [ "firefox.desktop" ];
            "application/xhtml+xml" = [ "firefox.desktop" ];
            "text/html" = [ "firefox.desktop" ];
            "x-scheme-handler/about" = [ "firefox.desktop" ];
            "x-scheme-handler/attachment" = [ "firefox.desktop" ];
            "x-scheme-handler/chrome" = [ "firefox.desktop" ];
            "x-scheme-handler/http" = [ "firefox.desktop" ];
            "x-scheme-handler/https" = [ "firefox.desktop" ];

        };
    };
}
