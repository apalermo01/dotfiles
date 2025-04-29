{ pkgs, lib, config, ... }:


  with lib;

  let 
    cfg = config.modules.packages.headless;
    python = pkgs.python311.withPackages (ps: [
        ps.black
        ps.isort
        ps.sqlfmt
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
        fastfetch
        cbonsai
        diff-so-fancy
        fzf

        # lsp s
        pyright
        nil
        lua-language-server
        markdown-oxide

        # formatters
        stylua
        nixfmt-rfc-style
        python
        shfmt
        mdformat
        yamlfix
        
      ];
    };
}
