{ lib, pkgs, ... }:
{
  imports = [
    ./hyprpaper
    ./wofi
  ];
  home.packages = with pkgs; [ wofi ];
  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  home.file = {
    ".local/bin/start-hyprland" = {
      enable = true;
      executable = true;
      source = ./start-hyprland;
    };
  };
}

