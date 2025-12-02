{ config, pkgs, lib, ... }:

{
  # options.modules.sddmMonitorLayout.enable = lib.mkEnableOption "Enable monitor layout script for SDDM";

  # config = lib.mkIf config.modules.sddmMonitorLayout.enable {
    services.displayManager.sddm.setupScript = ''
      #!/bin/sh
      ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-2 --auto --left-of eDP-1
      ${pkgs.xorg.xrandr}/bin/xrandr --output DP-1 --auto --left-of HDMI-2
    '';
  # };
}
