{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.dbt;

in {
    options.modules.dbt = { enable = mkEnableOption "dbt"; };
    config = mkIf cfg.enable {
        home.packages = [
            pkgs.dbt
        ];
    };
}
