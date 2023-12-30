{pkgs, ...}: {
  home.packages = with pkgs; [
    polybarFull
    bar-clock
    bar-weather
    bar-gh-inbox
    wt-fetch
    xmonad-log
  ];

  xdg.configFile."polybar/config.ini".source = ./config.ini;
}
