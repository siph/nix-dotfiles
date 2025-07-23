{pkgs, ...}: {
  home.packages = with pkgs; [carapace];
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
    extraConfig = with pkgs;
    with builtins; let
      gitv2 = writeTextFile {
        name = "gitv2.nu";
        text =
          replaceStrings ["use argx"] ["use ${nu_scripts}/share/nu_scripts/modules/argx/mod.nu"]
          (readFile "${nu_scripts}/share/nu_scripts/modules/gitv2/mod.nu");
      };
    in ''
      source ${nu_scripts}/share/nu_scripts/modules/nix/nix.nu
      source ${gitv2}
    '';
  };
}
