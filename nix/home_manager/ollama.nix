{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.ollama;
in
{

  # options.modules.ollama = {
  #   enable = mkEnableOption "ollama";
  # };
  # config = mkIf cfg.enable {
  #   home.packages = [ pkgs.ollama ];
  # };
}
