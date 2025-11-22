{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.nixlang;
in
{
  options.modules.nixlang.enable = mkEnableOption "Enables nix language server / formatters";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nixfmt-rfc-style
      nil
    ];
  };
}
