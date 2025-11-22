{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.yamlfix;
in
{
  options.modules.yamlfix.enable = mkEnableOption "Enables yamlfix";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      yamlfix
    ];
  };
}
