{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
#    systemd = {
#      enable = true;
#    };
  };
  xdg.configFile = {
    "waybar/style.css" = {
      enable = true;
      source = ./style.css;
    };
  };
  xdg.configFile = {
    "waybar/config" = {
      enable = true;
      source = ./config;
    };
  };
}

