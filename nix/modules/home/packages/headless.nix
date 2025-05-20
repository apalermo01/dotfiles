{ pkgs, lib, config, ... }:


  with lib;

  let 
    cfg = config.modules.packages.headless;
    python = pkgs.python311.withPackages (ps: [
        ps.black
        ps.isort
        ps.sqlfmt
        ps.ipython
        ps.pandas
        ps.numpy
        ps.matplotlib
    ]);
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
        diff-so-fancy
        fzf
        
        # terminal stuff
        yazi
        cbonsai
        fastfetch

        # lsp s
        pyright
        nil
        lua-language-server
        markdown-oxide
        sqls

        # formatters
        stylua
        nixfmt-rfc-style
        shfmt
        mdformat
        yamlfix
        
        # programming languages
        python
        
      ];
    };
}
