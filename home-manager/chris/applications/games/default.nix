{ pkgs, ... }:
{
  imports = [
    ./cataclysm-dda-git
    ./cave-story
    ./freeciv
    ./openttd
    ./steam
    #./wesnoth
    #./dwarf-fortress
    # These are all broken
    #./freeorion
    #./keeperrl
    #./veloren
    #./zeroad
  ];
}
