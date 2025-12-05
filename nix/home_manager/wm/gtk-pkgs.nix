{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let 
  cfg = config.modules.gtk-pkgs;
in
{
  options.modules.gtk-pkgs.enable = mkEnableOption "Enables GTK packages";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gtk3
      gtk4
      glib
      gsettings-desktop-schemas
      gnome-desktop
    ];

    gtk = {
      enable = true;
      theme.name = "Adwaita";
    };
  };
}
