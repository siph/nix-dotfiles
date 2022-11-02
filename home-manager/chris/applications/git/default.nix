{ lib, pkgs, ... }:
{
  programs.git = {
      enable = true;
      userName = "siph";
      userEmail = "dawkins.chris.dev@gmail.com";
      delta = {
        enable = true;
      };
      lfs.enable = true;
  };
}
