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
    terminess-ttf
    jetbrains-mono
    iosevka
    iosevka-term
    iosevka-term-slab
    hack
    fira-code
    fira-mono
    zed-mono
    comic-shanns-mono
    blex-mono
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
    kvantum.enable = true;
    # element.enable = true;
    # ollama.enable = true;
  };

  services = {
    xss-lock-i3 = {
      enable = true;
    };
  };

}
