{ pkgs, ... }:
{
  home.packages = with pkgs; [ broot ];
  xdg.configFile."broot/conf.hjson".source = ./conf.hjson;
  xdg.configFile."broot/dark-gruvbox.hjson".source = ./dark-gruvbox.hjson;
  xdg.configFile."broot/verbs.hjson".source = ./verbs.hjson;
}
