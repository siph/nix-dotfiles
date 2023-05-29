{ pkgs, ... }:
{
  home.packages = with pkgs; [ feh dmenu mywm ];
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
          dwm)     "$HOME/.fehbg" &
                   picom &
                   xinput set-prop 'Logitech G500' 'libinput Accel Speed' -0.65 &
                   xset s off &
                   xset s 0 0 &
                   xset -dpms &
                   "$HOME/.clock" &
                   export _JAVA_AWT_WM_NONREPARENTING=1
                   exec dwm ;;
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
                   exec dbus-launch --exit-with-session xmonad ;;
          mywm)  "$HOME/.fehbg" &
                   picom &
                   export XDG_CURRENT_DESKTOP=mywm
                   export XDG_SESSION_TYPE=x11
                   export XDG_SESSION_DESKTOP=mywm
                   export XDG_CONFIG_HOME=/home/chris/.config
                   export _JAVA_AWT_WM_NONREPARENTING=1
                   export DISPLAY=:0
                   xinput set-prop 'Logitech G500' 'libinput Accel Speed' -0.65 &
                   xsetroot -cursor_name left_ptr &
                   xset s off &
                   xset s 0 0 &
                   xset -dpms &
                   exec ${pkgs.mywm}/bin/mywm &> ~/.penrose.log ;;
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
