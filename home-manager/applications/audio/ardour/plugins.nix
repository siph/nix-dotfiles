### Plugins for ardour
{pkgs, ...}: {
  plugins = with pkgs; [
    lsp-plugins
    caps
    bchoppr
    bsequencer
    bshapr
    bslizr
    drumgizmo
    helm
    infamousPlugins
    ninjas2
    swh_lv2
    x42-avldrums
    x42-plugins
    lsp-plugins
  ];
}
