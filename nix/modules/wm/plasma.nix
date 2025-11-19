{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    kdePlasma.enable = lib.mkEnableOption "kdePlasma";
  };

  config = lib.mkIf config.kdePlasma.enable {

    services.xserver = {
      enable = true;
    };

    services.displayManager = {
      sddm.enable = true;
      sddm.wayland.enable = true;
    };
    
    services.desktopManager.plasma6.enable = true;

  };
}
