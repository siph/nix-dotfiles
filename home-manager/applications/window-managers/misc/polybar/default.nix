{ pkgs, ... }:
{
  home.packages = with pkgs; [
    polybarFull
    bar-clock
    bar-weather
    bar-gh-inbox
    xmonad-log
  ];

  xdg.configFile."polybar/config.ini".source = ./config.ini;
}
