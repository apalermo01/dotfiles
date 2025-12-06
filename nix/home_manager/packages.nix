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

      glib
      glibcLocales



      killall
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

      themechanger

      # needed for gtk themes
      sassc
      meson
      ninja
    ];
  };
}
