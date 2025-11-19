{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.pandoc;
in
{

  options.modules.pandoc = {
    enable = mkEnableOption "pandoc";
  };
  config = mkIf cfg.enable {
    home.packages = [ pkgs.pandoc ];
  };
}
