{ pkgs, ... }: {
  home.packages = with pkgs; [
    neovim # Use custom neovim build from overlay.
    ripgrep
    fd
    wl-clipboard
    xsel
  ];

}
