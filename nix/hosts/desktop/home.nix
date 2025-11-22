# home manager configuration
{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ../../home_manager/default.nix
  ];

  # define what will be installed by home manager here
  fonts.fontconfig.enable = true;

  modules = {
    # dev tools
    python.enable = true;
    c.enable = true;
    deno.enable = true;
    go.enable = true;
    lua.enable = true;
    markdown.enable = true;
    nest.enable = true;
    nixlang.enable = true;
    node.enable = true;
    rust.enable = true;
    shfmt.enable = true;
    sql.enable = true; 
    yamlfix.enable = true;
    

    zsh.enable = false;
    packages.enable = true;
    ricer.enable = true;
    git.enable = true;
    direnv.enable = true;
    desktop-entries.enable = true;
    obsidian.enable = true;
    freetube.enable = false;
  };

  programs.zoxide.enable = true;
  programs.obs-studio.enable = true;
}
