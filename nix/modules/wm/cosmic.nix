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
        xorg.xinit # adding this b/c of startx not found error when starting i3 from cosmic-greeter
    ];

    services.displayManager.cosmic-greeter.enable = true;
    services.desktopManager.cosmic.enable = true;

  };
}
