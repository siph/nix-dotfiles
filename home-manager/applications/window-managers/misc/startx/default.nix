{ pkgs, ... }:
{
  home.packages = with pkgs; [
    feh
    lxsession
    picom
  ];
  home.file = {
    ".xinitrc" = {
      source = ./xinitrc.sh;
      executable = true;
    };
  };
}
