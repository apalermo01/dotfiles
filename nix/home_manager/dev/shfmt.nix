{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.shfmt;
in
{
  options.modules.shfmt.enable = mkEnableOption "Enables formatter for shell scripts";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      shfmt
    ];
  };
}
