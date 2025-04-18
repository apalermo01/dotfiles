{ pkgs, lib, config, ... }:

{
  with lib;
  options.modules.packages = { enable = mkEnableOption "packages"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      tmux fish neovim xournalpp
      sioyek rofi git i3wm
      polybar picom
    ];
  };
}
