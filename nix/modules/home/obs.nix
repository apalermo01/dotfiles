{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.obs;

in {
    
    options.modules.obs = { enable = mkEnableOption "obs"; };
    config = mkIf cfg.enable {
        programs.obs-studio = {
            enable = true;
        };
    };
}
