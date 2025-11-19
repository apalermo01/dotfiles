{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.sql;
in
{
  options.modules.sql.enable = mkEnableOption "Enables Sql";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      pgformatter
      postgrestools
      sqls
      sqitchPg
    ];
  };
}
