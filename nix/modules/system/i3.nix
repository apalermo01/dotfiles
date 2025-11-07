{ lib, pkgs, ... }:
let
  stable = import (builtins.fetchTarball {
    name = "nix-stable";
    url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/25.05.tar.gz";
    sha256 = "1915r28xc4znrh2vf4rrjnxldw2imysz819gzhk9qlrkqanmfsxd";
  }) { system = "x86_64-linux"; };
in
{
  environment.systemPackages = with pkgs; [
      xss-lock
      rofi
      i3
      feh
      (polybar.override { pulseSupport = true; })
      picom
      kitty
  ];

  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
  };

  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "none+i3";
}
