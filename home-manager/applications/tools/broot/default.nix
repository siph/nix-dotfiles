{pkgs, ...}: {
  home.packages = with pkgs; [broot];
  xdg = {
    configFile = {
      "broot/conf.hjson".source = ./conf.hjson;
      "broot/dark-gruvbox.hjson".source = ./dark-gruvbox.hjson;
      "broot/verbs.hjson".source = ./verbs.hjson;
    };
  };
}
