{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [ carapace ];
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
    extraConfig = ''
      source ${inputs.nu-scripts}/modules/git/git-v2.nu
      source ${inputs.nu-scripts}/modules/kubernetes/kubernetes.nu
    '';
  };
}
