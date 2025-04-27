{ pkgs, lib, config, ... }:


  with lib;

  let 
    cfg = config.modules.packages.headless;
  in {
    options.modules.packages.headless = { enable = mkEnableOption "Headless Packages"; };

    # define things that are installed but not managed by home manager here
    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        tmux
        fish
        zsh
        neovim
        sioyek
        stow
        fastfetch
        cbonsai

        # lsp stuff
        pyright
        nil
        lua-language-server
        markdown-oxide
      ];
    };
}
