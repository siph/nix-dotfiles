{ pkgs, ... }:
pkgs.writeTextFile {
  name = "bar-weather";
  text = builtins.readFile ./weather.nu;
  executable = true;
  destination = "/bin/bar-weather";
}

