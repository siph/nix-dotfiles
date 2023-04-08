{ pkgs, ... }:
{
  imports = [
    ./xmobar
  ];
  xsession = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = pkgs.substituteAll {
        name = "xmonad.hs";
        src = ./xmonad.hs;
        kdeconnect = "${pkgs.kdeconnect}";
      };
    };
  };
}

