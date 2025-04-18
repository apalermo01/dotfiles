{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.stow;

in {
    options.modules.stow = { enable = mkEnableOption "stow"; };
    config = mkIf cfg.enable {
        programs.stow = {
            enable = true;
        };
    };
}
