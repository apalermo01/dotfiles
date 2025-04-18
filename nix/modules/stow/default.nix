{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.git;

in {
    options.modules.git = { enable = mkEnableOption "stow"; };
    config = mkIf cfg.enable {
        programs.stow = {
            enable = true;
        };
    };
}
