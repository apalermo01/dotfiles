{
  pkgs,
  lib,
  config,
  ...
}:

# note: left out git, xautolock, xss-lock-i3
with lib;

let
  cfg = congig.modules.everything;
in
{
  config = {
    home.packages = with pkgs; [

      # libraries
      glibcLocales
      libnotify
      glib
      libinput
      libnotify
      dunst
      openvpn
      brightnessctl
      lm_sensors
      libimobiledevice
      usbmuxd
      ifuse
      jellyfin-ffmpeg

      # packages / utilities
      stow
      fzf
      rclone
      btop
      restic
      man-pages
      man-pages-posix
      lsof
      postgresql
      sqitchPg
      ncdu
      direnv
      ripgrep
      zinit
      dbt
      killall
      pywal
      stow
      ricer
      bat
      eza
      delta
      tealdeer
      starship
      flameshot
      pandoc
      devcontainer
      docker

      # toys
      cbonsai
      fastfetch
      pywal
      fortune
      cowsay
      libsForQt5.qtstyleplugin-kvantum
      cmatrix

      # terminal apps
      sioyek
      yazi
      tmux
      zsh
      neovim
      newsboat

      # utils for gui
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-utils
      pinentry-qt
      qmk

      # gui utilities
      xss-lock
      puddletag
      via
      alsa-utils
      alsa-plugins
      pamixer

      # gui applications
      xournalpp
      rofi
      i3
      feh
      (polybar.override { pulseSupport = true; })
      picom
      kitty
      networkmanagerapplet
      wezterm
      firefox
      brave
      nemo-with-extensions
      dunst
      zoom-us
      obsidian
      keymapviz
      imagemagick
      libsForQt5.xp-pen-deco-01-v2-driver
      discord
      vlc
      pavucontrol
      pywalfox-native
      xfce.thunar
      xfce.thunar-volman
      kdePackages.dolphin
      libreoffice-qt6-fresh
      networkmanagerapplet
      kdePackages.okular
      kdePackages.plasma-workspace
      tor-browser
      anytype
      standardnotes
      signal-desktop

      # language utils
      nixfmt-rfc-style
      pyright
      nil
      lua-language-server
      markdown-oxide
      sqls
      postgrestools
      stylua
      shfmt
      mdformat
      yamlfix
      pgformatter
      deno
      nest-cli

      # compilers / builders
      gcc
      cargo
      gnumake
      llvmPackages_latest.lldb
      llvmPackages_latest.libllvm
      llvmPackages_latest.libcxx
      llvmPackages_latest.clang
      clang-tools
      clang

      # language runtimes
      nodejs
      go
      python

    ];
    xdg.enable = true;
    xdg.mime = {
      enable = true;
    };
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;

    };
    programs.freetube.enable = true;
    programs.obs-studio.enable = true;
    programs.zoxide.enable = true;
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/obsidian" = "obsidian.desktop";
        "text/markdown" = "obsidian.desktop";
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
      };
    };
    xdg.desktopEntries = {
      freetube = {
        name = "freetube";
        # comment = "Open Source YouTube app for privacy";
        exec = "sh -c \"bash \\$HOME/Scripts/freetube.sh %U\"";
        terminal = false;
        type = "Application";
        # icon = "freetube";
        # startupWMClass = "FreeTube";
        mimeType = [ "x-scheme-handler/freetube" ];
        categories = [ "Network" ];
        noDisplay = false;
      };
      obsidian = {
        name = "Obsidian";
        exec = "${pkgs.obsidian}/bin/obsidian %u";
        type = "Application";
        terminal = false;
        mimeType = [
          "x-scheme-handler/obsidian"
          "text/markdown"
        ];
      };
    };
  };
}
