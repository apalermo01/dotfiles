{ pkgs, lib, config, ... }:


  with lib;

  let 
    cfg = config.modules.packages.home_only;
  in {
    options.modules.packages.home_only = { enable = mkEnableOption "Packages installed in a home-manager only configuration"; };

    # define things that are installed but not managed by home manager here
    config = mkIf cfg.enable {
      home.packages = with pkgs; [
            neovim
            nodejs
            gcc
            cargo
            btop
            ncdu
            direnv
            ripgrep
            zinit
            nixfmt-rfc-style
            killall
            gnumake
            fortune
            cowsay
            pywal
      ];
    };
}
