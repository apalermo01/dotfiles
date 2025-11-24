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
  # fonts.fontconfig.enable = true;

  modules = {
    python.enable = true;
    zsh.enable = true;
    datagrip.enable = true;
    packages.enable = true;
    ricer.enable = true;
    git.enable = true;
    direnv.enable = true;
    nixlang.enable = true;
    shfmt.enable = true;
    sql.enable = true;
    yamlfix.enable = true;
    lua.enable = true;
    markdown.enable = true;
  };

  programs.zoxide.enable = true;
}
