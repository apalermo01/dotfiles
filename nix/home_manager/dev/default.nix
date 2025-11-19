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
    ./sql.nix
  ];

  home.packages = with pkgs; [
    nixfmt-rfc-style
    nil
    nodejs
    deno
    nest-cli
    markdown-oxide
    shfmt
    mdformat
    yamlfix
    gcc
    cargo
    gnumake

  ];
}
