{ config, lib, inputs, ... }:

{
    imports = [ 
        ../../modules/home/default.nix 
    ];

    # define what will be installed by home manager here
    config.modules = {
      packages.headless.enable = true;
      packages.ui.enable = true;
      git.enable = true;
      direnv.enable = true;
    };
    
}
