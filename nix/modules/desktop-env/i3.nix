{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xss-lock
    rofi
    i3
    feh
    (polybar.override { pulseSupport = true; })
    picom
    i3lock
    kitty
  ];

  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
  };

  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "none+i3";
}
