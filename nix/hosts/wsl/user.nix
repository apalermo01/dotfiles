{
  config,
  lib,
  imports,
  pkgs,
  ...
}:

{

  imports = [
    ../../modules/home/default.nix
  ];

  fonts.fontconfig.enable = true; 

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

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';

  modules = {
    packages.headless.enable = true;
    packages.home_only.enable = true;
    git.enable = true;
    direnv.enable = true;
    zoxide.enable = true;
    datagrip.enable = true;
    pandoc.enable = true;
  };
}
