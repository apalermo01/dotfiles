{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ../../modules/home/default.nix
  ];

  home.packages = with pkgs.nerd-fonts; [
    nerdfonts
  ];

  # define what will be installed by home manager here
  fonts.fontconfig.enable = true;
  modules = {
    packages.headless.enable = true;
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
    xss-lock-i3 = {
      enable = true;
    };
  };
}
