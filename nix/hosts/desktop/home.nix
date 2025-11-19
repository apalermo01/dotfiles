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
    packages.headless.enable = false;
    packages.ui.enable = true;
    git.enable = true;
    direnv.enable = true;
    zoxide.enable = true;
    desktop-entries.enable = true;
    discord.enable = true;
    obs.enable = true;
    vlc.enable = true;
    freetube.enable = true;
  };
  services = {
    xss-lock-i3.enable = true;
  };

}
