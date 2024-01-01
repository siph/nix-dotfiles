{pkgs, ...}: let
  wrapped-ardour = pkgs.callPackage ./ardour.nix {
    inherit (import ./plugins.nix {inherit pkgs;}) plugins;
  };
in {
  home.packages = [wrapped-ardour];
}
