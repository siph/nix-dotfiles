{pkgs}:
pkgs.stdenv.mkDerivation rec {
  name = "startx-qtile";
  src = ../../../home-manager/applications/window-managers/qtile/xinit;
  buildInputs = with pkgs; [makeWrapper xorg.xinit];
  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/xinit
    cp ./xinitrc.sh $out/xinit/xinit_${name}
    makeWrapper ${pkgs.xorg.xinit}/bin/startx $out/bin/${name} \
     --add-flags $out/xinit/xinit_${name}
  '';
}
