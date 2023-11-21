{ pkgs, ... }:
{
  home.packages = with pkgs; [ carapace ];
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
    shellAliases = {
      ll = "ls";
      lt = "lsd --tree";
      cat = "bat";
      tree = "broot";
      vim = "nvim";
    };
    extraConfig = ''
      source ${pkgs.nu_scripts}/share/nu_scripts/modules/nix/nix.nu
      source ${pkgs.nu_scripts}/share/nu_scripts/modules/git/git-v2.nu
      source ${pkgs.nu_scripts}/share/nu_scripts/modules/kubernetes/kubernetes.nu
    '';
  };
}
