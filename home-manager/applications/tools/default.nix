{ pkgs, ... }:
{
  imports = [
    ./bat
    ./bottom
    ./broot
    ./git
    ./lsd
    ./neofetch
    ./nix-stuff
    ./starship
    ./tmux
    ./yt-dlp
  ];
  home.packages = with pkgs; [
    bluetuith
    duf
    fd
    gh
    glow
    nixpkgs-review
    ouch
    ripgrep
    stig
    tldr
  ];
}
