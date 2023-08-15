{ pkgs, ... }:
{
  imports = [
    ./hyprpaper
    ./waybar
    ./wofi
  ];
  home.packages = with pkgs; [ wofi grim slurp start-hyprland ];
  xdg.configFile."hypr/hyprland.conf".source = pkgs.substituteAll {
    name = "hyprland.conf";
    src = ./hyprland.conf;
    kdeconnect = "${pkgs.kdeconnect}";
  };
}

