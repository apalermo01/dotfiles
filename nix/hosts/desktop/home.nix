# home manager configuration
{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ../../home_manager/default.nix
  ];

  # define what will be installed by home manager here
  fonts.fontconfig.enable = true;

  modules = {
    python.enable = true;
    zsh.enable = true;
    packages.enable = true;
    git.enable = true;
    direnv.enable = true;
    desktop-entries.enable = true;
    obsidian.enable = true;
    freetube.enable = false;
  };

  programs.zoxide.enable = true;
  programs.obs-studio.enable = true;
}
