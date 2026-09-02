{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    configPath = ".mozilla/firefox";
    profiles.default = {
      isDefault = true;
      userChrome = ''
        @import "${pkgs.firefox-minima}/share/firefox-minima/userChrome.css"
      '';
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };
}
