# github.com/sioodmy/dotfiles/blob/main/flake.nix
# github.com/notusknot/dotfiles-nix

{
  description = "Main flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs =
    {
      home-manager,
      nixpkgs,
      zen-browser,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import inputs.nixpkgs {
        system = system;
        config = {
          allowUnfreePredicate =
            pkg:
            builtins.elem (lib.getName pkg) [
              "obsidian"
              "zoom"
            ];
        };
      };

      mkSystem =
        pkgs: system: hostname:
        lib.nixosSystem {
          pkgs = pkgs;
          system = system;
          modules = [
            { networking.hostName = hostname; }
            ./nix/modules/system/configuration.nix
            ./nix/hosts/${hostname}/hardware-configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alex = import (./nix/hosts + "/${hostname}/user.nix");
              home-manager.extraSpecialArgs = {
                inherit inputs;
              };
            }
          ];
          specialArgs = { inherit inputs; };
        };

      mkHome =
        system: hostname:
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          modules = [
            ./nix/hosts/${hostname}/user.nix
            {
                home = {
                    username = "apalermo";
                    homeDirectory = "/home/apalermo";
                };
            }
          ];
          extraSpecialArgs = { inherit inputs; };
        };

    in
    {
      nixosConfigurations = {
        vm = mkSystem pkgs "x86_64-linux" "vm";
        laptop = mkSystem pkgs "x86_64-linux" "laptop";
      };
      homeConfigurations = {
        wsl = mkHome system "wsl";
      };
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.gcc
          (pkgs.python311.withPackages (
            ps: with ps; [
              pip
              virtualenv
              numpy
              matplotlib
              toml
              pyyaml
              isort
              black
              jinja2
            ]
          ))
        ];
      };
    };
}
