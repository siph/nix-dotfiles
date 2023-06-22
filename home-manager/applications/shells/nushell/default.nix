{ pkgs, ... }:
{
  home.packages = with pkgs; [ carapace ];
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
  };
}
