{ pkgs, ... }:
{
  home.packages = with pkgs; [ nixpkgs-review nix-init ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
