{
  pkgs,
  ...
}:
{
  imports = [
    ./c.nix
    ./deno.nix
    ./go.nix
    ./lua.nix
    ./markdown.nix
    ./nest.nix
    ./nixlang.nix
    ./node.nix
    ./python.nix
    ./rust.nix
    ./shfmt.nix
    ./sql.nix
    ./yamlfix.nix
  ];

}
