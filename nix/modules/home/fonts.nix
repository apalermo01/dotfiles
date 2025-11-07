{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.nerd-fonts;

in {
    
    options.modules.nerd-fonts = { enable = mkEnableOption "nerd-fonts"; };
    config = mkIf cfg.enable {
        programs.obs-studio = {
            enable = true;
        };
    };
}
