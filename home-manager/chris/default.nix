{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./applications/games
    ./applications/misc
    ./applications/shells
    ./applications/terminal
  ];

  home = rec {
    username = "chris";
    homeDirectory = "/home/${username}";
    sessionPath = [ "/home/${username}/.local/bin" ];
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
      ardour
      ark
      bluetuith
      choose
      du-dust
      duf
      fd
      ffmpeg
      gh
      glow
      grex
      httpie
      jetbrains.idea-community
      jq
      ncdu_2
      neovim
      nixpkgs-review
      ouch
      procs
      ripgrep
      stig
      tldr
      unzip
      vlc
      xsel
    ];
  };

  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.05";
}
