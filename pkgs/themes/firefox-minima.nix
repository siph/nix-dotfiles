{
  pkgs,
  ff-minima,
}:
pkgs.stdenvNoCC.mkDerivation {
  name = "firefox-minima";

  src = ff-minima;

  installPhase = ''
    mkdir -p $out/share/firefox-minima/
    mv * $out/share/firefox-minima/
  '';
}
