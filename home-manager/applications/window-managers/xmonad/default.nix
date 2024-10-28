{pkgs, ...}: {
  imports = [
    ./xinit
    ./xmobar
  ];
  home.packages = with pkgs; [
    feh
    lxsession
    picom
  ];
  xsession = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hp: [
        hp.dbus
        hp.monad-logger
        hp.xmonad-contrib
      ];
      config = pkgs.substituteAll {
        name = "xmonad.hs";
        src = ./xmonad.hs;
        kdeconnect = "${pkgs.kdePackages.kdeconnect-kde}";
      };
    };
  };
}
