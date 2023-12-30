{pkgs, ...}:
pkgs.writeTextFile {
  name = "bar-clock";
  text = builtins.readFile ./clock.nu;
  executable = true;
  destination = "/bin/bar-clock";
}
