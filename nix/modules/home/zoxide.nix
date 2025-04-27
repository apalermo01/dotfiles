{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.zoxide;

in {
    options.modules.zoxide = { enable = mkEnableOption "zoxide"; };
    config = mkIf cfg.enable {
        options = ["--cmd cd"];
    };
}
