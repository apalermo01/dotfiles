{
  config,
  lib,
  inputs,
  ...
}:

{
  imports = [
    ../../modules/home/default.nix
  ];


  # define what will be installed by home manager here
  config.modules = {
    packages.headless.enable = true;
    packages.ui.enable = true;
    git.enable = true;
    direnv.enable = true;
    zoxide.enable = true;
    desktop-entries.enable = true;
    discord.enable = true;
    obs.enable = true;
    vlc.enable = true;
    # element.enable = true;
  };

  config.services = {
    xss-lock-i3 = {
      enable = true;
    };
  };

}
