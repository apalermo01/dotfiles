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
 adwaita-mono
 agave
 anonymice
 arimo
 atkynson-mono
 aurulent-sans-mono
 bigblue-terminal
 bitstream-vera-sans-mono
 blex-mono
 caskaydia-cove
 caskaydia-mono
 code-new-roman
 comic-shanns-mono
 commit-mono
 cousine
 d2coding
 daddy-time-mono
 dejavu-sans-mono
 departure-mono
 droid-sans-mono
 envy-code-r
 fantasque-sans-mono
 fira-code
 fira-mono
 geist-mono
 go-mono
 gohufont
 hack
 hasklug
 heavy-data
 hurmit
 im-writing
 inconsolata
 inconsolata-go
 inconsolata-lgc
 intone-mono
 iosevka
 iosevka-term
 iosevka-term-slab
 jetbrains-mono
 lekton
 liberation
 lilex
 martian-mono
 meslo-lg
 monaspace
 monofur
 monoid
 mononoki
 noto
 open-dyslexic
 overpass
 profont
 proggy-clean-tt
 recursive-mono
 roboto-mono
 shure-tech-mono
 sauce-code-pro
 space-mono
 symbols-only
 terminess-ttf
 tinos
 ubuntu
 ubuntu-mono
 ubuntu-sans
 victor-mono
 zed-mono

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
    xss-lock-i3.enable = true;
  };

}
