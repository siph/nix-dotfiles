{ pkgs, ... }: {
  home.packages = with pkgs; [
    neovim # Use custom neovim build from overlay.
    wl-clipboard
    xsel
  ];

}
