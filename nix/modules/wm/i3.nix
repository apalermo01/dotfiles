{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    i3wm.enable = lib.mkEnableOption "i3wm";
  };

  config = lib.mkIf config.i3wm.enable {
    environment.systemPackages = with pkgs; [
      xss-lock
      rofi
      i3
      feh
      (polybar.override { pulseSupport = true; })
      picom
      i3lock
    ];

    services.xserver = {
      enable = true;
      windowManager.i3.enable = true;
    };

    security.pam.services.i3lock.enable = true;
    services.displayManager.sddm.enable = true;
    services.displayManager.defaultSession = "none+i3";

  };
}
