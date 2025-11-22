{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let 
  cfg = config.modules.c;
in
{
  options.modules.c.enable = mkEnableOption "Enables C and clangd";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      clang-tools
      clang
      gcc
      gnumake
    ];
  };
}
