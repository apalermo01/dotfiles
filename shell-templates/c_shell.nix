let 
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-25.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

  # mkshellNoCC - uses stdenvNoCC - useful if no c compiler is present
pkgs.mkShell {
    packages = with pkgs; [
      # ncurses
    ];
  }
