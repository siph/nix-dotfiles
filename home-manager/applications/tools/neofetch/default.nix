{pkgs, ...}: {
  home.packages = with pkgs; [neofetch];
  xdg.configFile = {
    "neofetch/config.conf" = {
      enable = true;
      source = ./config.conf;
    };
  };
}
