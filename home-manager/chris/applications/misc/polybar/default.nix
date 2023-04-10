{ pkgs, ... }:
{
  home.packages = with pkgs; [ polybarFull ];
  xdg.configFile."polybar/config.ini".source = pkgs.substituteAll {
    name = "config.ini";
    src = ./config.ini;
    xmonad-log = "${pkgs.xmonad-log}";
  };
}
