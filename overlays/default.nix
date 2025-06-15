# This file defines overlays
{inputs, ...}: {
    # This one brings our custom packages from the 'pkgs' directory
    #additions = final: _prev: import ../pkgs;

    # This one contains whatever you want to overlay
    # You can change versions, add patches, set compilation flags, anything really.
    # https://nixos.wiki/wiki/Overlays
    modifications = final: prev: {
        # example = prev.example.overrideAttrs (oldAttrs: rec {
        # ...
        # });
        catppuccin-qt5ct = prev.catppuccin-qt5ct.overrideAttrs (oldAttrs: rec {
            version = "2025-06-15";
            src = prev.fetchFromGitHub {
                owner = "catppuccin";
                repo = "qt5ct";
                rev = "cb585307edebccf74b8ae8f66ea14f21e6666535";
                hash = "sha256-wDj6kQ2LQyMuEvTQP6NifYFdsDLT+fMCe3Fxr8S783w=";
            };
            installPhase = ''
                runHook preInstall
                mkdir -p $out/share/qt6ct
                cp -r themes $out/share/qt6ct/colors
                mkdir -p $out/share/qt5ct
                cp -r themes $out/share/qt5ct/colors
                runHook postInstall
            '';
        });
    };

}
