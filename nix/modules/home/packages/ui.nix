{ pkgs, lib, config, inputs, ... }:


  with lib;

  let 
    cfg = config.modules.packages.ui;
  in {
    options.modules.packages.ui = { enable = mkEnableOption "UI Packages"; };

    # define things that are installed but not managed by home manager here
    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        xournalpp
        rofi
        i3
        feh
        polybar
        picom
        kitty
	    firefox
        inputs.zen-browser.packages."${system}".default
        nemo-with-extensions
        { nikpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
                "obsidian"
            ];}
      ];
    };
}
