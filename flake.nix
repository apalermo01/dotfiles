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

  };

  outputs =
    {
      home-manager,
      nixpkgs,
      ...
    }@inputs:

    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import inputs.nixpkgs {
        overlays = [
          (import ./nix/overlays/postgrestools.nix)
          (import ./nix/overlays/ricer.nix)
          (import ./nix/overlays/sioyek.nix)
          # (import ./nix/overlays/glib.nix)
        ];
        system = system;
        config = {
          allowUnfreePredicate =
            pkg:
            builtins.elem (lib.getName pkg) [
              "anytype"
              "anytype-heart"
              "claude-code"
              "cursor"
              "datagrip"
              "discord"
              "obsidian"
              "xp-pen-deco-01-v2-driver"
              "via"
              "zoom"
              "reaper"
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

            ./nix/hosts/${hostname}/configuration.nix

            # home manager
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alex = import (./nix/hosts + "/${hostname}/home.nix");
              home-manager.backupFileExtension = "hm-bak";
              home-manager.extraSpecialArgs = {
                inherit inputs;
              };
            }
          ];
          specialArgs = { inherit inputs; };
        };

      mkHome =
        system: hostname: username:
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          modules = [
            ./nix/hosts/${hostname}/home.nix
            {
              home = {
                username = "${username}";
                homeDirectory = "/home/${username}";
              };
            }
          ];
          extraSpecialArgs = { inherit inputs; };
        };

    in

    # declare the possible hosts here.
    # I'm only using one system, so I'm removing the other hosts
    {

      # machines running nixos
      nixosConfigurations = {
        desktop = mkSystem pkgs "x86_64-linux" "desktop";
      };

      # home manager only
      homeConfigurations = {
        wsl = mkHome pkgs "wsl" "apalermo";
      };
    };
}
