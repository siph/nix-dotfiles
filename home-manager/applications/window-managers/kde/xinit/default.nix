{ pkgs, ... }:
{
  home.packages = with pkgs; [ startx-kde ];
}
