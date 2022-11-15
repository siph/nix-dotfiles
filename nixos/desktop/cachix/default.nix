{  inputs, ... }: {
  imports = [
    inputs.declarative-cachix.nixosModules.declarative-cachix
  ];
  cachix = [
    { name = "veloren-nix"; sha256 = "1yv09n45bgmvkjxm6jq8v6js5qy5y85d4cn2ayn60bp48mas2bar"; }
  ];
}
