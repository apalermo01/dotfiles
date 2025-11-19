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
    # packages.ui.enable = true;
    packages.enable = true;
    git.enable = true;
    direnv.enable = true;
    zoxide.enable = true;
    desktop-entries.enable = true;
    discord.enable = true;
    obs.enable = true;
    vlc.enable = true;
    obsidian.enable = true;
    # freetube.enable = true;
  };

}
