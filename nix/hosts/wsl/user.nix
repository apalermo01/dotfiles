{ config, lib, imports, ...}:

{
    imports = [
        ../../modules/home/default.nix
    ];

    config.modules = {
        packages.headless.enable = true;
        git.enable = true;
        direnv.enable = true;
        zoxide.enable = true;
        dbt.enable = true;
    };
}
