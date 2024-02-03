{pkgs, ...}: {
  # too lazy to deal with this
  home.packages = with pkgs; [
    bluetuith
    duf
    gh
    glow
    ouch
    repgrep
  ];
}
