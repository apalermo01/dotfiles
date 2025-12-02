{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.matugen;

in {
    options.modules.matugen = { enable = mkEnableOption "matugen"; };
    config = mkIf cfg.enable {
        home.packages = [
            pkgs.matugen
        ];
    };
}
