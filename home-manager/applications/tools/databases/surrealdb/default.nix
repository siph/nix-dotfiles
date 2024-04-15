{pkgs, ...}: {
  home.packages = with pkgs; [surrealdb];
}
