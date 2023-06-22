{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
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
  xdg.configFile = {
    "waybar/get_weather.sh" = {
      enable = true;
      executable = true;
      source = ./get_weather.sh;
    };
  };
}

