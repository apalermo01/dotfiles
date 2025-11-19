{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.modules.ricer = {
    enable = lib.mkEnableOption "enables custom theme switcher";
  };

  config = lib.mkIf config.modules.ricer.enable {
    home.packages = [
      pkgs.ricer
    ];
  };
}
