{ lib, pkgs, ... }:
{
  imports = [
    ./hyprpaper
    ./start-hyprland.nix
    ./waybar
    ./wofi
  ];
  home.packages = with pkgs; [ wofi ];
  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  home = {
    file = {
      ".local/bin/start-hyprland" = {
        enable = true;
        executable = true;
        text = ''
          #!/usr/bin/env bash
          cd ~
          export HYPRLAND_LOG_WLR=1
          export _JAVA_AWT_WM_NONREPARENTING=1
          exec Hyprland
        '';
      };
    };
  };
}

