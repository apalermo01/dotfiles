{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.pip;

in {
    
    options.modules.pip = { enable = mkEnableOption "pip"; };
    config = mkIf cfg.enable {
        programs.python312Packages.pip = {
            enable = true;
        };
    };
}
