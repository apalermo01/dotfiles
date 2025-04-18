# github.com/sioodmy/dotfiles/blob/main/flake.nix
# github.com/notusknow/dotfiles-nix

{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { home-manager, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      lib = nixpkgs.lib;

      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
            system = system;
            modules = [
                { networking.hostName = hostname; }
                ./nix/modules/system/configuration.nix
                ./nix/hosts/${hostname}/hardware-configuration.nix
                # nix-ld.nixosModules.nix-ld
                home-manager.nixosModules.home-manager {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.alex = import (./nix/hosts + "/${hostname}/user.nix");
                  home-manager.extraSpecialArgs = { inherit inputs; };
                }
            ];
            specialArgs = { inherit inputs; };
        };

    in
    {
      nixosConfigurations = {
        vm = mkSystem inputs.nixpkgs "x86_64-linux" "vm";
        personal = mkSystem inputs.nixpkgs "x86_64-linux" "personal";
      };
    };
}
