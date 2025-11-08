
{

  pkgs,
  inputs,
  lib,
  ...
}:

# This is the configuration that is common for ALL systems. More platform
# specific setups are in ./nix/roles
{

  # system packages
  environment.systemPackages = with pkgs; [
    # tree
  ];
}
