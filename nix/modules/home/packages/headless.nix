{ pkgs, lib, config, ... }:


  with lib;

  let 
    cfg = config.modules.packages.headless;
    python = pkgs.python313.withPackages (ps: [
        ps.black
        ps.isort
        ps.ipython
        ps.pandas
        ps.numpy
        ps.matplotlib
        ps.pip
        ps.sioyek
    ]);
  in {
    options.modules.packages.headless = { enable = mkEnableOption "Headless Packages"; };

    # define things that are installed but not managed by home manager here
    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        # tmux
        # fish
        # zsh
        # neovim
        # sioyek
        # stow
        # fzf
        #
        # terminal stuff
        # yazi
        # cbonsai
        # fastfetch
        # bat
        # eza
        # gitui
        # delta
        # oh-my-posh
        # tealdeer
        # starship

        # lsp s
        # pyright
        # nil
        # lua-language-server
        # markdown-oxide
        # sqls
        # postgrestools

        # formatters
        # stylua
        # nixfmt-rfc-style
        # shfmt
        # mdformat
        # yamlfix
        # pgformatter

        # programming languages
        python
       
        ricer
      ];
    };
}
