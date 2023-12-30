{pkgs, ...}: {
  imports = [
    ../applications/editors/neovim
    ../applications/shells
    ../applications/tools/bat
    ../applications/tools/git
    ../applications/tools/tmux
    ../applications/tools/bottom
    ../applications/tools/neofetch
    ../applications/tools/starship
  ];

  home = rec {
    username = "chris";
    homeDirectory = "/home/${username}";
    stateVersion = "23.05";
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
    ];
  };

  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
