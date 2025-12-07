{
  config,
  pkgs,
  lib,
  ...
}:

let
  MonitorLayout = pkgs.writeShellScript "monitor-layout" ''
    #!/bin/sh
    ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-2 --auto --left-of eDP-1
    ${pkgs.xorg.xrandr}/bin/xrandr --output DP-1 --auto --left-of HDMI-2
  '';
in
{

  services.displayManager.sddm.setupScript = "${MonitorLayout}";

  services.acpid = {
    enable = true;
    lidEventCommands = ''
        export DISPLAY=:0
        export PATH=$PATH:/run/current-system/sw/bin
        export XAUTHORITY=$(ls /var/run/sddm/ | head -n1)

        LID_STATE=$(cat /proc/acpi/button/lid/LID/state | awk '{print $2}')
        EXTERNAL_MONITOR=$(xrandr | grep " connected" | grep -v "eDP" | awk '{print $1}')

        if [ "$LID_STATE" = "closed" ] && [ -n "$EXTERNAL_MONITOR" ]; then
          xrandr --output eDP-1 --off --output $EXTERNAL_MONITOR --auto
        else
          ${MonitorLayout}
        fi
    '';
  };
}
