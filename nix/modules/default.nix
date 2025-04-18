{ inputs, pkgs, config, ... }:

{
    home.stateVersion = "21.03";
    imports = [
      ./packages/headless.nix
      ./packages/ui.nix
      ./git/default.nix
      ./stow/default.nix
    ];

}
