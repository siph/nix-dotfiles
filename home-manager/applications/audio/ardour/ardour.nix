/*
This is a convenience wrapper to include plugins into the ardour derivation.
*/
{
  ardour,
  lib,
  makeBinaryWrapper,
  plugins ? [],
  runCommand,
  ...
}: (runCommand
  (ardour.name + "_wrapped_" + ardour.version)
  {
    buildInputs = [ardour];
    nativeBuildInputs = [makeBinaryWrapper];
  }
  ''
    mkdir -p $out/bin

    for file in ${ardour}/bin/*;
    do
      filename="$(basename -- $file)"
      makeWrapper "$file" "$out/bin/$filename" \
        --prefix LADSPA_PATH : "${lib.makeSearchPath "lib/ladspa" plugins}" \
        --prefix LV2_PATH : "${lib.makeSearchPath "lib/lv2" plugins}" \
        --prefix LXVST_PATH : "${lib.makeSearchPath "lib/lxvst" plugins}" \
        --prefix VST_PATH : "${lib.makeSearchPath "lib/vst" plugins}";
    done
  '')
