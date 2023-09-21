{ pkgs, inputs, ... }:
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
      cp = "ucp";
    };
    extraConfig = ''
      source ${inputs.nu-scripts}/modules/nix/nix.nu
      source ${inputs.nu-scripts}/modules/git/git-v2.nu
      source ${inputs.nu-scripts}/modules/kubernetes/kubernetes.nu
    '';
  };
}
