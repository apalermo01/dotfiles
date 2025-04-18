{ pkgs, lib, config, ... }:


  with lib;

  let 
    cfg = config.modules.packages;
  in {
    options.modules.packages = { enable = mkEnableOption "packages"; };
    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        tmux fish neovim xournalpp
        sioyek rofi git i3wm
        polybar picom
      ];
    };
}
