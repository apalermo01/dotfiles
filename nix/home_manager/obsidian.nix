{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.obsidian;

in
{
  options.modules.obsidian = {
    enable = mkEnableOption "obsidian";
  };
  config = mkIf cfg.enable {
    home.packages = [
      pkgs.obsidian
    ];
  };
  xdg.desktopEntries = {
    obsidian = {
      name = "Obsidian";
      exec = "${pkgs.obsidian}/bin/obsidian %u";
      type = "Application";
      terminal = false;
      mimeType = [
        "x-scheme-handler/obsidian"
        "text/markdown"
      ];
    };
  };
}
