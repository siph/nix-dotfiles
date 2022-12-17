{ pkgs, ... }:
{
  imports = [
    ./steam.nix
    ./steamtinkterlaunch.nix
  ];
}
