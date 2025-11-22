{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.markdown;
in
{
  options.modules.markdown.enable = mkEnableOption "Enables markdown formatters / lsp";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      markdown-oxide
      mdformat
    ];
  };
}
