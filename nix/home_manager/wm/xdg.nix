{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let 
  cfg = config.modules.xdg;
in
{
  options.modules.xdg.enable = mkEnableOption "Enables some xdg utils";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-utils
    ];
  };
}
