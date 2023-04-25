{ pkgs, ... }:
{
  home.packages = with pkgs; [ polybarFull ];

  xdg.configFile."polybar/config.ini".text = let

    clock-script = pkgs.writeTextFile {
      name = "clock-script";
      text = builtins.readFile ./clock.nu;
      executable = true;
      destination = /bin/clock-script;
    };

    weather-script = pkgs.writeTextFile {
      name = "weather-script";
      text = builtins.readFile ./weather.nu;
      executable = true;
      destination = /bin/weather-script;
    };

  in (builtins.replaceStrings
    [ "@xmonad-log@" "@clock-script@" "@weather-script@" ]
    [ "${pkgs.xmonad-log}" "${clock-script}" "${weather-script}" ]
    (builtins.readFile ./config.ini)
  );
  xdg.configFile."polybar/_config.ini".source = pkgs.substituteAll {
    name = "config.ini";
    src = ./config.ini;
    xmonad-log = "${pkgs.xmonad-log}";
    clock-script = "${./clock.nu}";
    weather-script = "${./weather.nu}";
    nushell = "${pkgs.nushell}";
  };
}
