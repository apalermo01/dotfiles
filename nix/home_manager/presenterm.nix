{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.modules.presenterm = {
    enable = lib.mkEnableOption "Enables presenterm";
  };

  config = lib.mkIf config.modules.presenterm.enable {
    home.packages = with pkgs; [
      presenterm
    ];
  };
}
