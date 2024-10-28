{pkgs, ...}: {
  imports = [./xinit];

  home.packages = with pkgs; [
    bar-weather
    bar-clock
    bar-gh-inbox
    kdePackages.kdeconnect-kde
  ];

  xdg.configFile = {
    "qtile" = {
      recursive = true;
      source = ./src;
    };
    "qtile/autostart.sh" = {
      enable = true;
      executable = true;
      source = ./autostart.sh;
    };
  };
}
