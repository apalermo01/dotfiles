{ pkgs,
  # unstablePkgs,
  lib,
  config,
  inputs,
  ... }:


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
        (polybar.override { pulseSupport = true; })
        picom
        kitty
	    firefox
        inputs.zen-browser.packages."${system}".default
        nemo-with-extensions
        libnotify
        dunst
        mailutils
        zoom-us
        obsidian
        # magick
        imagemagick
        dconf-editor
        themechanger
        kdePackages.kconfig
        libsForQt5.xp-pen-deco-01-v2-driver
        kdePackages.kde-cli-tools
        libsForQt5.qt5ct
        libsForQt5.qtstyleplugin-kvantum
        flameshot
        xdg-desktop-portal
        xdg-desktop-portal-gtk
      ];
    };
}
