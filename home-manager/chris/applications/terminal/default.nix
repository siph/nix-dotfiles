{ lib, pkgs, ... }:
{
  imports = [
    ./bat
    ./bottom
    ./broot
    ./lsd
    ./neofetch
    ./starship
    ./tmux
  ];
}
