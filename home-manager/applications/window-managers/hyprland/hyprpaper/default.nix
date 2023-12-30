{pkgs, ...}: {
  home.packages = with pkgs; [hyprpaper];
  xdg.configFile = {
    "hypr/hyprpaper.conf" = {
      enable = true;
      source = ./hyprpaper.conf;
    };
  };
}
