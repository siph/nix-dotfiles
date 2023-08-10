{ pkgs, ... }:
{
  home.packages = with pkgs; [ polybarFull ];

  xdg.configFile."polybar/config.ini".text =
    let

      clock-script = pkgs.writeTextFile {
        name = "clock-script";
        text = builtins.readFile ./clock.nu;
        executable = true;
        destination = "/bin/clock-script";
      };

      weather-script = pkgs.writeTextFile {
        name = "weather-script";
        text = builtins.readFile ./weather.nu;
        executable = true;
        destination = "/bin/weather-script";
      };

      gh-inbox = pkgs.stdenv.mkDerivation rec {
        name = "gh-inbox";
        src = ./.;
        buildInputs = with pkgs; [ gh makeBinaryWrapper nushell ];
        installPhase = ''
          mkdir -p $out/nushell
          mkdir -p $out/bin

          cp ./gh-inbox.nu $out/nushell

          makeBinaryWrapper ${pkgs.nushell}/bin/nu $out/bin/${name} \
            --add-flags $out/nushell/${name}.nu
        '';
      };

    in
    builtins.replaceStrings
      [
        "@xmonad-log@"
        "@clock-script@"
        "@weather-script@"
        "@gh-inbox@"
      ]
      [
        "${pkgs.xmonad-log}"
        "${clock-script}"
        "${weather-script}"
        "${gh-inbox}"
      ]
      (builtins.readFile ./config.ini);
  xdg.configFile."polybar/_config.ini".source = pkgs.substituteAll {
    name = "config.ini";
    src = ./config.ini;
    xmonad-log = "${pkgs.xmonad-log}";
    clock-script = "${./clock.nu}";
    weather-script = "${./weather.nu}";
    nushell = "${pkgs.nushell}";
  };
}
