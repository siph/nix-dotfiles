{ pkgs, ... }:
{
  imports = [
    ./cataclysm-dda-git
    ./cave-story
    ./freeciv
    ./lutris
    ./openttd
    ./starsector
    ./steam
    ./veloren
    #./wesnoth
    #./dwarf-fortress
    # These are all broken
    #./freeorion
    #./keeperrl
    #./zeroad
  ];
}
