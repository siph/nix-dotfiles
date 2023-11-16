{ pkgs, ... }:
{
  home.packages = with pkgs; [ systemctl-tui ];
}
