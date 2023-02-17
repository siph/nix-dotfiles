{ lib, pkgs, ... }:
{
  imports = [
    ./hyprpaper
    ./waybar
    ./wofi
  ];
  home.packages = with pkgs; [ wofi wl-clipboard ];
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
          export XDG_CURRENT_DESKTOP=Hyprland
          export XDG_SESSION_TYPE=wayland
          export XDG_SESSION_DESKTOP=Hyprland
          export XDG_CONFIG_HOME=/home/chris/.config
          export _JAVA_AWT_WM_NONREPARENTING=1
          exec systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP &
          exec dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &
          exec systemctl --user start xdg-desktop-portal-hyprland &
          exec Hyprland
        '';
      };
    };
  };
}

