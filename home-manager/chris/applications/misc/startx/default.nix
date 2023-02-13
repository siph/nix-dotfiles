{ lib, pkgs, ... }:
{
  home.packages = with pkgs; [ feh xcompmgr dmenu ];
  home.file = {
    ".clock" = {
      text = ''
        #!/usr/bin/env bash
        while true; do
            xsetroot -name "$(date '+ %I:%M:%S %P ')"
            sleep 1
        done
      '';
      executable = true;
      };
    ".xinitrc" = {
      text = ''
        #!/usr/bin/env bash
        session=''${1}

        case $session in
          dwm)  "$HOME/.fehbg" &
                xcompmgr &
                xinput set-prop 'Logitech G500' 'libinput Accel Speed' -0.65 &
                xset -dpms &
                "$HOME/.clock" &
                export _JAVA_AWT_WM_NONREPARENTING=1
                exec dwm ;;
          kde)  export DESKTOP_SESSION=plasma
                xinput set-prop 'Logitech G500' 'libinput Accel Speed' -0.65 &
                exec startplasma-x11 ;;
        esac
      '';
      executable = true;
    };
    ".fehbg" = {
      text = ''
        #!/usr/bin/env bash
        feh --no-fehbg --bg-scale '/home/chris/Pictures/background.png'
      '';
      executable = true;
    };
  };
}
