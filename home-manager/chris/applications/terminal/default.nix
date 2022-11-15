{ lib, pkgs, ... }:
{
  imports = [
    ./bat
    ./bottom
    ./broot
    ./lsd
    ./starship
    ./tmux
  ];
}
