{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.freetube;

in {
    
    options.modules.freetube = { enable = mkEnableOption "freetube"; };
    config = mkIf cfg.enable {
        programs.freetube = {
            enable = true;
        };
    };
}
