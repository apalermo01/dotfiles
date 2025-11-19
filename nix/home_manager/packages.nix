{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.modules.packages;
in
{
  options.modules.packages = {
    enable = mkEnableOption "packages";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      xournalpp
      kitty
      firefox
      nemo-with-extensions
      libnotify
      dunst
      mailutils
      zoom-us
      obsidian
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
      i3lock
      brave
      glib
      xdg-utils
      neovim
      btop
      ncdu
      direnv
      ripgrep
      zinit
      dbt
      killall
      fortune
      cowsay
      pywal
      stow

      # language utils
      nixfmt-rfc-style

      # compilers / builders
      gcc
      cargo
      gnumake

      # language runtimes
      nodejs
      go

      glibcLocales

    ];
  };
}
