{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [ xmobar ];
  };
  xdg.configFile."xmobar/.xmobarrc".source = ./xmobarrc;
}
