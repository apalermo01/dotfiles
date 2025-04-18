{ inputs, pkgs, config, ... }:

{
    home.stateVersion = "21.03";
    imports = [
      ./packages/default.nix
    ];
}
