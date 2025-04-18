{ config, lib, inputs, ... }:

{
    imports = [ import ../../modules/default.nix ];
    config.modules = {
        firefox.enable = true;
        fish.enable = true;
        git.enable = true;
        stow.enable = true;
    };
}
