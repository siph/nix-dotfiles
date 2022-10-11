{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/programs/bash
    ../../modules/programs/bat
    ../../modules/programs/bottom
    ../../modules/programs/firefox
    ../../modules/programs/kitty
    ../../modules/programs/lsd
    ../../modules/programs/starship
    ../../modules/programs/startx
    ../../modules/programs/tmux
    ../../modules/programs/zsh
  ];
  home = rec {
    username = "media";
    homeDirectory = "/home/${username}";
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
      choose
      duf
      fd
      glow
      httpie
      ncdu_2
      neofetch
      procs
      ripgrep
      xsel
      yt-dlp
    ];
  };

  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
}
