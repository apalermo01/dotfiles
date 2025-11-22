{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.nest;
in
{
  options.modules.nest.enable = mkEnableOption "Enables nest-cli";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nest-cli
    ];
  };
}
