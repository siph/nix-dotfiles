### Plugins for ardour
{pkgs, ...}: {
  plugins = with pkgs; [
    artyFX
    bchoppr
    bjumblr
    boops
    bsequencer
    bshapr
    bslizr
    caps
    distrho
    drumgizmo
    drumkv1
    fmsynth
    fomp
    gxplugins-lv2
    helm
    infamousPlugins
    kapitonov-plugins-pack
    lsp-plugins
    mda_lv2
    ninjas2
    samplv1
    swh_lv2
    tunefish
    x42-avldrums
    x42-plugins
  ];
}
