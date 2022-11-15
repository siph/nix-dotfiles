{ pkgs, ... }:
{
  imports = [
    ./cataclysm-dda-git
    ./cave-story
    ./dwarf-fortress
    ./freeciv
    ./openttd
    ./wesnoth
    # These are all broken
    #./freeorion
    #./keeperrl
    #./veloren
    #./zeroad
  ];
}
