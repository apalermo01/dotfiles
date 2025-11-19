{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    ricer.enable = lib.mkEnableOption "enables custom theme switcher";
  };

  config = lib.mkIf config.ricer.enable {
    environment.systemPackages = [
      pkgs.ricer
    ];
  };
}
