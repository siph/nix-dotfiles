{
  pkgs,
  makeBinaryWrapper,
  ...
}:
pkgs.stdenv.mkDerivation rec {
  name = "kdeconnectd";
  src = ./.;
  buildInputs = [makeBinaryWrapper];
  installPhase = ''
    mkdir -p $out/bin
    makeBinaryWrapper ${pkgs.kdePackages.kdeconnect-kde}/libexec/${name} $out/bin/${name}
  '';
}
