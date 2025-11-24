{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let 
  cfg = config.modules.ai;
in
{
  options.modules.ai.enable = mkEnableOption "Enables AI tools";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      claude-code
    ];
  };
}
