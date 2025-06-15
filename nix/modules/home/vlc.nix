{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.vlc;

in {
    
    options.modules.vlc = { enable = mkEnableOption "vlc"; };
    config = mkIf cfg.enable {
        programs.vlc = {
            enable = true;
        };
    };
}
