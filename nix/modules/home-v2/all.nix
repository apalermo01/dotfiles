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
      # tmux
      # fish
      # zsh
      # neovim
      # sioyek
      # stow
      # fzf
      #
      # terminal stuff
      # yazi
      # cbonsai
      # fastfetch
      # bat
      # eza
      # gitui
      # delta
      # oh-my-posh
      # tealdeer
      # starship

      # lsp s
      # pyright
      # nil
      # lua-language-server
      # markdown-oxide
      # sqls
      # postgrestools

      # formatters
      # stylua
      # nixfmt-rfc-style
      # shfmt
      # mdformat
      # yamlfix
      # pgformatter

      # programming languages
      python

      ricer

      # packages / utilities
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
      xournalpp
      rofi
      i3
      feh
      (polybar.override { pulseSupport = true; })
      picom
      kitty
      wezterm
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

      code-cursor
      cmatrix
      jetbrains.datagrip

      discord
      pandoc
      vlc
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
