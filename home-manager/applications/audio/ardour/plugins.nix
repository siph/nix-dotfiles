### Plugins for ardour
{pkgs, ...}: {
  plugins = with pkgs; [
    CHOWTapeModel
    ChowCentaur
    ChowKick
    ChowPhaser
    aether-lv2
    airwindows-lv2
    artyFX
    bchoppr
    bjumblr
    boops
    bschaffl
    bsequencer
    bshapr
    bslizr
    calf
    caps
    cardinal
    carla
    cmt
    diopser
    distrho
    dragonfly-reverb
    drumgizmo
    drumkv1
    fire
    fluidsynth
    # fmsynth
    fomp
    geonkick
    gxplugins-lv2
    helm
    infamousPlugins
    kapitonov-plugins-pack
    # lsp-plugins
    mda_lv2
    noise-repellent
    odin2
    rnnoise-plugin
    samplv1
    sfizz
    sonobus
    sorcer
    stochas
    # surge-XT
    swh_lv2
    tap-plugins
    tunefish
    wolf-shaper
    x42-avldrums
    x42-gmsynth
    x42-plugins
    zam-plugins
    zita-convolver
    zynaddsubfx
  ];
}
