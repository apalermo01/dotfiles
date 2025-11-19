{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.datagrip;

in {
    options.modules.datagrip = { enable = mkEnableOption "datagrip"; };
    config = mkIf cfg.enable {
        home.packages = [
            pkgs.jetbrains.datagrip
        ];
    };
}
