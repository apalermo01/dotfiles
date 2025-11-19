{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let 
  c = config.modules.c;
in
{
  options.c.enable = mkEnableOption "Enables C and clangd";

  config = mkIf c.enable {
    home.packages = with pkgs; [
      clang-tools
      clang
    ];
  };
}
