# github.com/sioodmy/dotfiles/blob/main/flake.nix
# github.com/notusknot/dotfiles-nix

{
  description = "Main flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos";
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
        ];
        system = system;
        config = {
          allowUnfreePredicate =
            pkg:
            builtins.elem (lib.getName pkg) [
              "obsidian"
              "zoom"
              "datagrip"
              "xp-pen-deco-01-v2-driver"
              "discord"
              "cursor"
              "via"
            ];
        };
      };
      role = {
        "headless" = ./nix/roles/headless.nix;
        "desktop" = ./nix/roles/desktop.nix;
        "wsl" = ./nix/roles/headless.nix;
        "server" = ./nix/roler/server.nix;
      };

      extraModuleList = {
        "desktop" = [
        ];

        "wsl" = [
          ./nix/roles/ai_tools.nix
        ];

        "gc-workstation" = [
        ];

        "server" = [

        ];
      };

      mkSystem =
        pkgs: system: hostname:
        lib.nixosSystem {
          pkgs = pkgs;
          system = system;

          modules = [
            { networking.hostName = hostname; }

            # main configuration file
            ./nix/modules/system/configuration.nix

            # hardware configuration
            ./nix/hosts/${hostname}/hardware-configuration.nix

            # role specific configs
            role.${hostname}

            # home manager
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alex = import (./nix/hosts + "/${hostname}/user.nix");
              home-manager.backupFileExtension = "hm-bak";
              home-manager.extraSpecialArgs = {
                inherit inputs;
              };
            }

          ] ++ (extraModuleList.${hostname} );
          specialArgs = { inherit inputs; };
        };

      mkHome =
        system: hostname: username:
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          modules = [
            ./nix/hosts/${hostname}/user.nix
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
    {
      nixosConfigurations = {
        server = mkSystem pkgs "x86_64-linux" "server" "alex-server";
        desktop = mkSystem pkgs "x86_64-linux" "desktop";
      };
      homeConfigurations = {
        wsl = mkHome system "wsl" "apalermo";
        gc-workstation = mkHome system "gc-workstation" "user";
      };
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.gcc
          (pkgs.python313.withPackages (
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
              sioyek
            ]
          ))
        ];
      };
    };
}
