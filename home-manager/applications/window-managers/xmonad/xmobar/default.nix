{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [ xmobar ];
  };
  xdg.configFile."xmobar/._xmobarrc".source = ./xmobarrc;
  xdg.configFile."xmobar/.xmobarrc".text = "";
}
