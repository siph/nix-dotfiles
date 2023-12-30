{pkgs}:
pkgs.stdenv.mkDerivation rec {
  name = "start-hyprland";
  src = ../../../home-manager/applications/window-managers/hyprland;
  buildInputs = with pkgs; [makeWrapper];
  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/script
    cp ./start-hyprland.sh $out/script/${name}
    makeWrapper ${pkgs.bash}/bin/bash $out/bin/${name} \
     --add-flags $out/script/${name}
  '';
}
