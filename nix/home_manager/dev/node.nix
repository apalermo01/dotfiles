{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.node;
in
{
  options.modules.node.enable = mkEnableOption "Enables nodejs";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nodejs
    ];
  };
}
