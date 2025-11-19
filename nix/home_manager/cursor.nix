{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.cursor;
in 
{ 
  options.modules.cursor = {
    enable = mkEnableOption "cursor";
  };
  config = mkIf cfg.enable {
    home.packages = [ pkgs.code-cursor 
                      pkgs.cmatrix ];
  };
}
