{ pkgs, lib, config, ... }:

with lib; 
let cfg = config.modules.kvantum;

in {

    options.modules.kvantum = { enable = mkEnableOption "kvantum"; };
    config = mkIf cfg.enable {
        libsForQt5.qtstyleplugin-kvantum = {
            enable = true;
        };
    };
}
