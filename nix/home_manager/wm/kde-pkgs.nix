{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let 
  cfg = config.modules.kde-pkgs;
in
{
  options.modules.kde-pkgs.enable = mkEnableOption "Enables KDE packages";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      kdePackages.kconfig
      kdePackages.kde-cli-tools
      kdePackages.okular
      kdePackages.qtsvg
    ];
  };
}
