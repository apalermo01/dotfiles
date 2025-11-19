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
      wget
      file
      pandoc
      unzip
      xsel
      fnm
      btop
      ncdu
      direnv
      ripgrep
      neovim
      tmux
      kitty
      dunst
      zinit
      fortune
      cowsay
      pywal
      stow
      pywalfox-native

      libnotify
      glib
      glibcLocales

      xournalpp
      discord
      firefox
      brave
      zoom-us
      libreoffice-qt6-fresh
      signal-desktop
      flameshot

      kdePackages.dolphin
      kdePackages.kconfig
      kdePackages.kde-cli-tools
      kdePackages.okular
      kdePackages.qtsvg

      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.xp-pen-deco-01-v2-driver
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-utils
      xfce.thunar
      xfce.thunar-volman

      vlc
      killall
      rclone
      restic
      nvimpager
      newsboat
      fzf
      yazi
      sioyek
      cbonsai
      delta
      man-pages
      tree
      man-pages-posix
      oh-my-posh
      tealdeer
      starship
      lsof
      fastfetch
      bat
      eza
      openvpn

    ];
  };
}
