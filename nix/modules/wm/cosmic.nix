{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    cosmic.enable = lib.mkEnableOption "cosmic";
  };

  config = lib.mkIf config.cosmic.enable {
    environment.systemPackages = with pkgs; [
    ];

    services.displayManager.cosmic-greeter.enable = true;
    services.desktopManager.cosmic.enable = true;

  };
}
