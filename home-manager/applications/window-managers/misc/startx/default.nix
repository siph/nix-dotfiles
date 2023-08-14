{ pkgs, ... }:
{
  home.packages = with pkgs; [ feh ];
  home.file = {
    ".xinitrc" = {
      text = ''
        #!/usr/bin/env bash
        session=''${1}

        case $session in
          kde)     export DESKTOP_SESSION=plasma
                   xinput set-prop 'Logitech G500' 'libinput Accel Speed' -0.65 &
                   exec startplasma-x11 ;;
          xmonad)  "$HOME/.fehbg" &
                   picom &
                   export XDG_CURRENT_DESKTOP=xmonad
                   export XDG_SESSION_TYPE=x11
                   export XDG_SESSION_DESKTOP=xmonad
                   export _JAVA_AWT_WM_NONREPARENTING=1
                   export DISPLAY=:0
                   xinput set-prop 'Logitech G500' 'libinput Accel Speed' -0.65 &
                   xsetroot -cursor_name left_ptr &
                   xset s off &
                   xset s 0 0 &
                   xset -dpms &
                   lxpolkit &
                   exec dbus-launch --exit-with-session xmonad ;;
        esac
      '';
      executable = true;
    };
    ".fehbg" = {
      text = ''
        #!/usr/bin/env bash
        feh --no-fehbg --bg-scale '/home/chris/Pictures/background.jpg'
      '';
      executable = true;
    };
  };
}
