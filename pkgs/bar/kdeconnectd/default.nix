{
  pkgs,
  makeBinaryWrapper,
  ...
}:
pkgs.stdenv.mkDerivation rec {
  name = "kdeconnectd";
  src = ./.;
  buildInputs = with pkgs; [kdeconnect makeBinaryWrapper];
  installPhase = ''
    mkdir -p $out/bin
    makeBinaryWrapper ${pkgs.kdeconnect}/libexec/${name} $out/bin/${name}
  '';
}
