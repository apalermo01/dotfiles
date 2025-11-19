{
  inputs,
  pkgs,
  config,
  ...
}:

{
  home.stateVersion = "21.03";
  imports = [
    ./dev
    ./wm
    ./packages.nix



    ./fonts.nix
    ./git.nix
    ./direnv.nix
    ./datagrip.nix
    ./desktop-entries.nix
    ./freetube.nix
    # ./zsh.nix
  ];

}
