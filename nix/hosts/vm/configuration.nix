{ config, lib, inputs, ... }:

{
    imports = [ ../../modules/default.nix ];
    config.modules = {
        firefox.enable = true;
        fish.enable = true;
        git.enable = true;
        stow.enable = true;
    };
}
