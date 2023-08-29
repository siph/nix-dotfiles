{ pkgs, ... }:
{
  home.packages = with pkgs; [ gobang ];
}
