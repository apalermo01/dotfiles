{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.modules.reaper = {
    enable = lib.mkEnableOption "Enables reaper";
  };

  config = lib.mkIf config.modules.reaper.enable {
    home.packages = with pkgs; [
      reaper
    ];
  };
}
