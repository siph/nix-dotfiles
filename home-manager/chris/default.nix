{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./applications
  ];

  home = rec {
    username = "chris";
    homeDirectory = "/home/${username}";
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
      ardour
      ark
      bluetuith
      broot
      cargo
      choose
      doctl
      duf
      fd
      ffmpeg
      gh
      glow
      hoard
      httpie
      jetbrains.idea-ultimate
      jq
      kubectl
      minikube
      mpv
      ncdu_2
      neofetch
      neovim
      nixpkgs-review
      ouch
      procs
      ripgrep
      rustc
      steam
      tdesktop
      tixati
      tldr
      unzip
      vlc
      xsel
      yt-dlp
    ];
  };

  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.05";
}
