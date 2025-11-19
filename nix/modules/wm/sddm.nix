{

  pkgs,
  config,
  lib,
  ...
}:

{

  options = {
    sddm.enable = lib.mkEnableOption "sddm";
  };

  config = lib.mkIf config.sddm.enable {
    # modules.sddmMonitorLayout.enable = true;
    services.displayManager.sddm.enable = true;
    security.pam.services.sddm.enableGnomeKeyring = true;
  };
}
