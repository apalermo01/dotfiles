{ config, lib, imports, ...}:

{

    imports = [
        ../../modules/home/default.nix
    ];
    
    config = {
        programs.direnv.enable = true;
        programs.direnv.nix-direnv.enable = true;

        xdg.configFile."nix/nix.conf".text = ''
            experimental-features = nix-command flakes
        '';

        modules = {
            packages.headless.enable = true;
            git.enable = true;
            direnv.enable = true;
            zoxide.enable = true;

        };
    
    };

}
