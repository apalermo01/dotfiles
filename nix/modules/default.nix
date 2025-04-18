{ inputs, pkgs, config, ... }:

{
    imports = [
      ./packages/default.nix
    ];
    config = {
      home.stateVersion = "21.03";
      programs.neovim.enable = true;
      programs.git.enable = true;
    };

}
