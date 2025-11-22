{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.deno;
in
{
  options.modules.deno.enable = mkEnableOption "Enables deno";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      deno
    ];
  };
}
