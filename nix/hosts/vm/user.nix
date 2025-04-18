{ config, lib, inputs, ... }:

{
    imports = [ 
        ../../modules/default.nix 
    ];

    # define what will be installed by home manager here
    config.modules = {
       packages.headless.enable = true;
       packages.ui.enable = true;
       git.enable = true;
       stow.enable = true;
    };
    
    # define system packages here
    # view list of available binaries at
    # nix/modules/system_packages/default.nix
    programs.fish.enable = true;
    programs.neovim.enable = true;
    programs.wget.enable = true;
    programs.gcc.enable = true;
    programs.btop.enable = true;
    programs.ncdu.enable = true
}
