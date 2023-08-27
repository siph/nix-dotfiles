{ pkgs, ... }:
pkgs.stdenv.mkDerivation rec {
  name = "bar-gh-inbox";
  src = ./.;
  buildInputs = with pkgs; [ gh makeBinaryWrapper nushell ];
  installPhase = ''
    mkdir -p $out/nushell
    mkdir -p $out/bin

    cp ./gh-inbox.nu $out/nushell/${name}.nu

    makeBinaryWrapper ${pkgs.nushell}/bin/nu $out/bin/${name} \
      --add-flags $out/nushell/${name}.nu
  '';
}

