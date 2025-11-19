
{
  pkgs,
  ...
}:
{
  imports = [
    ./python.nix
    ./c.nix
    ./lua.nix
    ./go.nix
  ];

  home.packages = with pkgs; [
    nixfmt-rfc-style
    nil
    markdown-oxide
    sqls
    postgrestools
    shfmt
    mdformat
    yamlfix
    pgformatter

  ];
}
