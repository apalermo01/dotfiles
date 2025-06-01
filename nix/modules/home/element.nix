{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.element;

in
{
  options.modules.element = {
    enable = mkEnableOption "element";
  };
  config = mkIf cfg.enable {
    programs.element-dekstop = {
      enable = true;
    };
  };
}
