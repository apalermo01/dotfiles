{ pkgs, lib, config, ... }:


  with lib;

  let 
    cfg = config.modules.packages.home_only;
  in {
    options.modules.packages.home_only = { enable = mkEnableOption "Packages installed in a home-manager only configuration"; };

    # define things that are installed but not managed by home manager here
    config = mkIf cfg.enable {
      home.packages = with pkgs; [
            # packages / utilities
            neovim
            btop
            ncdu
            direnv
            ripgrep
            zinit
            dbt
            killall
            fortune
            cowsay
            pywal
            
            # language utils
            nixfmt-rfc-style

            # compilers / builders
            gcc
            cargo
            gnumake

            # language runtimes
            nodejs
            go

      ];
    };
}
