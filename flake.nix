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

      # github.com/sioodmy/dotfiles/blob/main/flake.nix
      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
            system = system;
            modules = [
                { networking.hostName = hostname; }
                ./nix/modules/system/configuration.nix
                ./nix/hosts/${hostname}/hardware-configuration.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager = {
                        useUserPackages = true;
                        useGlobalPackages = true;
                        specialArgs = { inherit inputs; };
                        users.alex = (./nix/hosts/${hostname}/configuration.nix);
                    };
                }
            ];
        };

    in
    {
      nixosConfigurations = {
        vm = mkSystem inputs.nixpkgs "x86_64-linux" "vm";
        personal = mkSystem inputs.nixpkgs "x86_64-linux" "personal";
      };
    };
}
