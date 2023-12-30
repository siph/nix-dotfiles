{pkgs, ...}:
pkgs.stdenvNoCC.mkDerivation rec {
  name = "bar-weather";
  src = ./.;
  buildInputs = with pkgs; [nushell makeBinaryWrapper];
  installPhase = ''
    mkdir -p $out/nushell
    mkdir -p $out/bin

    cp ./weather.nu $out/nushell/${name}.nu

    makeBinaryWrapper ${pkgs.nushell}/bin/nu $out/bin/${name} \
      --add-flags $out/nushell/${name}.nu
  '';
}
