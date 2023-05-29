{ ... }:
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;
      userChrome = ''
        @import "${
          builtins.fetchGit {
            url = "https://github.com/rockofox/firefox-minima";
            ref = "main";
            rev = "1477b2a28091aad4ebba330c539110c311eb8084";
          }
        }/userChrome.css";
      '';
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };
}
