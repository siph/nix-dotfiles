{ lib, pkgs, ... }:{
  home = rec {
    packages = with pkgs; [
      (pkgs.dwarf-fortress-packages.dwarf-fortress-full.override {
        theme = "jolly-bastion";
        enableIntro = false;
      })
    ];
  };
}
