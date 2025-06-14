{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation {
  pname = "catppuccin-qt6ct";
  version = "2025-07-14";

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "qt5ct";
    rev = "cb585307edebccf74b8ae8f66ea14f21e6666535";
    #hash = "sha256-t/uyK0X7qt6qxrScmkTU2TvcVJH97hSQuF0yyvSO/qQ=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/qt5ct
    cp -r themes $out/share/qt6ct/colors
    runHook postInstall
  '';

  meta = with lib; {
    description = "Soothing pastel theme for qt6ct";
    homepage = "https://github.com/catppuccin/qt5ct";
    license = licenses.mit;
    maintainers = with maintainers; [ pluiedev ];
    platforms = platforms.all;
  };
}
