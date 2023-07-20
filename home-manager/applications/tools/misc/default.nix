{ pkgs, ... }:
{
  # too lazy to deal with this
  home.packages = with pkgs; [
    bluetuith
    duf
    fd
    gh
    glow
    nixpkgs-review
    ouch
    ripgrep
    repgrep
    stig
    tldr
  ];
}

