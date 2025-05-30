{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.pip;

in {
    
    options.modules.pip = { enable = mkEnableOption "pip"; };
    config = mkIf cfg.enable {
        programs.python311Packages.pip = {
            enable = true;
        };
    };
}
