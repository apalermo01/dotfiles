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
      ocs-url
    ];

    home.sessionVariables = {
      XDG_DATA_DIRS = lib.mkBefore "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}";
    };
    home.file.".config/gsettings-init.sh".text = ''
      export XDG_DATA_DIRS="${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:$XDG_DATA_DIRS"
    '';
  };
}
