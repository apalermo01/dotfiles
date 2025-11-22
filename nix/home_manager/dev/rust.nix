{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.rust;
in
{
  options.modules.rust.enable = mkEnableOption "Enables cargo and any other rust based dev tools";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cargo
    ];
  };
}
