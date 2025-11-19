{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.discord;

in
{

  options.modules.discord = {
    enable = mkEnableOption "discord";
  };
  config = mkIf cfg.enable {
    home.packages = [ pkgs.discord ];
  };
}
