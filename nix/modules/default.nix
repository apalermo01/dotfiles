{ inputs, pkgs, config, ... }:

{
    home.stateVersion = "21.03";
    imports = [
      ./packages_user/headless.nix
      ./packages_user/ui.nix
      ./packages_system/default.nix
      ./git/default.nix
      ./stow/default.nix
    ];

}
