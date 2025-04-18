{ pkgs, lib, config, ... }:


  with lib;

  let 
    cfg = config.modules.packages;
  in {
    options.modules.packages.ui = { enable = mkEnableOption "UI Packages"; };

    # define things that are installed but not managed by home manager here
    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        xournalpp
        rofi
        i3wm
        polybar
        picom
      ];
    };
}
